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
    
    @IBOutlet var btnsChoice: [UIStackView]!
    
    @IBOutlet weak var btnChoice1: UIButton!
    @IBOutlet weak var btnChoice2: UIButton!
    @IBOutlet weak var btnChoice3: UIButton!
    @IBOutlet weak var btnChoice4: UIButton!
    
    var questions: [String]?
    var answers: [[String]]?
    
    var i: Int!
    var correct: Int!
    var selected: Int!
    
    @IBAction func btnBack(_ sender: Any) {
        let master = self.storyboard?.instantiateViewController(withIdentifier: "master")
        self.present(master!, animated: true, completion: nil)
    }
    
    @IBAction func btnContinue(_ sender: Any) {
        // ...
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        
        // TODO: properly check for inputs
        if answers == nil {
            assert(false, "answer is nil")
        }
        
        if answers?.count != 4 {
            assert(false, "incorrect number of answers in the pool")
        }
        
        if self.questions == nil {
            assert(false, "question pool is nil")
        }
        
        self.lblQuestion.text = questions![i]
        self.btnChoice1.setTitle(answers![i][0], for: .normal)
        self.btnChoice2.setTitle(answers![i][1], for: .normal)
        self.btnChoice3.setTitle(answers![i][2], for: .normal)
        self.btnChoice4.setTitle(answers![i][3], for: .normal)
        
        
//        // hmmmmmmm
//        self.btnsChoice.randomElement()
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
