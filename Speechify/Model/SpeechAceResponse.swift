//
//  SpeechAceResponse.swift
//  Speechify
//
//  Created by Fariha Jahin on 11/30/24.
//

import Foundation

struct SpeechAceResponse: Codable {
    let status: String
    let quotaRemaining: Int?
    let textScore: TextScore?
    let version: String
    
    enum CodingKeys: String, CodingKey {
        case status
        case quotaRemaining = "quota_remaining"
        case textScore = "text_score"
        case version
    }
}

// Text Score structure
struct TextScore: Codable {
    let text: String
    let wordScoreList: [WordScore]?
    let ieltsScore: ScoreValue
    let pteScore: ScoreValue
    let speechaceScore: ScoreValue
    let toeicScore: ScoreValue
    let cefrscore: ScoreValue
    
    enum CodingKeys: String, CodingKey {
        case text
        case wordScoreList = "word_score_list"
        case ieltsScore = "ielts_score"
        case pteScore = "pte_score"
        case speechaceScore = "speechace_score"
        case toeicScore = "toeic_score"
        case cefrscore = "cefr_score"
    }
}

// Generic score value structure
struct ScoreValue: Codable {
    let pronunciation: Scorable
}

// Allows for different types of scores (numeric or string)
enum Scorable: Codable {
    case int(Int)
    case double(Double)
    case string(String)
    
    init(from decoder: Decoder) throws {
        let container = try decoder.singleValueContainer()
        
        if let intValue = try? container.decode(Int.self) {
            self = .int(intValue)
        } else if let doubleValue = try? container.decode(Double.self) {
            self = .double(doubleValue)
        } else if let stringValue = try? container.decode(String.self) {
            self = .string(stringValue)
        } else {
            throw DecodingError.typeMismatch(Scorable.self, DecodingError.Context(codingPath: decoder.codingPath, debugDescription: "Unable to decode Scorable"))
        }
    }
    
    func encode(to encoder: Encoder) throws {
        var container = encoder.singleValueContainer()
        switch self {
        case .int(let value):
            try container.encode(value)
        case .double(let value):
            try container.encode(value)
        case .string(let value):
            try container.encode(value)
        }
    }
}

// Word Score structure
struct WordScore: Codable {
    let word: String
    let qualityScore: Double
    let phoneScoreList: [PhoneScore]?
    let syllableScoreList: [SyllableScore]
    
    enum CodingKeys: String, CodingKey {
        case word
        case qualityScore = "quality_score"
        case phoneScoreList = "phone_score_list"
        case syllableScoreList = "syllable_score_list"
    }
}

// Phone Score structure
struct PhoneScore: Codable {
    let phone: String
    let stressLevel: Int?
    let extent: [Int]
    let qualityScore: Double
    let stressScore: Double?
    let predictedStressLevel: Int?
    let wordExtent: [Int]
    let soundMostLike: String?
    
    enum CodingKeys: String, CodingKey {
        case phone
        case stressLevel = "stress_level"
        case extent
        case qualityScore = "quality_score"
        case stressScore = "stress_score"
        case predictedStressLevel = "predicted_stress_level"
        case wordExtent = "word_extent"
        case soundMostLike = "sound_most_like"
    }
}

// Syllable Score structure
struct SyllableScore: Codable {
    let phoneCount: Int
    let stressLevel: Int
    let letters: String
    let qualityScore: Double
    let stressScore: Double
    let predictedStressLevel: Int
    let extent: [Int]
    
    enum CodingKeys: String, CodingKey {
        case phoneCount = "phone_count"
        case stressLevel = "stress_level"
        case letters
        case qualityScore = "quality_score"
        case stressScore = "stress_score"
        case predictedStressLevel = "predicted_stress_level"
        case extent
    }
}
