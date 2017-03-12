//
//  HomeViewTableViewCell.swift
//  InstagramOnParse
//
//  Created by Lum Situ on 3/8/17.
//
//

import UIKit
import Parse
import ParseUI

class HomeViewTableViewCell: UITableViewCell {

    @IBOutlet weak var photoView: PFImageView!
    @IBOutlet weak var captionLabel: UILabel!
    
    
    var post: Post! {
        didSet{
            self.photoView.file = post.image
            self.photoView.loadInBackground()
            self.captionLabel.text = post.caption
            print(" Has an image")
        }
    }
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        
        
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
