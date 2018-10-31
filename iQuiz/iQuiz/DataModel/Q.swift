//
//  Q.swift
//  iQuiz
//
//  Created by Rico Wang on 10/29/18.
//  Copyright © 2018 Rico Wang. All rights reserved.
//

import Foundation

class Q {
    let questions : [[String]] = [
        // INFO
        ["Who is the current iSchool dean?", "What is the full name of the iSchool?"],
        // CSE
        ["CSE", "Something CSE"],
        // JAPAN
        ["Japanese", "Something Japanese"]]
    
    
    func getQ(_ catID : Int) -> [String]? {
        if catID == 0 {
//            return ["Who is the current iSchool dean?", "What is the full name of the iSchool?"]
            return self.questions[0]
        } else if catID == 1 {
            return self.questions[1]
        } else if catID == 2 {
            return self.questions[2]
        } else {
            return nil
        }
    }
}