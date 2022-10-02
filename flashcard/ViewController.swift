//
//  ViewController.swift
//  flashcard
//
//  Created by kristy delacruz on 9/8/22.
//

import UIKit

class ViewController: UIViewController {

    @IBOutlet weak var backLabel: UILabel!
    @IBOutlet weak var frontLabel: UILabel!
   
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
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
        frontLabel.text = question
        backLabel.text = answer
    }

    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        
        let navigationController = segue.destination as! UINavigationController
        let creationController = navigationController.topViewController as! CreationViewController
        
        creationController.flashcardsController = self
        
        if segue.identifier == "edit" {
            // creationController.initialQuestion = frontLabel.text
            // creationController.initialAnswer = backLabel.text
        }
    }
    
}

