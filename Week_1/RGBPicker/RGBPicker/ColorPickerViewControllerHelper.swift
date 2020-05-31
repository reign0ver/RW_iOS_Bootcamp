//
//  ViewControllerHelper.swift
//  RGBPicker
//
//  Created by Andrés on 30/05/20.
//  Copyright © 2020 Andrés Carrillo. All rights reserved.
//

import Foundation
import UIKit

extension ColorPickerViewController {
    
    private func updateUI (_ red: Int, _ green: Int, _ blue: Int) {
        let redColor = CGFloat(red) / 255
        let greenColor = CGFloat(green) / 255
        let blueColor = CGFloat(blue) / 255
        self.view.backgroundColor = UIColor(red: redColor, green: greenColor, blue: blueColor, alpha: 1)
    }
    
    @objc func setColorHanlder () {
        let alert = UIAlertController(title: "Hey!", message: "Set a name for your color!!", preferredStyle: .alert)
        alert.addTextField(configurationHandler: nil)
        
        let action = UIAlertAction(title: "Ok!", style: .default, handler: { [weak self] action in
            guard let strongSelf = self else { return }
            strongSelf.updateUI(
                strongSelf.myRedView.currentValue,
                strongSelf.myGreenView.currentValue,
                strongSelf.myBlueView.currentValue)
            
            if let textField = alert.textFields?.first {
                if textField.text == "" || textField.text == nil {
                    strongSelf.currentColorName.text = "BackgroundColor Name: "
                } else {
                    strongSelf.currentColorName.text = "BackgroundColor Name: \(textField.text!)"
                }
            }
        })

        alert.addAction(action)
        
        present(alert, animated: true, completion: nil)
    }
    
    @objc func restartEverything () {
        myRedView.slider.value = 0
        myGreenView.slider.value = 0
        myBlueView.slider.value = 0
        currentColorName.text = "Select a BackgroundColor!"
        self.view.backgroundColor = .white
    }
    
}
