//
//  DataRepository.swift
//  iQuiz
//
//  Created by Rico Wang on 10/29/18.
//  Copyright © 2018 Rico Wang. All rights reserved.
//

import Foundation

class DataRepository {
    
    static func instance() -> DataRepository {
        return theInstance
    }
    
    private static let theInstance = DataRepository()
    
    func getData() -> Data? {
        return Data()
    }
}
