//
//  FantasyCell.swift
//  FantasyFootballBase
//
//  Created by Harris on 12/03/2017.
//  Copyright © 2017 Harris. All rights reserved.
//

import UIKit

class FantasyCell: UITableViewCell {

    @IBOutlet weak var playerImg: UIImageView!
    @IBOutlet weak var playerName: UILabel!
    @IBOutlet weak var teamName: UILabel!
    @IBOutlet weak var Score: UILabel!
    @IBOutlet weak var ppg: UILabel!
    @IBOutlet weak var price: UILabel!
    
    var player: Player!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    func configureCell(player: Player) {
       playerName.text = "\(player.name)"
        teamName.text  = player.team
        Score.text = "\(player.points)"
        ppg.text = "\(player.ppg)"
        price.text = "\(player.price)"
        let imageURL = "https://platform-static-files.s3.amazonaws.com/premierleague/photos/players/110x140/p\(player.imgURL)"
        let url = URL(string: imageURL)!
        
        DispatchQueue.global().async {
            do {
                let data = try Data(contentsOf:  url)
                DispatchQueue.global().sync {
                    self.playerImg.image = UIImage(data: data)
                }
            } catch {
                
            }
        }
        
        
        
        
    }
}
