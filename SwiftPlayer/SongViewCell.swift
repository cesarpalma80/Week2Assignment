//
//  SongViewCell.swift
//  SwiftPlayer
//
//  Created by Cesar on 07/04/17.
//  Copyright © 2017 Metalbytes. All rights reserved.
//

import UIKit

class SongViewCell: UITableViewCell {
	
	@IBOutlet weak var songNameLabel: UILabel!
	@IBOutlet weak var iconImageView: UIImageView!
	

    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

    }
	
	
	func configCellFor(song: Song) {
		if song.isPlaying {
			songNameLabel.text = song.name
			songNameLabel.textColor = .black
			iconImageView.image = UIImage(named: "headphone")
		}
		
	}

}
