//
//  ViewController.swift
//  RGBPicker
//
//  Created by Andrés on 30/05/20.
//  Copyright © 2020 Andrés Carrillo. All rights reserved.
//

import UIKit

class ColorPickerViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        self.view.backgroundColor = .white
        
        let safeAreaLayoutGuide = view.safeAreaLayoutGuide
        
        addViews()
        setupConstraints(safeAreaLayoutGuide)
    }
    
    //MARK: - Lazy vars
    
    lazy var currentColorName: UILabel = {
        let label = UILabel()
        label.text = "Background Color: "
        
        return label
    }()
    
    lazy var myRedView = GenericSliderComponent(colorName: "Red", .rgb)
    
    lazy var myGreenView = GenericSliderComponent(colorName: "Green", .rgb)
    
    lazy var myBlueView = GenericSliderComponent(colorName: "Blue", .rgb)
    
    lazy var setColorButton: UIButton = {
        let button = UIButton(type: .system)
        button.setTitle("Set Color", for: .normal)
        
        return button
    }()
    
    lazy var resetButton: UIButton = {
        let button = UIButton(type: .system)
        button.setTitle("Reset", for: .normal)
        
        return button
    }()
    
    lazy var buttonsStackView: UIStackView = {
        let stack = UIStackView()
        stack.addArrangedSubview(setColorButton)
        stack.addArrangedSubview(resetButton)
        
        stack.spacing = 32
        stack.axis = .horizontal
        stack.alignment = .fill
        stack.distribution = .fill
        
        return stack
    }()
    
    //MARK: - Adding views and setting up constraints
    
    private func addViews () {
        view.addSubview(currentColorName)
        view.addSubview(myRedView)
        view.addSubview(myGreenView)
        view.addSubview(myBlueView)
        view.addSubview(buttonsStackView)
    }
    
    private func setupConstraints (_ safeArea: UILayoutGuide) {
        setupCurrentColorNameConstraints(safeArea)
        setupRedViewConstraints(safeArea)
        setupGreenViewConstraints(safeArea)
        setupBlueViewConstraints(safeArea)
        setupButtonsStackViewConstraints(safeArea)
    }
    
    private func setupCurrentColorNameConstraints (_ safeArea: UILayoutGuide) {
        currentColorName.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            currentColorName.topAnchor.constraint(equalTo: safeArea.topAnchor, constant: 16),
            currentColorName.centerXAnchor.constraint(equalTo: view.centerXAnchor)
        ])
    }
    
    private func setupRedViewConstraints (_ safeArea: UILayoutGuide) {
        myRedView.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            myRedView.topAnchor.constraint(equalTo: currentColorName.bottomAnchor, constant: 12),
            myRedView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 12),
            myRedView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -12),
            myRedView.heightAnchor.constraint(equalToConstant: 100)
        ])
    }
    
    private func setupGreenViewConstraints (_ safeArea: UILayoutGuide) {
        myGreenView.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            myGreenView.topAnchor.constraint(equalTo: myRedView.bottomAnchor, constant: 12),
            myGreenView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 12),
            myGreenView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -12),
            myGreenView.heightAnchor.constraint(equalToConstant: 100)
        ])
    }
    
    private func setupBlueViewConstraints (_ safeArea: UILayoutGuide) {
        myBlueView.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            myBlueView.topAnchor.constraint(equalTo: myGreenView.bottomAnchor, constant: 12),
            myBlueView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 12),
            myBlueView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -12),
            myBlueView.heightAnchor.constraint(equalToConstant: 100)
        ])
    }
    
    private func setupButtonsStackViewConstraints (_ safeArea: UILayoutGuide) {
        buttonsStackView.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            buttonsStackView.topAnchor.constraint(equalTo: myBlueView.bottomAnchor, constant: 12),
            buttonsStackView.centerXAnchor.constraint(equalTo: view.centerXAnchor)
        ])
    }

}

