//
//  ViewController.swift
//  RGBPicker
//
//  Created by Andrés on 30/05/20.
//  Copyright © 2020 Andrés Carrillo. All rights reserved.
//

import UIKit

class ColorPickerViewController: UIViewController {
    
    var safeAreaLayoutGuide: UILayoutGuide!
    var colorMode: PickerType = .rgb
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.view.backgroundColor = .white
        safeAreaLayoutGuide = view.safeAreaLayoutGuide
        addViews()
        setupConstraints(safeAreaLayoutGuide)
        addTargets()
    }
    
    //MARK: - Lazy vars
    
    lazy var currentColorName: UILabel = {
        let label = UILabel()
        label.text = "Select a BackgroundColor!"
        label.font = UIFont.systemFont(ofSize: 18)
        label.textColor = .systemBlue
        
        return label
    }()
    
    lazy var segmentedControl: UISegmentedControl = {
        let sc = UISegmentedControl(items: ["RGB", "HSB"])
        sc.selectedSegmentIndex = 0
        
        return sc
    }()
    
    lazy var myRedView = GenericSliderComponent(colorName: "red", .rgb)
    
    lazy var myGreenView = GenericSliderComponent(colorName: "green", .rgb)
    
    lazy var myBlueView = GenericSliderComponent(colorName: "blue", .rgb)
    
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
    
    lazy var infoButton = UIButton(type: .infoLight)
    
    lazy var previewView: UIView = {
        let view = UIView()
        view.backgroundColor = .black
        view.layer.cornerRadius = 6
        
        return view
    }()
    
    lazy var buttonsStackView: UIStackView = {
        let stack = UIStackView()
        stack.addArrangedSubview(resetButton)
        stack.addArrangedSubview(setColorButton)
        stack.addArrangedSubview(previewView)
        stack.addArrangedSubview(infoButton)
        
        stack.spacing = 18
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
        view.addSubview(segmentedControl)
    }
    
    private func setupConstraints (_ safeArea: UILayoutGuide) {
        setupCurrentColorNameConstraints(safeArea)
        setupSegmentedControlConstraints(safeArea)
        setupRedViewConstraints(safeArea)
        setupGreenViewConstraints(safeArea)
        setupBlueViewConstraints(safeArea)
        setupButtonsStackViewConstraints(safeArea)
        setupPreviewView()
    }
    
    private func setupCurrentColorNameConstraints (_ safeArea: UILayoutGuide) {
        currentColorName.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            currentColorName.topAnchor.constraint(lessThanOrEqualTo: safeArea.topAnchor, constant: 16),
            currentColorName.centerXAnchor.constraint(equalTo: view.centerXAnchor)
        ])
    }
    
    private func setupSegmentedControlConstraints (_ safeArea: UILayoutGuide) {
        segmentedControl.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            segmentedControl.topAnchor.constraint(lessThanOrEqualTo: currentColorName.bottomAnchor, constant: 16),
            segmentedControl.centerXAnchor.constraint(equalTo: view.centerXAnchor)
        ])
    }
    
    private func setupRedViewConstraints (_ safeArea: UILayoutGuide) {
        myRedView.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            myRedView.topAnchor.constraint(equalTo: segmentedControl.bottomAnchor, constant: 12),
            myRedView.leadingAnchor.constraint(equalTo: safeArea.leadingAnchor, constant: 12),
            myRedView.trailingAnchor.constraint(equalTo: safeArea.trailingAnchor, constant: -12),
            myRedView.heightAnchor.constraint(equalToConstant: 90)
        ])
    }
    
    private func setupGreenViewConstraints (_ safeArea: UILayoutGuide) {
        myGreenView.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            myGreenView.topAnchor.constraint(equalTo: myRedView.bottomAnchor, constant: 12),
            myGreenView.leadingAnchor.constraint(equalTo: safeArea.leadingAnchor, constant: 12),
            myGreenView.trailingAnchor.constraint(equalTo: safeArea.trailingAnchor, constant: -12),
            myGreenView.heightAnchor.constraint(equalToConstant: 90)
        ])
    }
    
    private func setupBlueViewConstraints (_ safeArea: UILayoutGuide) {
        myBlueView.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            myBlueView.topAnchor.constraint(equalTo: myGreenView.bottomAnchor, constant: 12),
            myBlueView.leadingAnchor.constraint(equalTo: safeArea.leadingAnchor, constant: 12),
            myBlueView.trailingAnchor.constraint(equalTo: safeArea.trailingAnchor, constant: -12),
            myBlueView.heightAnchor.constraint(equalToConstant: 90)
        ])
    }
    
    private func setupPreviewView () {
        previewView.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            previewView.widthAnchor.constraint(equalToConstant: 24),
            previewView.heightAnchor.constraint(equalToConstant: 24)
        ])
    }
    
    private func setupButtonsStackViewConstraints (_ safeArea: UILayoutGuide) {
        buttonsStackView.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            buttonsStackView.topAnchor.constraint(equalTo: myBlueView.bottomAnchor, constant: 12),
            buttonsStackView.bottomAnchor.constraint(lessThanOrEqualTo: safeArea.bottomAnchor, constant: -8),
            buttonsStackView.centerXAnchor.constraint(equalTo: view.centerXAnchor)
        ])
    }
    
    //MARK: - Handler Events
    
    @objc private func redViewSliderHandler () {
        let roundedValue = myRedView.slider.value.rounded()
        myRedView.currentValue = Int(roundedValue)
        myRedView.colorNameLabel.text = "\(myRedView.colorName!): \(myRedView.currentValue)"
        updatePreviewView(myRedView.currentValue, myGreenView.currentValue, myBlueView.currentValue)
    }
    
    @objc private func greenViewSliderHandler () {
        let roundedValue = myGreenView.slider.value.rounded()
        myGreenView.currentValue = Int(roundedValue)
        myGreenView.colorNameLabel.text = "\(myGreenView.colorName!): \(myGreenView.currentValue)"
        updatePreviewView(myRedView.currentValue, myGreenView.currentValue, myBlueView.currentValue)
    }
    
    @objc private func blueViewSliderHandler () {
        let roundedValue = myBlueView.slider.value.rounded()
        myBlueView.currentValue = Int(roundedValue)
        myBlueView.colorNameLabel.text = "\(myBlueView.colorName!): \(myBlueView.currentValue)"
        updatePreviewView(myRedView.currentValue, myGreenView.currentValue, myBlueView.currentValue)
    }
    
    @objc private func goToWikipediaInfo () {
        let viewController = AboutRGBViewController()
        viewController.modalPresentationStyle = .fullScreen
        present(viewController, animated: true, completion: nil)
    }
    
    @objc private func segmentedHandler () {
        let segmentedIndex = segmentedControl.selectedSegmentIndex
        changeView(segmentedIndex)
        print(segmentedIndex)
    }
    
    private func addTargets () {
        myRedView.slider.addTarget(self, action: #selector(redViewSliderHandler), for: .valueChanged)
        myGreenView.slider.addTarget(self, action: #selector(greenViewSliderHandler), for: .valueChanged)
        myBlueView.slider.addTarget(self, action: #selector(blueViewSliderHandler), for: .valueChanged)
        
        // Buttons targets
        
        setColorButton.addTarget(self, action: #selector(setColorHanlder), for: .touchUpInside)
        resetButton.addTarget(self, action: #selector(restartEverything), for: .touchUpInside)
        infoButton.addTarget(self, action: #selector(goToWikipediaInfo), for: .touchUpInside)
        
        segmentedControl.addTarget(self, action: #selector(segmentedHandler), for: .valueChanged)
    }
    
    private func changeView (_ segmentedIndex: Int) {
        colorMode = segmentedIndex == 0 ? .rgb : .hsb
        
        myRedView.pickerType = segmentedIndex == 0 ? .rgb : .hsb
        myGreenView.pickerType = segmentedIndex == 0 ? .rgb : .hsb
        myBlueView.pickerType = segmentedIndex == 0 ? .rgb : .hsb
        
        if segmentedIndex == 0 {
            myRedView.currentValue = myRedView.currentValue > 255 ? 255 : myRedView.currentValue
        }
        
        // Updating values
        myRedView.colorName = myRedView.pickerType == .rgb ? "RED" : "HUE"
        myGreenView.colorName = myGreenView.pickerType == .rgb ? "GREEN" : "SATURATION"
        myBlueView.colorName = myBlueView.pickerType == .rgb ? "BLUE" : "BRIGHTNESS"
        
        myRedView.maxValue = myRedView.pickerType == .rgb ? 255 : 360
        myGreenView.maxValue = myGreenView.pickerType == .rgb ? 255 : 100
        myBlueView.maxValue = myBlueView.pickerType == .rgb ? 255 : 100
        
        // Updating labels
        myRedView.colorNameLabel.text = "\(myRedView.colorName!): \(myRedView.currentValue)"
        myGreenView.colorNameLabel.text = "\(myGreenView.colorName!): \(myGreenView.currentValue)"
        myBlueView.colorNameLabel.text = "\(myBlueView.colorName!): \(myBlueView.currentValue)"
        
        myRedView.maxValueLabel.text = "\(myRedView.maxValue)"
        myGreenView.maxValueLabel.text = "\(myGreenView.maxValue)"
        myBlueView.maxValueLabel.text = "\(myBlueView.maxValue)"
        
        myRedView.slider.maximumValue = Float(myRedView.maxValue)
        myGreenView.slider.maximumValue = Float(myGreenView.maxValue)
        myBlueView.slider.maximumValue = Float(myBlueView.maxValue)
        
        updatePreviewView(myRedView.currentValue, myGreenView.currentValue, myBlueView.currentValue)
    }
    
}

