//
//  ViewController.swift
//  flashcard
//
//  Created by kristy delacruz on 9/8/22.
//

import UIKit

class ViewController: UIViewController {

    @IBOutlet weak var answer: UILabel!
    @IBOutlet weak var question: UILabel!
   
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
    }

    @IBAction func didTapFlashCard(_ sender: Any) {
        question.isHidden = true
    }
    
}

