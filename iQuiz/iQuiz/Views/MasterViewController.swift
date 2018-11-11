//
//  ViewController.swift
//  iQuiz
//
//  Created by Rico Wang on 10/28/18.
//  Copyright © 2018 Rico Wang. All rights reserved.
//

import UIKit

import Alamofire

class MasterViewController: UIViewController, UITableViewDelegate {
    
    @IBOutlet weak var tableView: UITableView!
    
    let dataSrc = DataSource(data: DataRepository.instance().getData()!)
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let row = indexPath.row
//        let cat = self.dataSrc.data.cat[row]
//        let alert = UIAlertController(title: "You selected",
//                                      message: cat, preferredStyle: .alert)
        
//        alert.addAction(UIAlertAction(title: "OK", style: .default, handler: nil))
//        self.present(alert, animated: true, completion: nil)
        
        let catID : Int = row
        let questionVC = self.storyboard?.instantiateViewController(withIdentifier: "question") as! QuestionViewController
        
        questionVC.questions = Q().getQ(catID)
        questionVC.answers = A().getA(catID)
        questionVC.i = 0
        questionVC.correct = 0
        questionVC.selected = -1
        
        self.present(questionVC, animated: true, completion: nil)
        
    }
    
    @IBAction func btnSettings(_ sender: Any) {
        let alert = UIAlertController(title: "Settings", message: "You pressed settings", preferredStyle: .alert)
        let alert_action = UIAlertAction(title: "Eh", style: .default, handler: nil)
        
        alert.addAction(alert_action)
        self.present(alert, animated: true)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.tableView.dataSource = self.dataSrc
        self.tableView.delegate = self
    }
}

