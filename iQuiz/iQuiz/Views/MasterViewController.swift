//
//  ViewController.swift
//  iQuiz
//
//  Created by Rico Wang on 10/28/18.
//  Copyright © 2018 Rico Wang. All rights reserved.
//

// TODO: when using customized data, MasterVC does not preserve downloaded data
// write to disk and then check if local data exists?

// ✓ Download JSON
// X Store the quiz data locally
// ✓ Use local storage when offline
// ✓ Check Now
// ✓ Offline Notification
// X Settings
// ✓ Download Fail

import UIKit
import SystemConfiguration

import Alamofire
import SwiftyJSON

class MasterViewController: UIViewController, UITableViewDelegate {
    
    @IBOutlet weak var tableView: UITableView!
    
    @IBOutlet weak var btnSettings: UIBarButtonItem!
    
    let metadata = Metadata.init() // <- TODO: sharing metadata between views.
    
    var q: Q = Q(questions: nil)
    var a: A = A(answers: nil)
//    var cat: Cat = Cat(cat: nil, catDesc: nil, catImg: nil)

    var dataSrc = DataSource(data: DataRepository.instance().getData(nil, nil, nil)!)
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
        
        let alert = UIAlertController(title: "Settings", message: "Please enter your data URL", preferredStyle: .alert)
        
        var textField = UITextField()
        
        alert.addTextField(configurationHandler: {{ (theTextField : UITextField) in
            textField = theTextField
            textField.placeholder = "https://localhost:80/data.json"
            }}())
        
        let cancelAction = UIAlertAction(title: "Cancel", style: .default, handler: nil)
        
        let okAction = UIAlertAction(title: "Check Now", style: .default, handler: {
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
        
        print("setting useCustomizedData")
        
        self.metadata.setUseCustomizedData(true)
        
        DispatchQueue.global().async {
        
            let task = URLSession.shared.dataTask(with: url) { (data, response, error) in

                guard let data = data, error == nil else {
                    print(error?.localizedDescription ?? "Download failed")
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
    //                print("cat \(cat)")
    //                print("catDesc \(catDesc)")
    //                print("answers \(answers)")
    //                print("questionsText \(questionsText)")
                    
                    // Reconstruct data
                    self.q = Q(questions: questionsText)
                    self.a = A(answers: answers)
                    
                    // Refresh current tableview
                    self.dataSrc = DataSource(data: DataRepository.instance().getData(cat, catDesc, nil)!)
                    
                    DispatchQueue.main.async {
                        self.tableView.dataSource = self.dataSrc
                        self.tableView.delegate = self
                    }
                    
                } catch let e {
                    print("Error", e)
                }
            }
            task.resume()
        }
    }
    
    func isConnectedToNetwork() -> Bool {
        
        var zeroAddress = sockaddr_in(sin_len: 0, sin_family: 0, sin_port: 0, sin_addr: in_addr(s_addr: 0), sin_zero: (0, 0, 0, 0, 0, 0, 0, 0))
        zeroAddress.sin_len = UInt8(MemoryLayout.size(ofValue: zeroAddress))
        zeroAddress.sin_family = sa_family_t(AF_INET)
        
        let defaultRouteReachability = withUnsafePointer(to: &zeroAddress) {
            $0.withMemoryRebound(to: sockaddr.self, capacity: 1) {zeroSockAddress in
                SCNetworkReachabilityCreateWithAddress(nil, zeroSockAddress)
            }
        }
        
        var flags: SCNetworkReachabilityFlags = SCNetworkReachabilityFlags(rawValue: 0)
        if SCNetworkReachabilityGetFlags(defaultRouteReachability!, &flags) == false {
            return false
        }
        
        // Working for Cellular and WIFI
        let isReachable = (flags.rawValue & UInt32(kSCNetworkFlagsReachable)) != 0
        let needsConnection = (flags.rawValue & UInt32(kSCNetworkFlagsConnectionRequired)) != 0
        let ret = (isReachable && !needsConnection)
        
        return ret
    }
    
    // OTHER
    override func viewDidLoad() {
        super.viewDidLoad()
        
        print("did load triggered")
        print(self.metadata.getUseCustomizedData())
        
        self.tableView.dataSource = self.dataSrc
        self.tableView.delegate = self
        
        if self.metadata.getUseCustomizedData() {
            print("use data triggered")
            self.getJSON(defaultURL)
        }
        
        if !isConnectedToNetwork() {
            self.btnSettings.isEnabled = false
            
            let alert = UIAlertController(title: "No Internet connection", message: "Data download disabled", preferredStyle: .alert)
            alert.addAction(UIAlertAction(title: "Cancel", style: .default, handler: nil))
            self.present(alert, animated: true)
        }
        
    }
}

