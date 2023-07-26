//
//  Shots.swift
//  SC_Test 2
//
//  Created by Uday Sidhu on 24/07/23.
//

import Foundation

class Shots: ObservableObject{
    @Published var shots = [Shot](){
        didSet{
            if let encoded = try? JSONEncoder().encode(shots){
                UserDefaults.standard.set(encoded, forKey: "shot")
            }
        }
    }
    
    init(){
        if let savedShots = UserDefaults.standard.data(forKey: "shot"){
            if let decodedShots = try? JSONDecoder().decode([Shot].self, from: savedShots){
                shots = decodedShots
                return
            }
        }
        
        shots = []
    }
}
