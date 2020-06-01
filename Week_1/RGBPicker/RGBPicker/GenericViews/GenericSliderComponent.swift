//
//  GenericSliderComponent.swift
//  RGBPicker
//
//  Created by Andrés on 30/05/20.
//  Copyright © 2020 Andrés Carrillo. All rights reserved.
//

import UIKit

class GenericSliderComponent: UIView {
    
    var colorName: String!
    var pickerType: PickerType!
    var minValue: Int = 0
    var maxValue: Int = 255
    var currentValue: Int = 0
    
    //MARK: - Init
    
    override init(frame: CGRect) {
        super.init(frame: frame)
    }
    
    init(colorName: String, _ pickerType: PickerType) {
        super.init(frame: .zero)
        self.colorName = colorName.uppercased()
        self.pickerType = pickerType
        addSubviews()
        setupConstraints()
        setupView()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    //MARK: - Lazy vars
    
    lazy var colorNameLabel: UILabel = {
        let label = UILabel()
        label.textColor = .darkGray
        label.text = "\(colorName!): \(currentValue)"
        
        return label
    }()
    
    lazy var slider: UISlider = {
        let slider = UISlider()
        slider.minimumValue = Float(minValue)
        slider.maximumValue = Float(maxValue)
        slider.tintColor = UIColor(named: colorName!.lowercased())
        slider.thumbTintColor = UIColor(named: colorName!.lowercased())
        
        return slider
    }()
    
    lazy var zeroLabel: UILabel = {
        let label = UILabel()
        label.text = "\(minValue)"
        label.textColor = .darkGray
        
        return label
    }()
    
    lazy var maxValueLabel: UILabel = {
        let label = UILabel()
        label.text = "\(maxValue)"
        label.textColor = .darkGray
        
        return label
    }()
    
    lazy private var sliderStackView: UIStackView = {
        let stack = UIStackView()
        stack.addArrangedSubview(zeroLabel)
        stack.addArrangedSubview(slider)
        stack.addArrangedSubview(maxValueLabel)
        
        stack.spacing = 8
        stack.axis = .horizontal
        stack.alignment = .fill
        stack.distribution = .fill
        
        return stack
    }()
    
    //MARK: - Adding views and setting up constraints
    
    private func setupView () {
        backgroundColor = .lightText
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
    
}
