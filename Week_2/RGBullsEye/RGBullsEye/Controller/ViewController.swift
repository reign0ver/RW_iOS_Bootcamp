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

import UIKit

class ViewController: UIViewController {
    @IBOutlet weak var targetLabel: UILabel!
    @IBOutlet weak var targetTextLabel: UILabel!
    @IBOutlet weak var guessLabel: UILabel!
    
    @IBOutlet weak var redLabel: UILabel!
    @IBOutlet weak var greenLabel: UILabel!
    @IBOutlet weak var blueLabel: UILabel!
    
    @IBOutlet weak var redSlider: UISlider!
    @IBOutlet weak var greenSlider: UISlider!
    @IBOutlet weak var blueSlider: UISlider!
    
    @IBOutlet weak var roundLabel: UILabel!
    @IBOutlet weak var scoreLabel: UILabel!
    
    let game = BullsEyeGame()
    var rgb = RGB()
    
    @IBAction func aSliderMoved(sender: UISlider) {
        let red = Int(redSlider.value.rounded())
        let green = Int(greenSlider.value.rounded())
        let blue = Int(blueSlider.value.rounded())
        game.currentValue = RGB(r: red, g: green, b: blue)
        updateGuessViews()
    }
    
    @IBAction func showAlert(sender: AnyObject) {
        let (points, title) = game.calculatePoints()
        
        let message = "You scored \(points) points"
        
        let alert = UIAlertController(title: title, message: message, preferredStyle: .alert)
        
        let action = UIAlertAction(title: "OK", style: .default) { [weak self] action in
            guard let strongSelf = self else { return }
            strongSelf.game.startNewRound()
            strongSelf.updateView()
        }
        
        alert.addAction(action)
        
        self.present(alert, animated: true, completion: nil)
    }
    
    @IBAction func startOver(sender: AnyObject) {
        game.startNewGame()
        updateView()
    }
    
    func updateView() {
        targetLabel.backgroundColor = UIColor(rgbStruct: game.targetValue)
        scoreLabel.text = String(game.score)
        roundLabel.text = String(game.round)
        redSlider.value = 255 / 2
        greenSlider.value = 255 / 2
        blueSlider.value = 255 / 2
        updateGuessViews()
    }
    
    func updateGuessViews () {
        let currentValue = game.currentValue
        guessLabel.backgroundColor = UIColor(rgbStruct: currentValue)
        redLabel.text = "R: \(currentValue.r)"
        greenLabel.text = "G: \(currentValue.g)"
        blueLabel.text = "B: \(currentValue.b)"
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        game.startNewGame()
        updateView()
    }
}

