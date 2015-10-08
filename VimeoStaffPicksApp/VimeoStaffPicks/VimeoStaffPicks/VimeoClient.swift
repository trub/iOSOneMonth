//
//  VimeoClient.swift
//  VimeoStaffPicks
//
//  Created by Matthew Weintrub on 10/2/15.
//  Copyright (c) 2015 matthew weintrub. All rights reserved.
//
import Foundation

typealias ServerResponseCallback = (videos: Array<Video>?, error: NSError?) -> Void

class VimeoClient {
    
    static let errorDomain = "VimeoClientErrorDomain"
    static let baseURLString = "https://api.vimeo.com"
    static let staffpicksPath = "/channels/staffpicks/videos"
    static let authToken = "eeb3566316fc39f535a4276a63d90649" // Replace with your own auth token from Vimeo
    
    class func staffpicks(callback: ServerResponseCallback) {
        
        let URLString = baseURLString + staffpicksPath
        var URL = NSURL(string: URLString)
        
        if URL == nil {
            
            var error = NSError(domain: errorDomain, code: 0, userInfo: [NSLocalizedDescriptionKey : "Unable to create URL"])
            callback(videos: nil, error: error)
            
            return
        }
        
        var request = NSMutableURLRequest(URL: URL!)
        request.HTTPMethod = "GET"
        request.addValue("Bearer " + authToken, forHTTPHeaderField: "Authorization")
        
        var task = NSURLSession.sharedSession().dataTaskWithRequest(request, completionHandler: { (data: NSData?, response: NSURLResponse?, error: NSError?) -> Void in
            
            dispatch_async(dispatch_get_main_queue(), { () -> Void in
                
                if error != nil {
                    
                    callback(videos: nil, error: error)
                    
                    return
                }
                
                
                //SWIFT 2.0
                //                var JSON: Dictionary<String,AnyObject>? = nil
                
                //                do {
                //                JSON = try NSJSONSerialization.JSONObjectWithData(data!, options: NSJSONReadingOptions.MutableLeaves) as? Dictionary<String,AnyObject>
                //                }
                //
                //                catch let error as NSError {
                //
                //                    callback(videos: nil, error: error)
                //
                //                    return
                //                }
                //
                
                
                
                var JSONError: NSError?
                var JSON = NSJSONSerialization.JSONObjectWithData(data!, options: NSJSONReadingOptions.MutableLeaves, error: &JSONError) as? Dictionary<String,AnyObject>
                
                if JSON == nil {
                    
                    var error = NSError(domain: self.errorDomain, code: 0, userInfo: [NSLocalizedDescriptionKey : "Unable to parse JSON"])
                    callback(videos: nil, error: error)
                    
                    return
                }
                
                //create an empty array
                var videoArray = Array<Video>()
                
                //get into JSON
                if let constJSON = JSON {
                    
                    //grab the array key to data, expect as? array of dictionary with string, keys, object value
                    var dataArray = constJSON["data"] as? Array<Dictionary<String,AnyObject>>
                    
                    //is array something or nil; if something loop through it
                    if let constArray = dataArray {
                        
                        //looping
                        for value in constArray {
                            
                            //for every dictionary in the array use dictionary to create a video object
                            let video = Video(dictionary: value)
                            //add that video object to our video array
                            videoArray.append(video)
                            
                        }
                    }
                }
                //send back videoArray in our callback
                callback(videos: videoArray, error: nil)
                
            })
            
        })
        
        task.resume()
        
    }
    
}