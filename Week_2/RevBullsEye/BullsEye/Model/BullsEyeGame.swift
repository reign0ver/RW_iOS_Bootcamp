//
//  BullsEyeGame.swift
//  BullsEye
//
//  Created by Andrés on 7/06/20.
//  Copyright © 2020 Andrés Carrillo. All rights reserved.
//

import Foundation

class BullsEyeGame {
    
    //Could be an object with this properties :thinking_face:
    var currentValue = 0
    var targetValue = 0
    var score = 0
    var round = 0
    
    private func calculateDiference () -> Int {
        return abs(targetValue - currentValue)
    }
    
    func calculatePoints () -> (points: Int, message: String) {
        let difference = calculateDiference()
        
        var points = 100 - difference
        
        let title: String
        if difference == 0 {
            title = "Perfect!"
            points += 100
        } else if difference < 5 {
            title = "You almost had it!"
            if difference == 1 {
                points += 50
            }
        } else if difference < 10 {
            title = "Pretty good!"
        } else {
            title = "Not even close..."
        }
        
        score += points
        return (points, title)
    }
    
    func startNewRound () {
        round += 1
        targetValue = getRandomNumberBetween1and100()
        currentValue = 50
    }
    
    func startNewGame () {
        score = 0
        round = 0
        startNewRound()
    }
    
    private func getRandomNumberBetween1and100 () -> Int {
        return Int.random(in: 1...100)
    }
    
}
