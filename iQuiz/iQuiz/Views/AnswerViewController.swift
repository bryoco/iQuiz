//
//  AnswerViewController.swift
//  iQuiz
//
//  Created by Rico Wang on 10/29/18.
//  Copyright © 2018 Rico Wang. All rights reserved.
//

import UIKit

class AnswerViewController: UIViewController {

    @IBOutlet weak var lblQuestion: UILabel!
    @IBOutlet weak var lblAnswer: UILabel!
    @IBOutlet weak var lblIsCorrect: UILabel!
    
    // Data for this VC
    var question: String!
    var answer: String!
    var isCorrect: Bool!
    
    // Data carried over to next VC
    var questions: [String]!
    var answers: [[String]]!
    var i: Int?
    var correct: Int!
    
    @IBAction func btnContinuePressed(_ sender: Any) {
        
        let j = i! + 0

        if j >= questions!.count {
            
            let finishVC = self.storyboard?.instantiateViewController(withIdentifier: "finish") as! FinishViewController
            
            finishVC.correct = self.correct
            finishVC.numQuestions = self.questions.count
            
            self.present(finishVC, animated: true, completion: nil)
            
        } else {
            
            // Create initializer for questionVC, pass in params and create VC
            let questionVC = self.storyboard?.instantiateViewController(withIdentifier: "question") as! QuestionViewController
            
            questionVC.questions = self.questions
            questionVC.answers = self.answers
            questionVC.i = self.i
            questionVC.correct = self.correct
            questionVC.selected = -1
            
            self.present(questionVC, animated: true, completion: nil)
            
        }
    }
    
    @objc func handleSwipe(sender: UISwipeGestureRecognizer) {
        if sender.state == .ended {
            switch sender.direction {
            case .left:
                self.btnContinuePressed(self)
            default:
                break
            }
            
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        if self.isCorrect {
            self.lblIsCorrect.text = "Correct!"
            self.lblIsCorrect.textColor = UIColor.green
        } else {
            self.lblIsCorrect.text = "Wrong!"
            self.lblIsCorrect.textColor = UIColor.red
        }
        
        self.lblQuestion.text = self.question
        self.lblAnswer.text = self.answer
        
        // Adding swipes
        let leftSwipe = UISwipeGestureRecognizer(target: self, action: #selector(handleSwipe(sender:)))
        leftSwipe.direction = .left
        self.view.addGestureRecognizer(leftSwipe)
        
    }

}
