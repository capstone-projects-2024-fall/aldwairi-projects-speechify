//
//  NetworkService.swift
//  Speechify
//
//  Created by Fariha Jahin on 11/30/24.
//

import Foundation

import Foundation

class NetworkService {
    private let apiKey: String
    private let baseURL = "https://api.speechace.co/api/scoring/text/v9/json"
    
    init(apiKey: String) {
        self.apiKey = apiKey
    }
    
    func scorePronunciation(word: String, audioFileURL: URL, completion: @escaping (Result<Double, Error>) -> Void) {
        // Create the URL with the API key
        guard let url = URL(string: "\(baseURL)?key=\(apiKey)") else {
            completion(.failure(NSError(domain: "Invalid URL", code: -1, userInfo: nil)))
            return
        }
        
        // Create the multipart form data request
        var request = URLRequest(url: url)
        request.httpMethod = "POST"
        
        let boundary = UUID().uuidString
        request.setValue("multipart/form-data; boundary=\(boundary)", forHTTPHeaderField: "Content-Type")
        
        var body = Data()
        
        // Add text parameter
        body.append("--\(boundary)\r\n".data(using: .utf8)!)
        body.append("Content-Disposition: form-data; name=\"text\"\r\n\r\n".data(using: .utf8)!)
        body.append("\(word)\r\n".data(using: .utf8)!)
        
        // Add audio file
        do {
            let audioData = try Data(contentsOf: audioFileURL)
            body.append("--\(boundary)\r\n".data(using: .utf8)!)
            body.append("Content-Disposition: form-data; name=\"user_audio_file\"; filename=\"recording.m4a\"\r\n".data(using: .utf8)!)
            body.append("Content-Type: audio/m4a\r\n\r\n".data(using: .utf8)!)
            body.append(audioData)
            body.append("\r\n".data(using: .utf8)!)
        } catch {
            completion(.failure(error))
            return
        }
        
        // Close boundary
        body.append("--\(boundary)--\r\n".data(using: .utf8)!)
        
        request.httpBody = body
        
        // Perform the network request
        URLSession.shared.dataTask(with: request) { data, response, error in
            // Check for network errors
            if let error = error {
                completion(.failure(error))
                return
            }
            
            // Check for valid HTTP response
            guard let httpResponse = response as? HTTPURLResponse,
                  (200...299).contains(httpResponse.statusCode) else {
                completion(.failure(NSError(domain: "Invalid Response", code: -2, userInfo: nil)))
                return
            }
            
            // Parse the response
            guard let data = data else {
                completion(.failure(NSError(domain: "No Data", code: -3, userInfo: nil)))
                return
            }
            
            do {
                let decoder = JSONDecoder()
                let speechAceResponse = try decoder.decode(SpeechAceResponse.self, from: data)
                
                // Extract pronunciation score
                let pronunciationScore = self.extractPronunciationScore(from: speechAceResponse)
                completion(.success(pronunciationScore))
            } catch {
                print("Decoding error: \(error)")
                completion(.failure(error))
            }
        }.resume()
    }
    
    private func extractPronunciationScore(from response: SpeechAceResponse) -> Double {
        // Extract pronunciation score from speechace_score
        switch response.textScore?.speechaceScore.pronunciation {
        case .int(let intValue):
            return Double(intValue)
        case .double(let doubleValue):
            return doubleValue
        case .string(_):
            // If it's a string score, return 0 or handle as needed
            return 0
        case .none:
            return 0
        }
    }
}
