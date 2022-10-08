//
//  ViewController.swift
//  flashcard
//
//  Created by kristy delacruz on 9/8/22.
//

import UIKit

struct Flashcard {
    var question: String
    var answer: String
    
}

class ViewController: UIViewController {

    @IBOutlet weak var backLabel: UILabel!
    @IBOutlet weak var frontLabel: UILabel!
    @IBOutlet weak var prevButton: UIButton!
    @IBOutlet weak var nextButton: UIButton!
    
    
    // array to hold flashcard
    var flashCards = [Flashcard]()
    var currentIndex = 0 //current index of flashcard
   
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        readSavedFlashcards()
        if flashCards.count == 0 {
            updateFlashcard(question:frontLabel.text!, answer: backLabel.text!)
        } else {
            updateLabels()
            updateNextPrevButtons()
        }
    }

    @IBAction func didTapFlashCard(_ sender: Any) {
        //allows me to flip between the front label and back
        if frontLabel.isHidden == true {
                    frontLabel.isHidden = false
                } else {
                    frontLabel.isHidden = true
                }
    }
    
    func updateFlashcard(question: String, answer: String){
        let flashCard = Flashcard(question: question, answer: answer)
            
            //adding flashcards to the flashcards array
            flashCards.append(flashCard)
            
            print("Added new flashcard!")
            print("We now have \(flashCards.count) flashcards ")
            
            //update current index
            currentIndex = flashCards.count - 1
            print("Our current index is \(currentIndex)")
            updateNextPrevButtons()
            updateLabels()
            saveAllFlashcardsToDisk()
        
    }
    
    @IBAction func didTapOnPrev(_ sender: Any) {
        currentIndex = currentIndex - 1
        updateLabels()
        // Update buttons
        updateNextPrevButtons()
        
    }
    
    
    @IBAction func didTapOnNext(_ sender: Any) {
        //increase index
        currentIndex = currentIndex + 1
        //update label
        updateLabels()
        //update button
        updateNextPrevButtons()
    }
    
    func updateLabels(){
        let currentFlashcard = flashCards[currentIndex]
        //update labels
        frontLabel.text = currentFlashcard.question
        backLabel.text = currentFlashcard.answer
        
    }
    
    
    func updateNextPrevButtons(){
        
        if currentIndex == flashCards.count - 1 {
            nextButton.isEnabled = false
        } else {
            nextButton.isEnabled = true
        }
        
        if currentIndex == 0 {
            prevButton.isEnabled = false
        } else {
            prevButton.isEnabled = true
        }
        
        
    }
    
    func saveAllFlashcardsToDisk(){
        let dictionaryArray = flashCards.map{ (card) -> [String: String] in
            return ["question": card.question, "answer": card.answer]
        }
        UserDefaults.standard.set(dictionaryArray, forKey: "flashCards")
        
        print("flashcards saved! woohoo")
    }
    
    func readSavedFlashcards(){
        if let dictionaryArray = UserDefaults.standard.array(forKey: "flashCards") as? [[String: String]]{
            let savedCards = dictionaryArray.map{dictionary -> Flashcard in
                return Flashcard(question: dictionary["question"]!, answer: dictionary["answer"]!)
            }
            
            flashCards.append(contentsOf: savedCards)
        }
    }
    

    @IBAction func didTapOnDelete(_ sender: Any) {
               // Show confirmation
               let alert = UIAlertController(title: "Delete flashcard", message: "Are you sure you want to delete it?", preferredStyle: .actionSheet)
               
               let deleteAction = UIAlertAction(title: "Delete", style: .destructive) { action in self.deleteCurrentFlashcard()
               }
               alert.addAction(deleteAction)
               
               let cancelAction = UIAlertAction(title: "Cancel", style: .cancel)
               
               alert.addAction(cancelAction)
               
               present(alert, animated: true)
        
    }
    
    func deleteCurrentFlashcard() {
            
            // Delete current flashcard
            flashCards.remove(at: currentIndex)
            
            // Special case: cgeck if the last card was deleted
            if currentIndex > flashCards.count - 1 {
                currentIndex = flashCards.count - 1
            }
            updateNextPrevButtons()
            updateLabels()
            saveAllFlashcardsToDisk()
        print("Successfully deleted")
        }
    
    
    
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        
        let navigationController = segue.destination as! UINavigationController
        let creationController = navigationController.topViewController as! CreationViewController
        
        creationController.flashcardsController = self
        
        if segue.identifier == "EditSegue" {
            creationController.initialQuestion = frontLabel.text
            creationController.initialAnswer = backLabel.text
            
        }
    }
    
}

