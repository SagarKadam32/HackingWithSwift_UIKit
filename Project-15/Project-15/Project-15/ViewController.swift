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
    
    
    @IBAction func buttonTapped(_ sender: UIButton) {
        sender.isHidden = true

        UIView.animate(withDuration: 1, delay: 0, options: []) {
            switch self.currentAnimation {
            case 0:
                break
            default:
                break
            }
        } completion: { finished in
            sender.isHidden = false
        }

        currentAnimation += 1
        
        
        if currentAnimation > 7 {
            currentAnimation = 0
        }
        
    }
    

}
