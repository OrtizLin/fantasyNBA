//
//  SimulatorViewController.swift
//  apitesting
//
//  Created by apple on 2019/12/13.
//  Copyright © 2019 apple. All rights reserved.
//

import UIKit

class SimulatorViewController: UIViewController {

    @IBOutlet weak var allTableView: UITableView!
    @IBOutlet weak var myPickTableView: UITableView!
    @IBOutlet weak var otherPickTableView: UITableView!
    @IBOutlet weak var searchBar: UISearchBar!
    
    @IBOutlet weak var costLabel: UILabel!
    
    var dataSource:[PlayerData] = []
    var myPickList:[PlayerData] = []
    var otherPickList:[PlayerData] = []
    var originalArray:[PlayerData] = []
    var filterArray:[PlayerData] = []
    var money = 200
    override func viewDidLoad() {
        super.viewDidLoad()
       
        setNavBackBotton()
        allTableView.dataSource = self
        allTableView.delegate = self
        myPickTableView.dataSource = self
        myPickTableView.delegate = self
        myPickTableView.layer.borderWidth = 2.0
        myPickTableView.layer.borderColor = UIColor.green.cgColor
        otherPickTableView.dataSource = self
        otherPickTableView.delegate = self
        otherPickTableView.layer.borderWidth = 2.0
        otherPickTableView.layer.borderColor = UIColor.red.cgColor
        searchBar.delegate = self
        configureData()
        costLabel.text = "剩餘金額: \(money)"
    }

    func configureData() {
        self.view.makeToastActivity(.center)
        if currentTimeStamp() - UserDefaults.standard[UDName.updateTimeStamp] > 86400 {
            NetworkClient.getPlayerData(onSuccess: {(playerData) in
                var newData = playerData
                newData.sort(by: { Int($0.fantasyPoints!) > Int($1.fantasyPoints!)})
                guard let encode = try? PropertyListEncoder().encode(newData) else { return }
                UserDefaults.standard[UDName.playersData] = encode
                UserDefaults.standard[UDName.updateTimeStamp] = currentTimeStamp()
                
                newData.forEach({ (player) in
                    self.dataSource.append(player)
                })
                self.originalArray = self.dataSource
                self.view.hideToastActivity()
                self.allTableView.reloadData()
            }) { (error) in
                self.view.hideToastActivity()
                self.view.makeToast("權限不足")
            }
        } else {
            let newdata = UserDefaults.standard[UDName.playersData]
            if let playerData = try? PropertyListDecoder().decode(Array<PlayerData>.self, from: newdata) {
                var newData = playerData
                newData.sort(by: { Int($0.fantasyPoints!) > Int($1.fantasyPoints!)})
                newData.forEach({ (player) in
                    self.dataSource.append(player)
                })
                originalArray = dataSource
                self.view.hideToastActivity()
                self.allTableView.reloadData()
            }
        }
    }
}

extension SimulatorViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        switch tableView {
        case allTableView: return dataSource.count
        case myPickTableView: return myPickList.count
        case otherPickTableView: return otherPickList.count
        default: return 0
        }
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = UITableViewCell(style: .subtitle, reuseIdentifier: "identifier")
        switch tableView {
        case allTableView:
            let item = dataSource[indexPath.row]
            cell.textLabel?.font = UIFont.systemFont(ofSize: 13)
            cell.textLabel?.text = "\(item.name ?? "") (\(item.team ?? ""))"
            let point = String(format: "%.2f", perGame(item.points ?? 0, item.games ?? 0))
            let assit = String(format: "%.2f", perGame(item.assists ?? 0, item.games ?? 0))
            let rebounds = String(format: "%.2f", perGame(item.rebounds ?? 0, item.games ?? 0))
            let fg = String(format: "%.2f", item.fieldGoalsMade ?? 0)
            cell.detailTextLabel?.text = "Pts:\(point), FG%:\(fg), Ast:\(assit), Reb:\(rebounds)"
            return cell
            
        case myPickTableView:
            let item = myPickList[indexPath.row]
            cell.textLabel?.font = UIFont.systemFont(ofSize: 13)
            cell.textLabel?.text = "\(item.position ?? "") :\(item.name ?? "")"
            cell.detailTextLabel?.text = "(\(item.team ?? ""))"
            return cell
        
        case otherPickTableView:
            let item = otherPickList[indexPath.row]
            cell.textLabel?.font = UIFont.systemFont(ofSize: 13)
            cell.textLabel?.text = "\(item.position ?? "") :\(item.name ?? "")"
            cell.detailTextLabel?.text = "(\(item.team ?? ""))"
            return cell
            
        default: return cell
        }
    }
}

extension SimulatorViewController: UITableViewDelegate {
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        switch tableView {
        case allTableView:
            let controller = UIAlertController(title: dataSource[indexPath.row].name!, message: "請選擇動作。", preferredStyle: .actionSheet)
            let names = ["自己選", "別人選"]
            for name in names {
                let action = UIAlertAction(title: name, style: .default) { (action) in
                    switch action.title {
                    case "自己選":
                        self.myPickList.append(self.dataSource[indexPath.row])
                        self.dataSource.remove(at: indexPath.row)
                        self.originalArray = self.dataSource
                        self.myPickTableView.reloadData()
                        self.allTableView.reloadData()
                        let controller = UIAlertController(title: "", message: "花費金額", preferredStyle: .alert)
                        controller.addTextField { (textField) in
                            textField.placeholder = "競標金額，最低為1元"
                            textField.keyboardType = UIKeyboardType.phonePad
                        }
                        let okAction = UIAlertAction(title: "OK", style: .default) { (_) in
                            if let cost = controller.textFields?[0].text {
                                self.money -= Int(cost) ?? 1
                                self.costLabel.text = "剩餘金額: \(self.money)"
                            } else {
                                self.money -= 1
                                self.costLabel.text = "剩餘金額: \(self.money)"
                            }
                            
                        }
                        controller.addAction(okAction)
                        self.present(controller, animated: true, completion: nil)
                    default:
                        self.otherPickList.append(self.dataSource[indexPath.row])
                        self.dataSource.remove(at: indexPath.row)
                        self.originalArray = self.dataSource
                        self.otherPickTableView.reloadData()
                        self.allTableView.reloadData()
                    }
                }
                controller.addAction(action)
            }
            let cancelAction = UIAlertAction(title: "取消", style: .cancel, handler: nil)
            controller.addAction(cancelAction)
            present(controller, animated: true, completion: nil)
        default:
            print("456")
        }
    }
    
}

extension SimulatorViewController : UISearchBarDelegate {
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        if searchText != "" {
        filterArray.removeAll()
        dataSource.forEach({ (player) in
            if let name = player.name, name.contains(searchText) {
                filterArray.append(player)
            }
        })
        dataSource = filterArray
        allTableView.reloadData()
        } else {
            filterArray.removeAll()
            dataSource = originalArray
            allTableView.reloadData()
    }
}
}

// MARK - stats function
extension SimulatorViewController {
    func perGame(_ stats: Float, _ game: Int) -> Double {
        return Double(stats)/Double(game)
    }
}
