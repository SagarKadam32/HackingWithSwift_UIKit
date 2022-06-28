//
//  ViewController.swift
//  Project-2
//
//  Created by Sagar Kadam on 17/06/22.
//

import UIKit

class ViewController: UIViewController {
    
    @IBOutlet weak var button1: UIButton!
    @IBOutlet weak var button2: UIButton!
    @IBOutlet weak var button3: UIButton!
   
    var countries = [String]()
    var score = 0
    var correctAnswer = 0
    var questionsCount = 0
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        countries += ["estonia","france","germany","ireland","italy","monaco","nigeria","poland","russia","spain","uk","us"]
       
        button1.layer.borderWidth = 1
        button2.layer.borderWidth = 1
        button3.layer.borderWidth = 1
        button1.layer.borderColor = UIColor.lightGray.cgColor
        button2.layer.borderColor = UIColor.lightGray.cgColor
        button3.layer.borderColor = UIColor.lightGray.cgColor 
        askQuestions()
        
    }
    
    func askQuestions(action : UIAlertAction! = nil){
        countries.shuffle()
        correctAnswer = Int.random(in: 0...2)
        button1.setImage(UIImage(named: countries[0]), for: .normal)
        button2.setImage(UIImage(named: countries[1]), for: .normal)
        button3.setImage(UIImage(named: countries[2]), for: .normal)
        title = "Find \(countries[correctAnswer].uppercased())\'s Flag ? "
    }
    
    func restartGame(action : UIAlertAction! = nil){
        score = 0
        askQuestions()
    }
    
    @IBAction func buttonTapped(_ sender: UIButton) {
        
        var title: String
        questionsCount += 1
        if sender.tag == correctAnswer {
            title = "Correct"
            score += 1
        }else {
            title = "Incorrect"
            score -= 1
            let ac = UIAlertController(title: "Wrong!!", message: "This is flag of \(countries[sender.tag])", preferredStyle: .alert)
            ac.addAction(UIAlertAction(title: "Continue", style: .default, handler: askQuestions))
            present(ac, animated: true)
        }
        navigationItem.rightBarButtonItem = UIBarButtonItem(title: "Score : \(score)", style: .plain, target: self, action: nil)

        if questionsCount == 10 {
            let ac = UIAlertController(title: "Game Over", message: "You have reached maximum question limit!", preferredStyle: .alert)
            ac.addAction(UIAlertAction(title: "Restart?", style: .default,handler: restartGame))
            present(ac, animated: true)
        }else {
            let ac = UIAlertController(title: title, message: "Your Score is = \(score)", preferredStyle: .alert)
            ac.addAction(UIAlertAction(title: "Continue", style: .default, handler: askQuestions))
            present(ac, animated: true)
        }

    }
}

