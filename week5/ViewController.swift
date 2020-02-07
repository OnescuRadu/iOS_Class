//
//  ViewController.swift
//  HelloWorld
//
//  Created by Radu Onescu on 07/02/2020.
//  Copyright © 2020 Radu Onescu. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    @IBOutlet weak var textLabel: UILabel!
    @IBOutlet weak var textField: UITextField!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
    }
    @IBAction func submitBtn(_ sender: Any) {
        if let name = textField.text , textField.text != "" {
            print("test")
            textLabel.text = "Hello \(name)!"
        }
    }
    
    
    
}

