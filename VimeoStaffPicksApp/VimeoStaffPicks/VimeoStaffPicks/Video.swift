//
//  Video.swift
//  VimeoStaffPicks
//
//  Created by Matthew Weintrub on 10/5/15.
//  Copyright (c) 2015 matthew weintrub. All rights reserved.
//

import Foundation

class Video {
    
    var name: String? = ""
    var duration: Int? = 0
    var imageURLString: String? = ""
    
    // create video object, initialize with dicionarity from json
    init(dictionary:Dictionary<String,AnyObject>) {
        
        //grab the name, the duration, url string from json
        self.name = dictionary["name"] as? String
        self.duration = dictionary["duration"] as? Int
        
        var pictures = dictionary["pictures"] as? Dictionary<String,AnyObject>
        
        if let constPictures = pictures {
            
            var sizes = constPictures["sizes"] as? Array<Dictionary<String,AnyObject>>
            
            if let constSizes = sizes {
                
                if constSizes.count > 0 {
                    var picture = constSizes[0]
                    
                    //grab the image url
                    self.imageURLString = picture["link"] as? String
                    
                }
            }
            
        }
        
    }
    
}
