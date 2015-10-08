//
//  ViewCell.swift
//  VimeoStaffPicks
//
//  Created by Matthew Weintrub on 10/2/15.
//  Copyright (c) 2015 matthew weintrub. All rights reserved.
//

import UIKit

class ViewCell: UITableViewCell {
    
    var task: NSURLSessionDataTask?

    
    @IBOutlet weak var nameLabel: UILabel?
    @IBOutlet weak var durationLabel: UILabel?
    @IBOutlet weak var videoImageView: UIImageView?
    
    var video: Video? {
        
        didSet {
            
            //if the video object was set to somethting, grab that something to configure name & duration labels
            if let constVideo = video {
                
                self.nameLabel?.text = constVideo.name
                
                if let constDuration = constVideo.duration {
                    
                    self.durationLabel?.text = constDuration
                    
                }
                    
                else {
                    self.durationLabel?.text = "00:00"
                }
                
                if let constImageURLString = constVideo.imageURLString {
                    
                    let url = NSURL(string: constImageURLString)!
                    self.task = NSURLSession.sharedSession().dataTaskWithURL(url, completionHandler: {[weak self]( data, response, error) -> Void in
                        
                        dispatch_async(dispatch_get_main_queue(), { () -> Void in
                            
                            if let strongSelf = self {
                                
                                if constImageURLString != strongSelf.video?.imageURLString {
                                    
                                    return
                                }
                                
                                strongSelf.task = nil
                                
                                if data != nil {
                                    
                                    let image = UIImage(data:data)
                                    strongSelf.imageView?.image = image
                                }
                            }

                            else {
                                
                                // TODO: alert the user?
                                
                            }
                            
                        })
                        
                    })
                    
                    self.task?.resume()
                    
                }
                
                
            }

        }
    }
    
    //
    deinit {
        
        self.task?.cancel()
        self.task = nil
        
    }
    
    override func prepareForReuse() {
        self.nameLabel?.text = ""
        self.durationLabel?.text = ""
        self.videoImageView?.image = nil
        self.task?.cancel()
        self.task = nil
    }
    
}

