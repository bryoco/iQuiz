//
//  DataRepository.swift
//  iQuiz
//
//  Created by Rico Wang on 10/29/18.
//  Copyright © 2018 Rico Wang. All rights reserved.
//

import Foundation
import UIKit

class DataRepository {

    private static let theInstance = DataRepository()
    
    static func instance() -> DataRepository {
        return theInstance
    }
    
    func getData(_ cat: [String]?, _ catDesc: [String]?, _ catImg: [UIImage]?) -> Cat? {
        return Cat(cat: cat ?? nil, catDesc: catDesc ?? nil, catImg: catImg ?? nil)
    }
}
