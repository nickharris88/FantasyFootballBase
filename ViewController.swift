//
//  ViewController.swift
//  FantasyFootballBase
//
//  Created by Harris on 12/03/2017.
//  Copyright © 2017 Harris. All rights reserved.
//

import UIKit
import Alamofire



class ViewController: UIViewController, UITableViewDelegate, UITableViewDataSource, UISearchBarDelegate {

    
    @IBOutlet weak var segment: UISegmentedControl!
    
    @IBOutlet weak var searchBar: UISearchBar!
    @IBOutlet weak var tableView: UITableView!
     var players = [Player]()
    var filteredPlayer = [Player]()
    var inSearchMode = false
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        
   //     let p1 = Player(name: "Alexis", points: "200", team: "Arsenal", ppg: "6.5")
    //    let p2 = Player(name: "Hazard", points: "300", team: "Chelsea", ppg: "7.3")
     //   players.append(p1)
   //     players.append(p2)
    print("there are \(players.count)")
        
        
  tableView.delegate = self
tableView.dataSource = self
        searchBar.delegate = self
        searchBar.returnKeyType = UIReturnKeyType.done
        self.downloadPlayerData(completed: {
            
          
        }
      
            
            )
            
    
        
        
    }
    func downloadPlayerData(completed: @escaping DownloadComplete) {
        print ("made it here")
        Alamofire.request("https://fantasy.premierleague.com/drf/bootstrap-static").responseJSON { response in
            print ("made it here")
            if let dict = response.result.value as? Dictionary<String, AnyObject> {
                
            
           if let playaz = dict["elements"] as? [Dictionary<String, AnyObject>]
            {
                if let name = playaz[0]["web_name"] as? String {
                    print("player 1's name is \(name)")
                    for obj in playaz {
                       let player = Player(playerDict: obj)
                      self.players.append(player)
                        print(obj)
                   }
                    self.tableView.reloadData()
                }
                
                }
            
            }
            
        }
        completed()
        
    }    //table view click func



    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        if inSearchMode {
        return filteredPlayer.count
        }
        else {
            return players.count
        }
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if  let cell = tableView.dequeueReusableCell(withIdentifier: "FantasyCell", for: indexPath) as? FantasyCell {
            
            let player: Player!
            if inSearchMode {
                 player = filteredPlayer[indexPath.row]
                cell.configureCell(player: player)
            }
            else {
        player = players[indexPath.row]
         cell.configureCell(player: player)
                
            }
            return cell
        }
        else {
            return UITableViewCell()
        }
    
   }
    
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        var play: Player!
        
        if inSearchMode {
            play = filteredPlayer[indexPath.row]
            performSegue(withIdentifier: "PlayerDetailsVC", sender: play)
        }
        else {
            play = players[indexPath.row]
            performSegue(withIdentifier: "PlayerDetailsVC", sender: play)        }
        
        
    }
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        view.endEditing(true)
    }
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        if searchBar.text == nil || searchBar.text ==  "" {
            inSearchMode = false
            tableView.reloadData()
            view.endEditing(true)
        }
        else {
            inSearchMode = true
            
            let lower = searchBar.text!
            filteredPlayer = players.filter({$0.name.range(of: lower.capitalized) != nil})
            tableView.reloadData()
        }
    }
  
    @IBAction func segmentChange(_ sender: UISegmentedControl) {
        
        if segment.selectedSegmentIndex == 0 {
            
            players.sort() { $0.name.capitalized < $1.name.capitalized }
            tableView.reloadData()
    }
        else if segment.selectedSegmentIndex == 1 {
            players.sort() { $0.price > $1.price }
            tableView.reloadData()
            
            
        } else if segment.selectedSegmentIndex == 2 {
            
            players.sort() { $0.points > $1.points }
            tableView.reloadData()
        } else  {
            
players.sort() { $0.ppg > $1.ppg }}
tableView.reloadData()
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "PlayerDetailsVC" {
            if let detailsVC = segue.destination as? PlayerDetailsVC {
                if let play = sender as? Player {
                    detailsVC.player = play
                }
            }
        }
    }
    

}
