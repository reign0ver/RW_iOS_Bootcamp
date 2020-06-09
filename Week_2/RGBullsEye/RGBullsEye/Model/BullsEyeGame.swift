/*
* Copyright (c) 2015 Razeware LLC
*
* Permission is hereby granted, free of charge, to any person obtaining a copy
* of this software and associated documentation files (the "Software"), to deal
* in the Software without restriction, including without limitation the rights
* to use, copy, modify, merge, publish, distribute, sublicense, and/or sell
* copies of the Software, and to permit persons to whom the Software is
* furnished to do so, subject to the following conditions:
*
* The above copyright notice and this permission notice shall be included in
* all copies or substantial portions of the Software.
*
* THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
* IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
* FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE
* AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
* LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
* OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN
* THE SOFTWARE.
*/

import Foundation

class BullsEyeGame {
    
    var currentValue = RGB()
    var targetValue = RGB()
    var score = 0
    var round = 0
    
    //calculate difference
    
    private func calculateDiference () -> Double {
        return abs(currentValue.difference(target: targetValue)) * 100
    }
    
    func calculatePoints () -> (points: Int, message: String) {
        let difference = calculateDiference()
        
        var points = Int(100 - difference)
        
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
        let (red, green, blue) = getRandomNumberBetween0and255()
        targetValue = RGB(r: red, g: green, b: blue)
        currentValue = RGB()
        round += 1
    }
    
    func startNewGame () {
        score = 0
        round = 0
        startNewRound()
    }
    
    private func getRandomNumberBetween0and255 () -> (red: Int, green:Int, blue: Int) {
        return (Int.random(in: 1...255),
                Int.random(in: 1...255),
                Int.random(in: 1...255))
    }
    
}
