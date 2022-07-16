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
    
    override func viewWillAppear(_ animated: Bool) {
        

    }
    
    func askQuestions(action : UIAlertAction! = nil){
        countries.shuffle()
        correctAnswer = Int.random(in: 0...2)
        button1.setImage(UIImage(named: countries[0]), for: .normal)
        button2.setImage(UIImage(named: countries[1]), for: .normal)
        button3.setImage(UIImage(named: countries[2]), for: .normal)
        title = "Find \(countries[correctAnswer].uppercased())\'s Flag ? "
        showCongratsMessage()
     }
    
    func restartGame(action : UIAlertAction! = nil){
        score = 0
        askQuestions()
    }
    
    func showCongratsMessage() {
        let defaults = UserDefaults.standard
        let previousScore = defaults.integer(forKey: "score")
        
        /*
        if(score > 0 && score > previousScore){
            let ac = UIAlertController(title: "Congrats!!", message: "You have broke your previous score..", preferredStyle: .alert)
            ac.addAction(UIAlertAction(title: "Continue", style: .default, handler: askQuestions))
            present(ac, animated: true)
        }*/
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
        
        let defaults = UserDefaults.standard
        let previousScore = defaults.integer(forKey: "score")

        if(score > 0 && score > previousScore){
            defaults.set(score, forKey: "score")
        }
        
        navigationItem.rightBarButtonItem = UIBarButtonItem(title: "Score : \(score)", style: .plain, target: self, action: nil)
        
        UIView.animate(withDuration: 1, delay: 0, options: []) {
            sender.transform = CGAffineTransform(scaleX: 0.5, y: 0.5)
        } completion: { isFinished in
            sender.transform = .identity
        }


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

