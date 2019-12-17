//
//  NetworkClient.swift
//  apitesting
//
//  Created by apple on 2019/12/11.
//  Copyright © 2019 apple. All rights reserved.
//

import Foundation
import Siesta

internal let NetworkClient = _NetworkClient.shared
internal let baseURL = "https://api.fantasydata.net/api/nba/fantasy/json"

internal class _NetworkClient {
    static let shared = _NetworkClient()
    var service = Service(
        baseURL: baseURL,
        standardTransformers: [.text, .image]
    )
    
    let jsonDecoder = JSONDecoder()
    
    fileprivate init() {
    
        #if DEBUG
        SiestaLog.Category.enabled = [.network]
        #endif
        
        configurePlayerAPI()
    }
}

extension NSNull: JSONConvertible { }
