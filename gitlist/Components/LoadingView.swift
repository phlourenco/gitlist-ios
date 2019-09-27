//
//  LoadingView.swift
//  gitlist
//
//  Created by Paulo Henrique Lima Lourenco on 27/09/19.
//  Copyright © 2019 Paulo Lourenço. All rights reserved.
//

import UIKit

class LoadingView: UIView {
    
    // MARK: - View lifecycle
    
    override func layoutSubviews() {
        super.layoutSubviews()
        accessibilityIdentifier = "LoadingView"
        setup()
    }
    
    // MARK: - Private methods
    
    private func setup() {
        backgroundColor = .clear
        let activityIndicator = UIActivityIndicatorView(style: .gray)
        activityIndicator.translatesAutoresizingMaskIntoConstraints = false
        activityIndicator.startAnimating()
        addSubview(activityIndicator)
        NSLayoutConstraint.activate([
            activityIndicator.centerXAnchor.constraint(equalTo: centerXAnchor),
            activityIndicator.centerYAnchor.constraint(equalTo: centerYAnchor)
            ])
    }
    
}
