//
//  A.swift
//  iQuiz
//
//  Created by Rico Wang on 10/29/18.
//  Copyright © 2018 Rico Wang. All rights reserved.
//

import Foundation

class A {
    
    let answers : [[[String]]] = [
            // INFO
            [["Anind Dey", "Somebody", "Some other body", "Some some guy"],
             ["Placeholder", "Another placeholder", "Placeholder placeholder", "Yet another placeholder"]],
            // CSE
            [["CSE", "Somebody", "Some other body", "Some some guy"],
             ["Placeholder", "Another placeholder", "Placeholder placeholder", "Yet another placeholder"]],
            // JAPAN
            [["Japan", "Somebody", "Some other body", "Some some guy"],
             ["Placeholder", "Another placeholder", "Placeholder placeholder", "Yet another placeholder"]]]
    
    func getA(_ catID : Int) -> [[String]]? {
        if catID == 0 {
            return self.answers[0]
        } else if catID == 1 {
            return self.answers[1]
        } else if catID == 2 {
            return self.answers[2]
        } else {
            return nil
        }
    }
}
