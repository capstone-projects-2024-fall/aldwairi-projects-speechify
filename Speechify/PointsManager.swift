//
//  PointsManager.swift
//  Speechify
//
//  Created by Kevina Nakalunda on 11/7/24.
//
import Foundation

class PointsManager: ObservableObject{
    @Published var points: Int = 0
    
    func addPoints(_ value: Int){
        points += value
        savePoints()
    }
    func loadPoints(){
        points = UserDefaults.standard.integer(forKey: "userPoints")
    }
    func savePoints(){
        UserDefaults.standard.set(points, forKey: "userPoints")
    }
    
    
}
