//
//  ViewController.swift
//  Project-18
//
//  Created by Sagar Kadam on 17/07/22.
//

import UIKit

class ViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        
        print(1,2,3,4,5,separator: "-")
        print(10,20,30,40,50,terminator: "\n")
        
        assert(1 == 1, "Math Failure..")
    //    assert(1 == 2, "Math Failure !!!")
        
        for i in 1...100 {
            print("Current value of i = \(i)")
        }

    }


}

