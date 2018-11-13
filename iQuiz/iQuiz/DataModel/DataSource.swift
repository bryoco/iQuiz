//
//  DataSource.swift
//  iQuiz
//
//  Created by Rico Wang on 10/29/18.
//  Copyright © 2018 Rico Wang. All rights reserved.
//

import Foundation
import UIKit

class DataSource : NSObject, UITableViewDataSource {
    
    let data: Cat
    
    init(data: Cat) {
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
