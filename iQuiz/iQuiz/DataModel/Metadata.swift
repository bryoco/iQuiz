//
//  Metadata.swift
//  iQuiz
//
//  Created by Rico Wang on 11/12/18.
//  Copyright © 2018 Rico Wang. All rights reserved.
//

import Foundation

class Metadata {
    var useCustomizedData: Bool
    
    func getUseCustomizedData() -> Bool {
        print("getUseCustomizedData():")
        print("Metadata.useCustomizedData = \(self.useCustomizedData)")
        return self.useCustomizedData
    }
    
    func setUseCustomizedData(_ useCustomizedData: Bool) -> Void {
        self.useCustomizedData = useCustomizedData
        print("setUseCustomizedData():")
        print("Metadata.useCustomizedData = \(self.useCustomizedData)")
    }
    
    init() {
        self.useCustomizedData = false
    }
}
