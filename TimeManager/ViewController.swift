//
//  ViewController.swift
//  TimeManager
//
//  Created by João Victor Fernandes on 13/03/25.
//

import UIKit

class ViewController: UIViewController {

    @IBOutlet var outletButton: [UIButton]!

    var timer: [String: Int] = ["walk": 40, "run": 30, "exercise": 60]
    
    override func viewDidLoad() {
        for item in outletButton {
            item.layer.cornerRadius = 28
        }
        super.viewDidLoad()
    }
}

