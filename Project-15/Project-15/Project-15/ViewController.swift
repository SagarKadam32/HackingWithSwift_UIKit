//
//  ViewController.swift
//  Project-15
//
//  Created by Sagar Kadam on 16/07/22.
//

import UIKit

class ViewController: UIViewController {
    var imageView : UIImageView!
    var currentAnimation = 0

    override func viewDidLoad() {
        super.viewDidLoad()
        imageView = UIImageView(image: UIImage(named: "penguin"))
        imageView.center = CGPoint(x: 512, y: 384)
        view.addSubview(imageView)
    }
    
    
    @IBAction func buttonTapped(_ sender: Any) {
        currentAnimation += 1
        
        if currentAnimation > 7 {
            currentAnimation = 0
        }
        
    }
    

}

