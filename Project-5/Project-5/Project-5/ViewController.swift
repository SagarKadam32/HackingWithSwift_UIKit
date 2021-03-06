//
//  ViewController.swift
//  Project-5
//
//  Created by Sagar Kadam on 26/06/22.
//

import UIKit

class ViewController: UITableViewController {
    var allWords = [String]()
    var usedWords = [String]()

    override func viewDidLoad() {
        super.viewDidLoad()
        navigationItem.leftBarButtonItem = UIBarButtonItem(title: "Start New Game", style: .plain, target: self, action: #selector(startGame))
        navigationItem.rightBarButtonItem = UIBarButtonItem(barButtonSystemItem: .add, target: self, action: #selector(promptForAnswer))

        if let startWordsURL = Bundle.main.url(forResource: "start", withExtension: "txt") {
            if let startWords = try? String(contentsOf: startWordsURL) {
                allWords = startWords.components(separatedBy: "\n")
            }
        }
        
        if allWords.isEmpty {
            allWords = ["silkworm"]
        }
      
        let defaults = UserDefaults.standard
        let lastSavedTitle = defaults.string(forKey: "currentWord")
        let usedSavedWords = defaults.object(forKey: "usedWords") as? [String]

        if lastSavedTitle != nil {
            title = lastSavedTitle
        }
        if let usedSavedWords = usedSavedWords {
            usedWords = usedSavedWords
        }

        // startGame()
    }
    
    override func viewDidDisappear(_ animated: Bool) {
        let defaults = UserDefaults.standard
        defaults.set(title,forKey: "currentWord")
    }
    
    @objc func startGame() {
        title = allWords.randomElement()
        let defaults = UserDefaults.standard
        defaults.set(title,forKey: "currentWord")
        usedWords.removeAll(keepingCapacity: true)
        tableView.reloadData()
    }
    
    @objc func promptForAnswer() {
        let ac =  UIAlertController(title: "Enter answer", message: nil, preferredStyle: .alert)
        ac.addTextField()
        
        let submitAction = UIAlertAction(title: "Submit", style: .default) {
            [weak self, weak ac] action in
            guard let answer = ac?.textFields?[0].text else {return}
            self?.submit(answer)
            
        }
        
        ac.addAction(submitAction)
        present(ac, animated: true)
        
    }
    
    func submit(_ answer: String) {
        let lowerAnser = answer.lowercased()
        if isPossible(word: lowerAnser){
            if isOriginal(word: lowerAnser) {
                if isReal(word: lowerAnser) {
                    usedWords.insert(lowerAnser, at: 0)
                    let defaults = UserDefaults.standard
                    defaults.set(usedWords, forKey: "usedWords")
                    let indexPath = IndexPath(row: 0, section: 0)
                    tableView.insertRows(at: [indexPath], with: .automatic)
                    return
                }else{
                    showErrorMessage(errorTitle: "Word not recognised", errorMessage: "You cant just make them up, you know!")
                }
            }else {
                showErrorMessage(errorTitle: "Word already used", errorMessage: "Be more original!")
            }
        }else {
            guard let title = title else {return}
            showErrorMessage(errorTitle: "Word not possible", errorMessage: "You can't spell that word from \(title.lowercased())")
        }
        

    }
    
    func isPossible(word: String) -> Bool {
        guard var tempWord = title?.lowercased() else { return false}
        
        for letter in word {
            if let position = tempWord.firstIndex(of: letter) {
                tempWord.remove(at: position)
            }else {
                return false
            }
        }
        
         return true
    }
    
    func isOriginal(word: String) -> Bool {
        return !usedWords.contains(word)
    }
    
    func isReal(word: String) -> Bool {
        var isRealWord = false
        let wordLength = word.utf16.count
        
        if wordLength < 3 {
            return isRealWord
        }else {
            let checker = UITextChecker()
            let range = NSRange(location: 0, length: word.utf16.count)
            let misspelledRange = checker.rangeOfMisspelledWord(in: word, range: range, startingAt: 0, wrap: false, language: "en")
            if misspelledRange.location == NSNotFound {
                isRealWord = true
            }
        }
        return isRealWord
    }
    
    func showErrorMessage(errorTitle: String, errorMessage: String){
        let ac = UIAlertController(title: errorTitle, message: errorMessage, preferredStyle: .alert)
        ac.addAction(UIAlertAction(title: "OK", style: .default))
        present(ac, animated: true)
    }
    
    
}

extension ViewController {
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return usedWords.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "Word", for: indexPath)
        cell.textLabel?.text = usedWords[indexPath.row]
        return cell
    }
}

