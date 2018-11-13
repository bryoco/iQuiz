//
//  A.swift
//  iQuiz
//
//  Created by Rico Wang on 10/29/18.
//  Copyright © 2018 Rico Wang. All rights reserved.
//

import Foundation

struct A {
    
    var answers : [[[String]]]?
    
    init(answers: [[[String]]]?) {
        self.answers = answers ?? [
            // INFO
            [["Anind Dey", "Joel Ross", "Ted Neward", "Dowell Eugenio"],
             ["Information School", "Intellectual School", "Intelligence School", "Infrastructure School"]],
            
            // CSE
            [["Computer Science and Engineering", "Commando Superb Explosion", "Cremation Specialized Entertainment", "Council of Space Entities"],
             ["The Bill & Melinda Gates Foundation", "Amazon", "Microsoft", "Secret Federal Government Agency"]],
            
            // JAPAN
            [["Konichiwa", "Nihao", "Annyeonghaseyo", "Salve"],
             ["Linguistics", "Weeabooism", "Culture", "Nihilism"]]]
    }
    
    func getA(_ catID : Int) -> [[String]]? {
        return self.answers?[catID] ?? [[]]
    }
}
