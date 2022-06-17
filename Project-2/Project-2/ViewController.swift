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
    @IBAction func buttton1Clicked(_ sender: Any) {
        findMatch(countryInButton: countries[0])
    }
    
    @IBAction func buttton2Clicked(_ sender: Any) {
        findMatch(countryInButton: countries[1])
    }
    
    @IBAction func buttton3Clicked(_ sender: Any) {
        findMatch(countryInButton: countries[2])

    }
    
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
    
    func askQuestions(){
        countries.shuffle()
        correctAnswer = Int.random(in: 0...2)
        button1.setImage(UIImage(named: countries[0]), for: .normal)
        button2.setImage(UIImage(named: countries[1]), for: .normal)
        button3.setImage(UIImage(named: countries[2]), for: .normal)
        title = "Find \"\(countries[correctAnswer].uppercased())\" From Below Flags "
    }
    
    func findMatch(countryInButton: String) {
        var matchFound = false
        let targetCountry = countries[correctAnswer]
        if(countryInButton == targetCountry){
            score += 1
            matchFound = true
        }
        var alertTitle = ""
        var alertMessage = ""
        if(matchFound){
            alertTitle = "Bingo!!!"
            alertMessage =  "Your Answer is Correct and your current score is \(score)"
        }else{
            alertTitle = "Oooops!!!"
            alertMessage =  "This is In-Correct"
        }
        
        // Create the alert controller
        let alertController = UIAlertController(title: alertTitle, message: alertMessage, preferredStyle: .alert)

         // Create the actions
        let okAction = UIAlertAction(title: "OK", style: UIAlertAction.Style.default) {
             UIAlertAction in
            self.askQuestions()
         }
        let cancelAction = UIAlertAction(title: "Try again?", style: UIAlertAction.Style.cancel) {
             UIAlertAction in
         }

         // Add the actions
         alertController.addAction(okAction)
         alertController.addAction(cancelAction)

         // Present the controller
        self.present(alertController, animated: true, completion: nil)
    }
}

