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
            [["Anind Dey", "Joel Ross", "Ted Neward", "Dowell Eugenio"],
             ["Information School", "Intellectual School", "Intelligence School", "Infrastructure School"]],
            
            // CSE
            [["Computer Science and Engineering", "Commando Superb Explosion", "Cremation Specialized Entertainment", "Council of Space Entities"],
             ["The Bill & Melinda Gates Foundation", "Amazon", "Microsoft", "Secret Federal Government Agency"]],
            
            // JAPAN
            [["Konichiwa", "Nihao", "Annyeonghaseyo", "Salve"],
             ["Linguistics", "Weeabooism", "Culture", "Nihilism"]]]
    
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
