//
//  OnlineModel.swift
//  apitesting
//
//  Created by apple on 2019/12/11.
//  Copyright © 2019 apple. All rights reserved.
//

import Foundation
import Siesta


protocol PlayerModel {
    func getPlayerData(onSuccess: @escaping ([PlayerData]) -> Void, onFailure: @escaping (String) -> Void)
}

extension _NetworkClient: PlayerModel {
    func configurePlayerAPI() {
        service.configureTransformer("/PlayerSeasonProjectionStats/\(UserDefaults.standard[UDName.season] ?? "2019")") {
            try self.jsonDecoder.decode([PlayerData].self, from: $0.content)
        }
    }
    
    func getPlayerData(onSuccess: @escaping ([PlayerData]) -> Void, onFailure: @escaping (String) -> Void) {
        let request = service.resource("/PlayerSeasonProjectionStats/\(UserDefaults.standard[UDName.season] ?? "2019")")
            .request(.get) { $0.addValue("\(UserDefaults.standard[UDName.token] ?? "")", forHTTPHeaderField: "Ocp-Apim-Subscription-Key")}
        
        request.onSuccess { (entity) in
                guard let json: [PlayerData] = entity.typedContent() else {
                    onFailure("JSON 解析錯誤 / return 參數是 null")
                    return
                }
                onSuccess(json)
                }.onFailure { (error) in
                    onFailure(error.userMessage)
                }
    }
}
