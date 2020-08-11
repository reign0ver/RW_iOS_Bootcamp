//
//  ViewController.swift
//  iOS_Animations
//
//  Created by Andrés Carrillo on 9/08/20.
//  Copyright © 2020 Andrés Carrillo. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    
    //MARK: Constraints to animate
    private var trailingChangeColorConstraint: NSLayoutConstraint!
    private var leadingRotateConstraint: NSLayoutConstraint!
    private var bottomZoomConstraint: NSLayoutConstraint!
    
    private var menuIsHidden = true
    
    override func viewDidLoad() {
        super.viewDidLoad()
        let margin = view.layoutMarginsGuide
        addSubviews()
        setupConstraints(margin)
        
        playButton.addTarget(self, action: #selector(playButtonAction), for: .touchUpInside)
        rotateButton.addTarget(self, action: #selector(rotateAction), for: .touchUpInside)
        changeColorButton.addTarget(self, action: #selector(changeColorAction), for: .touchUpInside)
        zoomButton.addTarget(self, action: #selector(zoomAction), for: .touchUpInside)
    }
    
    //MARK: - Target Actions
    
    @objc
    private func playButtonAction() {
        menuIsHidden = !menuIsHidden
        animateMenu()
        resetAnimations()
    }
    
    @objc
    private func rotateAction() {
        UIView.animate(withDuration: 1) {
            self.objectView.transform = CGAffineTransform(rotationAngle: .pi / 2)
        }
    }
    
    @objc
    private func changeColorAction() {
        UIView.animate(withDuration: 1) {
            self.objectView.backgroundColor = .cyan
        }
    }
    
    @objc
    private func zoomAction() {
        
    }
    
    private func resetAnimations() {
        objectView.backgroundColor = .systemGray
        objectView.transform = .init(translationX: 0, y: 0)
    }
    
    private func animateMenu() {
        setupConstraintsToAnimate()
        UIView.animate(withDuration: 1 / 3,
                       delay: 0,
                       options: .curveEaseIn,
                       animations: {
                        self.changeAlphaToAnimate()
                        self.view.layoutIfNeeded()
                        }
        )
    }
    
    private func setupConstraintsToAnimate() {
        if menuIsHidden {
            trailingChangeColorConstraint.constant = 50
            leadingRotateConstraint.constant = -50
            bottomZoomConstraint.constant = 50
        } else {
            trailingChangeColorConstraint.constant = -32
            leadingRotateConstraint.constant = 32
            bottomZoomConstraint.constant = -32
        }
    }
    
    private func changeAlphaToAnimate() {
        if menuIsHidden {
            changeColorButton.alpha = 0
            rotateButton.alpha = 0
            zoomButton.alpha = 0
        } else {
            changeColorButton.alpha = 1
            rotateButton.alpha = 1
            zoomButton.alpha = 1
        }
    }
    
    //MARK: - Adding views and setting up constraints
    
    private func addSubviews() {
        view.addSubview(playButton)
        view.addSubview(changeColorButton)
        view.addSubview(rotateButton)
        view.addSubview(zoomButton)
        view.addSubview(objectView)
    }

    private func setupConstraints(_ margin: UILayoutGuide) {
        setupPlayButtonConstraints(margin)
        setupChangeColorConstraints(margin)
        setupRotateButtonConstraints(margin)
        setupZoomButtonConstraints(margin)
        objectViewConstraints(margin)
        self.changeColorButton.alpha = 0
        self.rotateButton.alpha = 0
        self.zoomButton.alpha = 0
    }
    
    private func setupPlayButtonConstraints(_ margin: UILayoutGuide) {
        playButton.translatesAutoresizingMaskIntoConstraints = false
        let constraints = [
            playButton.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            playButton.bottomAnchor.constraint(equalTo: margin.bottomAnchor, constant: -32),
            playButton.widthAnchor.constraint(equalToConstant: 50),
            playButton.heightAnchor.constraint(equalToConstant: 50)
        ]
        NSLayoutConstraint.activate(constraints)
    }
    
    private func setupChangeColorConstraints(_ margin: UILayoutGuide) {
        changeColorButton.translatesAutoresizingMaskIntoConstraints = false
        trailingChangeColorConstraint = changeColorButton.trailingAnchor.constraint(equalTo: playButton.leadingAnchor, constant: 50)
        let constraints = [
            trailingChangeColorConstraint!, //tochange
            changeColorButton.bottomAnchor.constraint(equalTo: margin.bottomAnchor, constant: -32),
            changeColorButton.widthAnchor.constraint(equalToConstant: 50),
            changeColorButton.heightAnchor.constraint(equalToConstant: 50)
        ]
        NSLayoutConstraint.activate(constraints)
    }
    
    private func setupRotateButtonConstraints(_ margin: UILayoutGuide) {
        rotateButton.translatesAutoresizingMaskIntoConstraints = false
        leadingRotateConstraint = rotateButton.leadingAnchor.constraint(equalTo: playButton.trailingAnchor, constant: -50)
        let constraints = [
            leadingRotateConstraint!, //tochange
            rotateButton.bottomAnchor.constraint(equalTo: margin.bottomAnchor, constant: -32),
            rotateButton.widthAnchor.constraint(equalToConstant: 50),
            rotateButton.heightAnchor.constraint(equalToConstant: 50)
        ]
        NSLayoutConstraint.activate(constraints)
    }
    
    private func setupZoomButtonConstraints(_ margin: UILayoutGuide) {
        zoomButton.translatesAutoresizingMaskIntoConstraints = false
        bottomZoomConstraint = zoomButton.bottomAnchor.constraint(equalTo: playButton.topAnchor, constant: 50)
        let constraints = [
            zoomButton.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            bottomZoomConstraint!, //tochange
            zoomButton.widthAnchor.constraint(equalToConstant: 50),
            zoomButton.heightAnchor.constraint(equalToConstant: 50)
        ]
        NSLayoutConstraint.activate(constraints)
    }
    
    private func objectViewConstraints(_ margin: UILayoutGuide) {
        objectView.translatesAutoresizingMaskIntoConstraints = false
        let constraints = [
            objectView.bottomAnchor.constraint(lessThanOrEqualTo: playButton.topAnchor, constant: -32),
            objectView.centerYAnchor.constraint(equalTo: view.centerYAnchor, constant: -60),
            objectView.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            objectView.widthAnchor.constraint(equalToConstant: 100),
            objectView.heightAnchor.constraint(equalToConstant: 100)
        ]
        NSLayoutConstraint.activate(constraints)
    }
    
    //MARK: - Creating Views
    
    private let playButton: UIButton = {
        let button = UIButton()
        button.setBackgroundImage(UIImage(named: "play_icon"), for: .normal)
        
        return button
    }()
    
    private let changeColorButton: UIButton = {
        let button = UIButton()
        button.setBackgroundImage(UIImage(named: "change_color"), for: .normal)
        
        return button
    }()
    
    private let rotateButton: UIButton = {
        let button = UIButton()
        button.setBackgroundImage(UIImage(named: "rotation"), for: .normal)
        
        return button
    }()
    
    private let zoomButton: UIButton = {
        let button = UIButton()
        button.setBackgroundImage(UIImage(named: "zoom_icon"), for: .normal)
        
        return button
    }()
    
    private let objectView: UIView = {
        let view = UIView()
        view.backgroundColor = .systemGray
        view.layer.cornerRadius = 6
        
        return view
    }()
    
}

