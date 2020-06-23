//
//  ViewController.swift
//  CompatibilitySlider-Start
//
//  Created by Jay Strawn on 6/16/20.
//  Copyright © 2020 Jay Strawn. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    @IBOutlet weak var compatibilityItemLabel: UILabel!
    @IBOutlet weak var slider: UISlider!
    @IBOutlet weak var questionLabel: UILabel!

    var compatibilityItems = ["Cats",
                              "Dogs",
                              "Icecreams",
                              "Cutie Lovie Movies",
                              "Helping people",
                              "Charity",
                              "Emphaty",
                              "Earth"
    ]
    var currentItemIndex = 0

    var person1 = Person(id: 1, items: [:])
    var person2 = Person(id: 2, items: [:])
    var currentPerson: Person?

    override func viewDidLoad() {
        super.viewDidLoad()
        questionLabel.text = "Person 1.  How do you feel about...?"
        compatibilityItemLabel.text = compatibilityItems[currentItemIndex]
        currentPerson = person1
    }

    @IBAction func sliderValueChanged(_ sender: UISlider) {
        
    }

    @IBAction func didPressNextItemButton(_ sender: Any) {
        let endOfArray = currentItemIndex == compatibilityItems.count - 1
        if endOfArray {
            if endOfArray && currentPerson == person2 {
                let compatibilityScore = calculateCompatibility()
                showAlert(title: "Your compatibility percentage is: ", message: compatibilityScore)
            }
            resetRound(person2)
        }
        saveCurrentScore()
    }
    
    private func saveCurrentScore () {
        let roundedValue = slider.value.rounded()
        currentPerson?.items.updateValue(roundedValue, forKey: compatibilityItems[currentItemIndex])
        currentItemIndex += 1
        compatibilityItemLabel.text = compatibilityItems[currentItemIndex]
    }
    
    private func resetRound (_ currentPerson: Person) {
        self.currentPerson = currentPerson
        questionLabel.text = "Person \(currentPerson.id).  How do you feel about...?"
        currentItemIndex = 0
    }
    
    private func showAlert (title: String, message: String) {
        let alert = UIAlertController(title: title, message: message, preferredStyle: .alert)
        let okAction = UIAlertAction(title: "OK", style: .default, handler: nil)
        alert.addAction(okAction)
        self.present(alert, animated: true) { [weak self] in
            guard let strongSelf = self else { return }
            strongSelf.resetRound(strongSelf.person1)
        }
    }

    func calculateCompatibility() -> String {
        // If diff 0.0 is 100% and 5.0 is 0%, calculate match percentage
        var percentagesForAllItems: [Double] = []

        for (key, person1Rating) in person1.items {
            let person2Rating = person2.items[key] ?? 0
            let difference = abs(person1Rating - person2Rating)/5.0
            percentagesForAllItems.append(Double(difference))
        }

        let sumOfAllPercentages = percentagesForAllItems.reduce(0, +)
        let matchPercentage = sumOfAllPercentages/Double(compatibilityItems.count)
        print(matchPercentage, "%")
        let matchString = 100 - (matchPercentage * 100).rounded()
        return "\(matchString)%"
    }

}

