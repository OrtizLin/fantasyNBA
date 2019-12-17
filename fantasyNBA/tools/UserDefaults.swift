//
//  UserDefaults.swift
//  apitesting
//
//  Created by apple on 2019/12/12.
//  Copyright © 2019 apple. All rights reserved.
//

import Foundation

struct Preference<Type>: RawRepresentable {
    var rawValue: String
    init(rawValue: String) {
        self.rawValue = rawValue
    }
}

struct UDName {
    static let updateTimeStamp = Preference<Int>(rawValue: "updateTimeStamp")
    static let playersData = Preference<Data>(rawValue: "playersData")
    static let token = Preference<String>(rawValue: "token")
    static let season = Preference<String>(rawValue: "season")
}

extension UserDefaults {
    subscript(key: Preference<Int>) -> Int {
    set { set(newValue, forKey: key.rawValue) }
        get { return integer(forKey: key.rawValue) }
    }
    
    subscript(key: Preference<String>) -> String? {
        set { set(newValue, forKey: key.rawValue) }
        get { return string(forKey: key.rawValue) }
    }
    
    subscript(key: Preference<Data>) -> Data {
        set { set(newValue, forKey: key.rawValue) }
        get { return data(forKey: key.rawValue)! }
    }
}

