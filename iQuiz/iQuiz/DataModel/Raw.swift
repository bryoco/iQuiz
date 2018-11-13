//
//  Json.swift
//  iQuiz
//
//  Created by Rico Wang on 11/11/18.
//  Copyright © 2018 Rico Wang. All rights reserved.
//

import Foundation

struct Raw {

    let cats: [Cat]
    let questions: [Q]
    let answers: [A]
    
    init(json: [String: Any]) {
        self.cats = [Cat(cat: json["title"] as? [String], catDesc: json["desc"] as? [String], catImg: nil)]
        
        self.questions = [Q(questions: json["text"] as? [[String]])]
        
        self.answers = [A(answers: json["answers"] as? [[[String]]])]
    }
}
