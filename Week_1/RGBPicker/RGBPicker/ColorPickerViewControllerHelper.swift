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
    
    private func selectColor (_ color1: Int, _ color2: Int, _ color3: Int) -> UIColor {
        if colorMode == .rgb {
            let redColor = CGFloat(color1) / 255
            let greenColor = CGFloat(color2) / 255
            let blueColor = CGFloat(color3) / 255
            return UIColor(red: redColor, green: greenColor, blue: blueColor, alpha: 1)
        } else {
            let hueDegrees = CGFloat(color1) / 360
            let saturationPercent = CGFloat(color2) / 100
            let brightnessPercent = CGFloat(color3) / 100
            return UIColor(hue: hueDegrees, saturation: saturationPercent, brightness: brightnessPercent, alpha: 1)
        }
    }
    
    private func updateBackgroundColor (_ color1: Int, _ color2: Int, _ color3: Int) {
        view.backgroundColor = selectColor(color1, color2, color3)
    }
    
    func updatePreviewView (_ color1: Int, _ color2: Int, _ color3: Int) {
        previewView.backgroundColor = selectColor(color1, color2, color3)
    }
    
    @objc func setColorHanlder () {
        let alert = UIAlertController(title: "Hey!", message: "Set a name for your color!!", preferredStyle: .alert)
        alert.addTextField(configurationHandler: nil)
        
        let action = UIAlertAction(title: "Ok!", style: .default, handler: { [weak self] action in
            guard let strongSelf = self else { return }
            strongSelf.updateBackgroundColor(
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
        
        myRedView.colorNameLabel.text = "\(myRedView.colorName!): 0"
        myGreenView.colorNameLabel.text = "\(myGreenView.colorName!): 0"
        myBlueView.colorNameLabel.text = "\(myBlueView.colorName!): 0"
        
        currentColorName.text = "Select a BackgroundColor!"
        view.backgroundColor = .white
        previewView.backgroundColor = .black
    }
    
}
