//
//  GenericSliderComponent.swift
//  RGBPicker
//
//  Created by Andrés on 30/05/20.
//  Copyright © 2020 Andrés Carrillo. All rights reserved.
//

import UIKit

class GenericSliderComponent: UIView {
    
    private var colorName: String?
    private var pickerType: PickerType?
    private var minValue: Int = 0
    private var maxValue: Int = 255
    var currentValue: Int = 0
    
    //MARK: - Init
    
    override init(frame: CGRect) {
        super.init(frame: frame)
    }
    
    init(colorName: String, _ pickerType: PickerType) {
        super.init(frame: .zero)
        self.colorName = colorName
        self.pickerType = pickerType
        addSubviews()
        setupConstraints()
        setupView()
        
        slider.addTarget(self, action: #selector(sliderHandler), for: .valueChanged)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    //MARK: - Lazy vars
    
    lazy var colorNameLabel: UILabel = {
        let label = UILabel()
        label.textColor = .white
        label.text = "\(colorName!): \(currentValue)"
        
        return label
    }()
    
    lazy var slider: UISlider = {
        let slider = UISlider()
        slider.minimumValue = Float(minValue)
        slider.maximumValue = Float(maxValue)
        
        return slider
    }()
    
    lazy var zeroLabel: UILabel = {
        let label = UILabel()
        label.text = "\(minValue)"
        label.textColor = .white
        
        return label
    }()
    
    lazy var currentValueLabel: UILabel = {
        let label = UILabel()
        label.text = "\(maxValue)"
        label.textColor = .white
        
        return label
    }()
    
    lazy var sliderStackView: UIStackView = {
        let stack = UIStackView()
        stack.addArrangedSubview(zeroLabel)
        stack.addArrangedSubview(slider)
        stack.addArrangedSubview(currentValueLabel)
        
        stack.spacing = 8
        stack.axis = .horizontal
        stack.alignment = .fill
        stack.distribution = .fill
        
        return stack
    }()
    
    //MARK: - Adding views and setting up constraints
    
    private func setupView () {
        backgroundColor = .lightGray
        layer.cornerRadius = 6
    }
    
    private func addSubviews () {
        addSubview(colorNameLabel)
        addSubview(sliderStackView)
    }
    
    private func setupConstraints () {
        setupColorNameLabelConstraints()
        setupStackViewConstraints()
    }
    
    private func setupColorNameLabelConstraints () {
        colorNameLabel.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            colorNameLabel.centerXAnchor.constraint(equalTo: self.centerXAnchor),
            colorNameLabel.topAnchor.constraint(equalTo: self.topAnchor, constant: 8)
        ])
    }
    
    private func setupStackViewConstraints () {
        sliderStackView.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            sliderStackView.topAnchor.constraint(equalTo: colorNameLabel.bottomAnchor, constant: 8),
            sliderStackView.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 16),
            sliderStackView.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -16)
        ])
    }
    
    //MARK: - Handler Events
    
    @objc func sliderHandler () {
        let roundedValue = slider.value.rounded()
        currentValue = Int(roundedValue)
        colorNameLabel.text = "\(colorName!): \(currentValue)"
    }
    
}
