//
//  Cat.swift
//  iQuiz
//
//  Created by Rico Wang on 10/29/18.
//  Copyright © 2018 Rico Wang. All rights reserved.
//

import Foundation
import UIKit

struct Cat {
    
    var cat: [String]
    var catDesc: [String]
    var catImg : [UIImage]
    
    init(cat: [String]?, catDesc: [String]?, catImg: [UIImage]?) {
        
        self.cat = cat ?? ["Informatics", "Computer Science and Engineering", "Japanese"]
        self.catDesc = catDesc ?? ["Major where you get lots of love",
                                   "Major where you get little love",
                                   "Major where you get good amount of love"]
        self.catImg = catImg ?? [UIImage(named: "INFO")!, UIImage(named: "CSE")!, UIImage(named: "ASIAN")!]
        
    }
}
