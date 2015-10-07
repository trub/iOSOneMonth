//
//  Video.swift
//  VimeoStaffPicks
//
//  Created by Matthew Weintrub on 10/5/15.
//  Copyright (c) 2015 matthew weintrub. All rights reserved.
//

import Foundation
//add UIKit so we can use UIScreen class to inspect the screen (retina, reglr, etc)
import UIKit

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
                    
                    //add UIKit so we can use UIScreen class to inspect the screen (retina, reglr, etc) and calculate the width*scale to know if we should pull in a different photo based on screen size
                    let screenWdith = UIScreen.mainScreen().bounds.size.width * UIScreen.mainScreen().scale
                    
                    //run filter function on the array containing our picture sizes
                    let variableSizes = constSizes.filter({$0["width"] as? CGFloat >= screenWdith})
                    
                    if variableSizes.count > 0 {
                        
                        let selectedSize = variableSizes[0]
                        
                        self.imageURLString = selectedSize["link"] as? String
                    }
                    
                    else {
                        //use ! on last so we know it won't be an optional
                        let selectedSize = constSizes.last!
                        self.imageURLString = selectedSize["link"] as? String
                    }
                    
                }
            }
            
        }
        
    }
    
}
