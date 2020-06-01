//
//  AboutRGBViewController.swift
//  RGBPicker
//
//  Created by Andrés on 31/05/20.
//  Copyright © 2020 Andrés Carrillo. All rights reserved.
//

import UIKit
import WebKit

class AboutRGBViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
        
        let safeAreaLayoutGuide = view.safeAreaLayoutGuide
        addViews()
        setupConstraints(safeAreaLayoutGuide)
        setupWebview()
        
        closeButton.addTarget(self, action: #selector(closeAction), for: .touchUpInside)
    }
    
    //MARK: - Lazy vars
    
    lazy private var webView = WKWebView()
    
    lazy private var closeButton: UIButton = {
        let button = UIButton(type: .system)
        button.setTitle("Close", for: .normal)
        button.titleLabel!.font = UIFont.systemFont(ofSize: 18)
        
        return button
    }()
    
    //MARK: - Setting up
    
    private func setupWebview () {
        if let url = URL(string: "https://en.wikipedia.org/wiki/RGB_color_model") {
            let request = URLRequest(url: url)
            webView.load(request)
        }
    }
    
    private func addViews () {
        view.addSubview(webView)
        view.addSubview(closeButton)
    }
    
    private func setupConstraints (_ safeArea: UILayoutGuide) {
        setupWebviewConstraints(safeArea)
        setupCloseButtonConstraints(safeArea)
    }
    
    private func setupCloseButtonConstraints (_ safeArea: UILayoutGuide) {
        closeButton.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            closeButton.topAnchor.constraint(equalTo: safeArea.topAnchor),
            closeButton.leadingAnchor.constraint(equalTo: safeArea.leadingAnchor, constant: 8)
        ])
    }
    
    private func setupWebviewConstraints (_ safeArea: UILayoutGuide) {
        webView.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            webView.topAnchor.constraint(equalTo: closeButton.bottomAnchor, constant: 8),
            webView.leadingAnchor.constraint(equalTo: safeArea.leadingAnchor),
            webView.bottomAnchor.constraint(equalTo: view.bottomAnchor),
            webView.trailingAnchor.constraint(equalTo: safeArea.trailingAnchor),
        ])
    }
    
    //MARK: - Actions
    
    @objc private func closeAction () {
        dismiss(animated: true, completion: nil)
    }
    
}
