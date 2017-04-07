//
//  Players.swift
//  FantasyFootballBase
//
//  Created by Harris on 12/03/2017.
//  Copyright © 2017 Harris. All rights reserved.
//

import Foundation
import Alamofire

class Player {
    private var _name: String!
    private var _points: Int!
    private var _team: String!
    private var _ppg: Double!
    private var _price: Double!
    private var _imgURL: String!
    
    var name: String {
        
        if _name == nil {
            _name = ""
        }
        return _name
    }
    
    var points: Int {
        
        if _points == nil {
            _points = 0
        }
        return _points
    }
    
    var team: String {
        if _team == nil {
            _team = ""
        }
        return _team
    }
    
    var ppg: Double {
        if _ppg == nil {
            _ppg = 0.0
        }
        return _ppg
    }
    
    var price: Double {
        if _price == nil {
            _price = 0.0
        }
        return _price
    }
    
    var imgURL: String {
        if _imgURL == nil {
            _imgURL = ""
        }
        return _imgURL
    }
    
var Teams = ["Arsenal", "Bournemouth", "Burnley", "Chelsea", "Crystal Palace","Everton", "Hull City", "Leicester", "Liverpool", "Manchester City", "Manchester United", "Middlesborough", "Southampton", "Stoke City", "Sunderland", "Swansea", "Tottenham", "Watford", "West Brom", "West Ham"]
    
    init(name: String) {
        self._name = name
    }
    
    init(playerDict: Dictionary<String, AnyObject>) {
        if let min = playerDict["web_name"] as? String {
            
            self._name = "\(min)"
        }
    if let teamm = playerDict["team"] as? Int {
        
        
        
        self._team = Teams[(teamm - 1)]
        
    }
        
    if let ppg = playerDict["points_per_game"] as? String {
        
        let newppg = Double(ppg)
        self._ppg = newppg
        
    }
    
    if let imgURL = playerDict["photo"] as? String {
        let newimgURL = imgURL.replacingOccurrences(of: "jpg",  with: "png")
        self._imgURL = "\(newimgURL)"
    }
    
    if let points = playerDict["total_points"] as? Int {
        
        
        self._points = points
    }

        if let price = playerDict["now_cost"] as? Int {
            let newprice =  Double(price)/10
            
            self._price = newprice
        }
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
                        self._name = name
                     
                    }
                    
                }
                
            }
            
        }
        completed()
        
    }
}


