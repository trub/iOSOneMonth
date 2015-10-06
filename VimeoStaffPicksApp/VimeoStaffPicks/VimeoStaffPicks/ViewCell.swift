//
//  ViewCell.swift
//  VimeoStaffPicks
//
//  Created by Matthew Weintrub on 10/2/15.
//  Copyright (c) 2015 matthew weintrub. All rights reserved.
//

import UIKit

class ViewCell: UITableViewCell {
    
    @IBOutlet var nameLabel: UILabel?
    @IBOutlet var durationLabel: UILabel?
    
    var video: Video? {
        didSet {
            
            //if the video object was set to somethting, grab that something to configure name & duration labels
            if let constVideo = video {
                
                self.nameLabel?.text = constVideo.name
                
                if let constDuration = constVideo.duration {
                    
                    self.durationLabel?.text = "\(constDuration)"
                    
                }
                    
                else {
                    self.durationLabel?.text = "nope"
                }
                
            }

        }
    }
    
    override func prepareForReuse() {
        self.nameLabel?.text = ""
        self.durationLabel?.text = ""
    }
    
}
