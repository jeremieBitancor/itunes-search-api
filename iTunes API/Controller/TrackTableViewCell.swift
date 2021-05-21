//
//  TrackTableViewCell.swift
//  Movies
//
//  Created by jeremie bitancor on 5/19/21.
//

import UIKit

class TrackTableViewCell: UITableViewCell {
    @IBOutlet weak var trackImage: UIImageView!
    @IBOutlet weak var trackName: UILabel!
    @IBOutlet weak var trackGenre: UILabel!
    @IBOutlet weak var trackPrice: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
}
