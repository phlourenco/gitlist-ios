//
//  OutlineButton.swift
//  gitlist
//
//  Created by Paulo Lourenço on 25/09/19.
//  Copyright © 2019 Paulo Lourenço. All rights reserved.
//

import UIKit

class OutlineButton: UIButton {
    
    private let closeIcon = "\u{E14C}"
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        configure()
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        configure()
    }
    
    private func configure() {
        contentEdgeInsets = UIEdgeInsets(top: 0, left: 8, bottom: 0, right: -8)
        backgroundColor = .clear
        layer.borderColor = UIColor.black.cgColor
        layer.borderWidth = 1.0
        layer.cornerRadius = 4
        tintColor = .clear
        titleLabel?.textAlignment = .center
        setupTitle(currentTitle)
    }
    
    private func setupTitle(_ title: String?) {
        let attText = NSMutableAttributedString(string: title ?? "", attributes: [NSAttributedString.Key.font: UIFont.italicSystemFont(ofSize: 12), NSAttributedString.Key.foregroundColor: UIColor.black, NSAttributedString.Key.baselineOffset: 2])
        
        attText.append(NSMutableAttributedString(string: closeIcon, attributes: [NSAttributedString.Key.font: UIFont(name: "MaterialIcons-Regular", size: 16)!, NSAttributedString.Key.kern: 16, NSAttributedString.Key.foregroundColor: UIColor.black, NSAttributedString.Key.baselineOffset: -2]))
        
        setAttributedTitle(attText, for: state)
    }
    
    override func setTitle(_ title: String?, for state: UIControl.State) {
        setupTitle(title)
    }
    
}
