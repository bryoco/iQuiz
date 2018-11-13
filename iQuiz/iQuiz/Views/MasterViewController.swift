//
//  ViewController.swift
//  iQuiz
//
//  Created by Rico Wang on 10/28/18.
//  Copyright © 2018 Rico Wang. All rights reserved.
//

import UIKit

import Alamofire
import SwiftyJSON

class MasterViewController: UIViewController, UITableViewDelegate {
    
    @IBOutlet weak var tableView: UITableView!
    
    let dataSrc = DataSource(data: DataRepository.instance().getData()!)
    
    var useCustomizedData: Bool = false
    var q: Q = Q(questions: nil)
    var a: A = A(answers: nil)
    var cat: Cat = Cat(cat: nil, catDesc: nil, catImg: nil)
    
    var defaultURL = "https://tednewardsandbox.site44.com/questions.json"

    
    // UI
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let row = indexPath.row
        let catID : Int = row
        let questionVC = self.storyboard?.instantiateViewController(withIdentifier: "question") as! QuestionViewController
        
        questionVC.questions = q.getQ(catID)
        questionVC.answers = a.getA(catID)
        
        questionVC.i = 0
        questionVC.correct = 0
        questionVC.selected = -1
                
        self.present(questionVC, animated: true, completion: nil)
    }
    
    @IBAction func btnSettings(_ sender: Any) {
        // ref: https://stackoverflow.com/questions/31922349/how-to-add-textfield-to-uialertcontroller-in-swift
        
        let alert = UIAlertController(title: "Settings", message: "Please enter your data URL", preferredStyle: .alert)
        
        var textField = UITextField()
        
        alert.addTextField(configurationHandler: {{ (theTextField : UITextField) in
            textField = theTextField
            textField.placeholder = "http://tednewardsandbox.site44.com/questions.json"
            }}())
        
        let cancelAction = UIAlertAction(title: "Cancel", style: .default, handler: nil)
        
        let okAction = UIAlertAction(title: "OK", style: .default, handler: {
            (action : UIAlertAction) in
            if textField.text != "" && textField.text != nil {

                // TODO change this
//                self.getJSON(textField.text!)
                self.getJSON(self.defaultURL)
            }
        })
        
        alert.addAction(cancelAction)
        alert.addAction(okAction)
        
        self.present(alert, animated: true)
    }
    
    
    
    // NETWORK
    func getJSON(_ url: String) {
        
        guard let url = URL(string: url) else {
            print("bad URL")
            return
        }
        
        useCustomizedData = true
        
        let task = URLSession.shared.dataTask(with: url) { (data, response, error) in

            guard let data = data, error == nil else {
                print(error?.localizedDescription ?? "Response Error")
                return
            }
            
            do {

                // Serializing JSON
                let serializedJSON = try JSONSerialization.jsonObject(with: data, options: [])
                
                // Making a dictionary
                guard let jsonArray = serializedJSON as? [[String: Any]] else {
                    print("got nothing")
                    return
                }
                
                // Data models
                var cat: [String] = []
                var catDesc: [String] = []
                var answers: [[[String]]] = []
                var questionsText: [[String]] = []
                
                var questionArray: [NSArray] = []
                
                for json in jsonArray {
                    
                    // Cats
                    guard let title = json["title"] as? String else { return }
                    cat.append(title)
                    guard let desc = json["desc"] as? String else { return }
                    catDesc.append(desc)
                    
                    guard let questions = json["questions"] as? NSArray else {
                        print("got nothing")
                        return
                    }
                    
                    questionArray.append(questions)
                }

                
                for question in questionArray {
                    
                    var questionText: [String] = []
                    var answerList: [[String]] = []
                    
                    for q in question {
                        
                        let arrayDict: [String: Any] = q as! [String : Any]
                        
                        // As
                        guard var ans = arrayDict["answers"]! as? [String] else { return }
                        guard let correctAnswer = arrayDict["answer"] as? String else { return }
                        // Swapping positions
                        let correctAnswerInt: Int? = Int(correctAnswer) ?? -1
                        let tmpCorrectAnswer = ans.remove(at: correctAnswerInt! - 1)
                        ans.insert(tmpCorrectAnswer, at: 0)
                        answerList.append(ans)
                        
                        // Qs
                        guard let qt = arrayDict["text"] as? String else { return }
                        questionText.append(qt)
                        
                    }
                    
                    answers.append(answerList)
                    questionsText.append(questionText)
                }
                
                // print here
                print("cat \(cat)")
                print("catDesc \(catDesc)")
                print("answers \(answers)")
                print("questionsText \(questionsText)")
                
                // Reconstruct data
                self.q = Q(questions: questionsText)
                self.a = A(answers: answers)
                self.cat = Cat(cat: cat, catDesc: catDesc, catImg: nil)
                
            } catch let e {
                print("Error", e)
            }
        }
        
        task.resume()
    }
    
    // OTHER
    override func viewDidLoad() {
        super.viewDidLoad()
        
        if useCustomizedData {
            self.getJSON(defaultURL)
        }
        
        self.tableView.dataSource = self.dataSrc
        self.tableView.delegate = self
    }
}

