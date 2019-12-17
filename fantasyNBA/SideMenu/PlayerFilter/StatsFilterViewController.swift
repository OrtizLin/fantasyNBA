//
//  StatsFilterViewController.swift
//  apitesting
//
//  Created by apple on 2019/12/12.
//  Copyright © 2019 apple. All rights reserved.
//

import UIKit
import Siesta


class StatsFilterViewController: UIViewController {

    @IBOutlet weak var FG: UITextField!
    @IBOutlet weak var FT: UITextField!
    @IBOutlet weak var PTM3: UITextField!
    @IBOutlet weak var PTS: UITextField!
    @IBOutlet weak var REB: UITextField!
    @IBOutlet weak var AST: UITextField!
    @IBOutlet weak var ST: UITextField!
    @IBOutlet weak var BLK: UITextField!
    @IBOutlet weak var TO: UITextField!
    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var searchButton: UIButton!
    
    var dataSource:[PlayerData] = []
    var FGFilter = 0.0
    var FTFilter = 0.0
    var PTM3Filter = 0.0
    var PTSFilter = 0.0
    var REBFilter = 0.0
    var ASTFilter = 0.0
    var STFilter = 0.0
    var BLKFilter = 0.0
    var TOFilter = 100.0
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setNavBackBotton()
        searchButton.themeButtonStyle(isSolid: false)
        searchButton.setTitleColor(.white, for: .normal)
        tableView.dataSource = self
        tableView.delegate = self
    }
    @IBAction func buttonPressed(_ sender: Any) {
        dataSource.removeAll()
        // 輸入條件
        enterFilter()
        // 開始篩選
        self.view.makeToastActivity(.center)
        if currentTimeStamp() - UserDefaults.standard[UDName.updateTimeStamp] > 86400 {
        NetworkClient.getPlayerData(onSuccess: {(playerData) in
            
            guard let encode = try? PropertyListEncoder().encode(playerData) else { return }
            UserDefaults.standard[UDName.playersData] = encode
            UserDefaults.standard[UDName.updateTimeStamp] = currentTimeStamp()
            
            playerData.forEach({ (player) in
                if self.startFilter(player) { self.dataSource.append(player) }
            })
            self.view.hideToastActivity()
            self.tableView.reloadData()
        }) { (error) in
            self.view.hideToastActivity()
            self.view.makeToast("權限不足")
        }
        } else {
            let newdata = UserDefaults.standard[UDName.playersData]
            if let playerData = try? PropertyListDecoder().decode(Array<PlayerData>.self, from: newdata) {
                playerData.forEach({ (player) in
                    if self.startFilter(player) { self.dataSource.append(player) }
                })
                self.view.hideToastActivity()
                self.tableView.reloadData()
            }
        }
    }
}

extension StatsFilterViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return dataSource.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let item = dataSource[indexPath.row]
        let cell = UITableViewCell(style: .subtitle, reuseIdentifier: "identifier")
        cell.textLabel?.font = UIFont.systemFont(ofSize: 12)
        cell.textLabel?.text = "\(item.name ?? "no name") (\(item.team ?? "no team"))"
        let point = String(format: "%.2f", perGame(item.points ?? 0, item.games ?? 0))
        let assit = String(format: "%.2f", perGame(item.assists ?? 0, item.games ?? 0))
        let rebounds = String(format: "%.2f", perGame(item.rebounds ?? 0, item.games ?? 0))
        cell.detailTextLabel?.text = "Pts:\(point), Ast:\(assit), Reb:\(rebounds)"
        return cell
    }
}

extension StatsFilterViewController: UITableViewDelegate {
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        print("Did select player")
    }
    
}
// MARK - stats function
extension StatsFilterViewController {
    func perGame(_ stats: Float, _ game: Int) -> Double {
        return Double(stats)/Double(game)
    }
    
    func enterFilter() {
        if let fg = FG.text { FGFilter = Double(fg) ?? 0.0 }
        if let ft = FT.text { FTFilter = Double(ft) ?? 0.0 }
        if let ptm3 = PTM3.text { PTM3Filter = Double(ptm3) ?? 0.0 }
        if let pts = PTS.text { PTSFilter = Double(pts) ?? 0.0 }
        if let reb = REB.text { REBFilter = Double(reb) ?? 0.0 }
        if let ast = AST.text { ASTFilter = Double(ast) ?? 0.0 }
        if let st = ST.text { STFilter = Double(st) ?? 0.0 }
        if let blk = BLK.text { BLKFilter = Double(blk) ?? 0.0 }
        if let to = TO.text { TOFilter = Double(to) ?? 100.0 }
    }
    
    func startFilter(_ player: PlayerData) -> Bool {
        let Games = player.games ?? 0
        let Fg = Double(player.fieldGoalsPercentage ?? 0)
        let Ft = Double(player.freeThrowsPercentage ?? 0)
        let Ptm3 = perGame(player.threePointersMade ?? 0, Games)
        let Pts = perGame(player.points ?? 0, Games)
        let Reb = perGame(player.rebounds ?? 0, Games)
        let Ast = perGame(player.assists ?? 0, Games)
        let St = perGame(player.steals ?? 0, Games)
        let Blk = perGame(player.blockedShots ?? 0, Games)
        let To = perGame(player.turnovers ?? 0, Games)
        
        if Fg > FGFilter, Ft > FTFilter, Ptm3 > PTM3Filter, Pts > PTSFilter, Reb > REBFilter,
            Ast > ASTFilter, St > STFilter, Blk > BLKFilter, To < TOFilter { return true }
        return false
    }
}
