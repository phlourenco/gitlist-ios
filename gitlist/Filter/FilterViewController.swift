//
//  FilterViewController.swift
//  gitlist
//
//  Created by Paulo Lourenço on 25/09/19.
//  Copyright © 2019 Paulo Lourenço. All rights reserved.
//

import UIKit

class FilterViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
    
    @IBAction func clearAction(_ sender: Any) {
    }
    
    @IBAction func applyAction(_ sender: Any) {
    }
    
    @IBAction func backAction(_ sender: Any) {
        navigationController?.popViewController(animated: true)
    }
    

}
