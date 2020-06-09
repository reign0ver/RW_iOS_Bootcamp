//
//  ViewController.swift
//  BullsEye
//
//  Created by Ray Wenderlich on 6/13/18.
//  Copyright © 2018 Ray Wenderlich. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    
    var game = BullsEyeGame()
    
    @IBOutlet weak var slider: UISlider!
    @IBOutlet weak var currentTextField: UITextField!
    @IBOutlet weak var scoreLabel: UILabel!
    @IBOutlet weak var roundLabel: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        game.startNewGame()
        updateView()
        currentTextField.keyboardType = .numberPad
    }
    
    @IBAction func showAlert() {
        
        let (points, title) = game.calculatePoints()
        
        let message = "You scored \(points) points"
        
        let alert = UIAlertController(title: title, message: message, preferredStyle: .alert)
        
        let action = UIAlertAction(title: "OK", style: .default, handler: { [weak self] action in
            guard let strongSelf = self else { return }
            strongSelf.game.startNewRound()
            strongSelf.updateView()
        })
        
        alert.addAction(action)
        
        present(alert, animated: true, completion: nil)
        
    }
    
    @IBAction func sliderMoved(_ slider: UISlider) {
//        let roundedValue = slider.value.rounded()
//        game.currentValue = Int(roundedValue)
    }
    
    func updateView() {
        currentTextField.text = String(game.currentValue)  // DONE
        scoreLabel.text = String(game.score)
        roundLabel.text = String(game.round)
        slider.value = Float(game.targetValue)
    }
    
    @IBAction func startNewGame() {
        game.startNewGame()
        updateView()
    }
    
}

extension ViewController: UITextFieldDelegate {
    
    func textFieldDidBeginEditing(_ textField: UITextField) {
        if let myTargetNumber = Int(textField.text ?? "") {
            game.currentValue = myTargetNumber
        } else {
            let alert = UIAlertController(title: "Ups", message: "Only numbers allowed", preferredStyle: .alert)
            let action = UIAlertAction(title: "OK", style: .default, handler: nil)
            alert.addAction(action)
            
            present(alert, animated: true, completion: nil)
        }
    }
    
}



