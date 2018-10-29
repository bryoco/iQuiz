//
//  ViewController.swift
//  iQuiz
//
//  Created by Rico Wang on 10/28/18.
//  Copyright © 2018 Rico Wang. All rights reserved.
//

import UIKit

class Data {
    // Data source
    let cat : [String] = ["Informatics", "Computer Science and Engineering", "Japanese"]
    let catDesc : [String] = ["Major where you get lots of love",
                               "Major where you get little love",
                               "Major where you get good amount of love"]
    let catImg : [UIImage] = [UIImage(named: "INFO")!, UIImage(named: "CSE")!, UIImage(named: "ASIAN")!]
}

class DataRepository {
    
    static func instance() -> DataRepository {
        return theInstance
    }
    
    private static let theInstance = DataRepository()
    
    func getData() -> Data? {
        return Data()
    }
}

class DataSource : NSObject, UITableViewDataSource {
    
    let data : Data
    
    init(data : Data) {
        self.data = data
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.data.cat.count
    }
    
    func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        return "Major Placeholder"
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        var cell = tableView.dequeueReusableCell(withIdentifier: "cell")
        let row = indexPath.row
        
        if cell == nil {
            cell = UITableViewCell(style: .subtitle, reuseIdentifier: "cell")
        }
        
        cell!.textLabel?.text = self.data.cat[row]
        cell!.detailTextLabel?.text = self.data.catDesc[row]
        cell!.imageView?.image = self.data.catImg[row]
        
        return cell!
    }
    
    
}



class ViewController: UIViewController, UITableViewDelegate {
    
    let dataSrc = DataSource(data: DataRepository.instance().getData()!)
    
    @IBOutlet weak var tableView: UITableView!
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let row = indexPath.row
        let cat = self.dataSrc.data.cat[row]
        let alert = UIAlertController(title: "You selected",
                                      message: cat, preferredStyle: .alert)
        
        alert.addAction(UIAlertAction(title: "OK", style: .default, handler: nil))
        self.present(alert, animated: true, completion: nil)
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

