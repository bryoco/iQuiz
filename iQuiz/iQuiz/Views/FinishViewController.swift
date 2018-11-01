//
//  FinishViewController.swift
//  iQuiz
//
//  Created by Rico Wang on 10/29/18.
//  Copyright © 2018 Rico Wang. All rights reserved.
//

import UIKit

class FinishViewController: UIViewController {
    
    @IBOutlet weak var lblComment: UILabel!
    @IBOutlet weak var lblStats: UILabel!
    
    var correct: Int!
    var numQuestions: Int!

    @IBAction func btnRestartPressed(_ sender: Any) {
        let master = self.storyboard?.instantiateViewController(withIdentifier: "master")
        self.present(master!, animated: true, completion: nil)
    }
    
    // Swipe handler
    @objc func handleSwipe(sender: UISwipeGestureRecognizer) {
        if sender.state == .ended {
            switch sender.direction {
            case .right:
                self.btnRestartPressed(self)
            default:
                break
            }
            
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let stats: Float = Float(correct) / Float(numQuestions)
        
        if stats > 0.8 {
            self.lblComment.text = "You did well!"
            self.lblComment.textColor = UIColor.green
        } else if stats > 0.5 {
            self.lblComment.text = "You did eh."
            self.lblComment.textColor = UIColor.yellow
        } else {
            self.lblComment.text = "You are a disappointment to your major."
            self.lblComment.textColor = UIColor.red
        }
        
        self.lblStats.text = "Out of \(String(describing: self.numQuestions!)), you got \(String(describing: self.correct!)) right."
        
        // Adding swipes
        let rightSwipe = UISwipeGestureRecognizer(target: self, action: #selector(handleSwipe(sender:)))
        self.view.addGestureRecognizer(rightSwipe)
    }
}
