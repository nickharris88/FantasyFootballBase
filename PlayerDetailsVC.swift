//
//  PlayerDetailsVC.swift
//  FantasyFootballBase
//
//  Created by Harris on 03/04/2017.
//  Copyright © 2017 Harris. All rights reserved.
//

import UIKit
import Alamofire

class PlayerDetailsVC: UIViewController {

     var player: Player!
    
    
    
    @IBOutlet weak var playerName: UILabel!
    @IBOutlet weak var playerImage: UIImageView!
    override func viewDidLoad() {
        super.viewDidLoad()
        
       
        playerName.text = player.name
        

        // Do any additional setup after loading the view.
    
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func updateUI() {
        
 }
   
        
    }     /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */


