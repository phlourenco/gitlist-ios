//
//  SelectableButton.swift
//  gitlist
//
//  Created by Paulo Lourenço on 25/09/19.
//  Copyright © 2019 Paulo Lourenço. All rights reserved.
//

import UIKit

class SelectableButton: UIButton {
    
    private let checkIcon = "\u{E876}"
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        configure()
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        configure()
    }
    
    private func configure() {
        addTarget(self, action: #selector(tapAction), for: .touchUpInside)
        
        layer.borderColor = UIColor.black.cgColor
        layer.borderWidth = 1.0
        layer.cornerRadius = 4
        tintColor = .clear
        setupStates(title: currentTitle)
    }
    
    private func setupStates(title: String?) {
        setupState(.normal, title: title, textColor: .black, iconColor: .red)
        setupState(.selected, iconCode: checkIcon, title: title, textColor: .white, iconColor: .white)
    }
    
    private func setupState(_ state: UIControl.State, iconCode: String? = nil, title: String?, textColor: UIColor, iconColor: UIColor) {
        let attText = NSMutableAttributedString(string: "")
        
        if let iconCode = iconCode {
            attText.append(NSMutableAttributedString(string: iconCode, attributes: [NSAttributedString.Key.font: UIFont(name: "MaterialIcons-Regular", size: 16)!, NSAttributedString.Key.kern: 8, NSAttributedString.Key.foregroundColor: iconColor, NSAttributedString.Key.baselineOffset: -2]))
        }
        
        let titleBaseline = state == .selected ? 2 : 0
        
        attText.append(NSMutableAttributedString(string: title ?? "", attributes: [NSAttributedString.Key.font: UIFont(name: "Montserrat-SemiBold", size: 12)!, NSAttributedString.Key.foregroundColor: textColor, NSAttributedString.Key.baselineOffset: titleBaseline]))
        
        setAttributedTitle(attText, for: state)
    }
    
    override func setTitle(_ title: String?, for state: UIControl.State) {
        setupStates(title: title)
    }
    
    @objc
    private func tapAction(_ sender: UIButton) {
        UIView.animate(withDuration: 0.3) {
            self.isSelected.toggle()
            self.backgroundColor = self.isSelected ? .black : .clear
        }
    }
    
}
