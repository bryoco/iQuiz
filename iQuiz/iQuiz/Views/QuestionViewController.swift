//
//  QuestionViewController.swift
//  iQuiz
//
//  Created by Rico Wang on 10/29/18.
//  Copyright © 2018 Rico Wang. All rights reserved.
//

import UIKit

class QuestionViewController: UIViewController {

    @IBOutlet weak var lblQuestion: UILabel!
    @IBOutlet weak var btnChoice1: UIButton!
    @IBOutlet weak var btnChoice2: UIButton!
    @IBOutlet weak var btnChoice3: UIButton!
    @IBOutlet weak var btnChoice4: UIButton!
    @IBOutlet var btnsChoice: [UIStackView]!
    
    var questions: [String]?
    var answers: [[String]]?
    
    var i: Int!
    var correct: Int!
    var selected: Int!
    var isCorrect: Bool! = false
    
    @IBAction func btnBack(_ sender: Any) {
        let master = self.storyboard?.instantiateViewController(withIdentifier: "master")
        self.present(master!, animated: true, completion: nil)
    }
    
    @IBAction func btnContinue(_ sender: Any) {
        
        if self.selected! == -1 {
            
            let alert = UIAlertController(title: "Invalid answer", message: "Please make a choice before continuing", preferredStyle: .alert)
            alert.addAction(UIAlertAction(title: "OK", style: .default, handler: nil))
            self.present(alert, animated: true, completion: nil)
            
        } else {
            
            if self.selected! == 0 {
                self.isCorrect = true
            }
            
            let answerVC = self.storyboard?.instantiateViewController(withIdentifier: "answer") as! AnswerViewController
            
            // displaying data
            answerVC.question = self.questions![i]
            answerVC.answer = self.answers![i][0]
            
            // carried-over data
            answerVC.questions = self.questions!
            answerVC.answers = self.answers!
            answerVC.i = self.i + 1
            answerVC.isCorrect = self.isCorrect
            
            if self.isCorrect {
                answerVC.correct = self.correct! + 1
            } else {
                answerVC.correct = self.correct
            }
            
            self.present(answerVC, animated: true, completion: nil)
        }
    }
    
    // TODO: refactor this
    @IBAction func btnChoice1Pressed(_ sender: Any) {
        self.selected = 0
        self.btnChoice1.setTitleColor(UIColor(red: 116/255, green: 91/255, blue: 255/255, alpha: 1.0), for: .normal)
        self.btnChoice2.setTitleColor(UIColor.lightGray, for: .normal)
        self.btnChoice3.setTitleColor(UIColor.lightGray, for: .normal)
        self.btnChoice4.setTitleColor(UIColor.lightGray, for: .normal)
    }
    
    @IBAction func btnChoice2Pressed(_ sender: Any) {
        self.selected = 1
        self.btnChoice2.setTitleColor(UIColor(red: 116/255, green: 91/255, blue: 255/255, alpha: 1.0), for: .normal)
        self.btnChoice1.setTitleColor(UIColor.lightGray, for: .normal)
        self.btnChoice3.setTitleColor(UIColor.lightGray, for: .normal)
        self.btnChoice4.setTitleColor(UIColor.lightGray, for: .normal)
    }
    
    @IBAction func btnChoice3Pressed(_ sender: Any) {
        self.selected = 2
        self.btnChoice3.setTitleColor(UIColor(red: 116/255, green: 91/255, blue: 255/255, alpha: 1.0), for: .normal)
        self.btnChoice1.setTitleColor(UIColor.lightGray, for: .normal)
        self.btnChoice2.setTitleColor(UIColor.lightGray, for: .normal)
        self.btnChoice4.setTitleColor(UIColor.lightGray, for: .normal)
    }
    
    @IBAction func btnChoice4Pressed(_ sender: Any) {
        self.selected = 3
        self.btnChoice4.setTitleColor(UIColor(red: 116/255, green: 91/255, blue: 255/255, alpha: 1.0), for: .normal)
        self.btnChoice1.setTitleColor(UIColor.lightGray, for: .normal)
        self.btnChoice2.setTitleColor(UIColor.lightGray, for: .normal)
        self.btnChoice3.setTitleColor(UIColor.lightGray, for: .normal)
    }
    
    // Swipe handler
    @objc func handleSwipe(sender: UISwipeGestureRecognizer) {
        if sender.state == .ended {
            switch sender.direction {
            case .left:
                self.btnContinue(self)
            case .right:
                self.btnBack(self)
            default:
                break
            }
            
        }
    }
    
    // TODO: randomize questions
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // TODO: properly check for inputs
        if answers == nil {
            assert(false, "answer is nil")
        }
        
        if answers![i].count != 4 {
            assert(false, "incorrect number of answers in the pool")
        }
        
        if self.questions == nil {
            assert(false, "question pool is nil")
        }
        
        if i >= self.questions!.count  {
            assert(false, "question count incorrect")
        }
        
        // Adding swipes
        let leftSwipe = UISwipeGestureRecognizer(target: self, action: #selector(handleSwipe(sender:)))
        leftSwipe.direction = .left
        self.view.addGestureRecognizer(leftSwipe)
        
        let rightSwipe = UISwipeGestureRecognizer(target: self, action: #selector(handleSwipe(sender:)))
        self.view.addGestureRecognizer(rightSwipe)
        
        // Filling question
        self.lblQuestion.text = questions![i]
        
        // Filling answers
        let btns = [self.btnChoice1, self.btnChoice2, self.btnChoice3, self.btnChoice4]
        var n = 0
        for btn in btns {
            btn!.setTitle(answers![i][n], for: .normal)
            n += 1
        }
    }
}
