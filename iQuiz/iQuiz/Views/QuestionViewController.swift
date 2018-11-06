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
    
    // TODO: to remove
    @IBOutlet weak var btnChoice1: UIButton!
    @IBOutlet weak var btnChoice2: UIButton!
    @IBOutlet weak var btnChoice3: UIButton!
    @IBOutlet weak var btnChoice4: UIButton!
    
    // Create buttons
    let btn1 = UIButton(type: .infoLight)
    let btn2 = UIButton(type: .infoLight)
    let btn3 = UIButton(type: .infoLight)
    let btn4 = UIButton(type: .infoLight)
    @IBOutlet var btnsStackView: [UIStackView]!
    
    var questions: [String]?
    var answers: [[String]]?
    
    var i: Int!     // current no. of question
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
    
//    @IBAction func btnChoice1Pressed(_ sender: Any) {
//        self.selected = 0
//        self.btnChoice1.setTitleColor(UIColor(red: 116/255, green: 91/255, blue: 255/255, alpha: 1.0), for: .normal)
//        self.resetButtons(self.selected)
//    }
//
//    @IBAction func btnChoice2Pressed(_ sender: Any) {
//        self.selected = 1
//        self.btnChoice2.setTitleColor(UIColor(red: 116/255, green: 91/255, blue: 255/255, alpha: 1.0), for: .normal)
//        self.resetButtons(self.selected)
//    }
//
//    @IBAction func btnChoice3Pressed(_ sender: Any) {
//        self.selected = 2
//        self.btnChoice3.setTitleColor(UIColor(red: 116/255, green: 91/255, blue: 255/255, alpha: 1.0), for: .normal)
//        self.resetButtons(self.selected)
//    }
//
//    @IBAction func btnChoice4Pressed(_ sender: Any) {
//        self.selected = 3
//        self.btnChoice4.setTitleColor(UIColor(red: 116/255, green: 91/255, blue: 255/255, alpha: 1.0), for: .normal)
//        self.resetButtons(self.selected)
//    }
    
    @objc func btn1Pressed() {
        self.selected = 0
        self.btn1.setTitleColor(UIColor(red: 116/255, green: 91/255, blue: 255/255, alpha: 1.0), for: .normal)
        self.resetButtons(self.selected)
    }

    @objc func btn2Pressed() {
        self.selected = 1
        self.btn2.setTitleColor(UIColor(red: 116/255, green: 91/255, blue: 255/255, alpha: 1.0), for: .normal)
        self.resetButtons(self.selected)
    }
    
    @objc func btn3Pressed() {
        self.selected = 2
        self.btn3.setTitleColor(UIColor(red: 116/255, green: 91/255, blue: 255/255, alpha: 1.0), for: .normal)
        self.resetButtons(self.selected)
    }
    
    @objc func btn4Pressed() {
        self.selected = 3
        self.btn3.setTitleColor(UIColor(red: 116/255, green: 91/255, blue: 255/255, alpha: 1.0), for: .normal)
        self.resetButtons(self.selected)
    }
    
    func resetButtons(_ n: Int) {
//        let btns = [self.btnChoice1, self.btnChoice2, self.btnChoice3, self.btnChoice4]
        let btns = [self.btn1, self.btn2, self.btn3, self.btn4]
        for i in 0..<btns.count {
            if n != i {
                btns[i].setTitleColor(UIColor.lightGray, for: .normal)
            }
        }
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
    
    // on viewDidLoad():
    // -> generate 4 buttons
    // -> bind them to btn funcs
    // -> put them in an array and randomize the array
    // -> inject into btnStackView
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
        rightSwipe.direction = .right               // just to be safe
        self.view.addGestureRecognizer(rightSwipe)
        
        // Filling question
        self.lblQuestion.text = questions![i]
        
        // Filling answers
        let btns = [btn1, btn2, btn3, btn4]
        var n = 0
        for btn in btns as [UIButton] {
            btn.setTitle(answers![i][n], for: .normal)
            n += 1
        }
        
        // Binding actions
        btn1.addTarget(self, action: #selector(btn1Pressed), for: .touchUpInside)
        btn2.addTarget(self, action: #selector(btn2Pressed), for: .touchUpInside)
        btn3.addTarget(self, action: #selector(btn3Pressed), for: .touchUpInside)
        btn4.addTarget(self, action: #selector(btn4Pressed), for: .touchUpInside)
        
        var btnsCount = btns.count
        
        while btns.count != 0 {
            let i = arc4random_uniform(UInt32(btnsCount)) + 0
//            self.btnsStackView.shuffle() WHAT??????
            
        }
        
//        let btns = [self.btnChoice1, self.btnChoice2, self.btnChoice3, self.btnChoice4]
//        var n = 0
//        for btn in btns {
//            btn!.setTitle(answers![i][n], for: .normal)
//            n += 1
//        }
    }
}
