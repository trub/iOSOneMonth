//
//  VimeoClient.swift
//  VimeoStaffPicks
//
//  Created by Matthew Weintrub on 10/2/15.
//  Copyright (c) 2015 matthew weintrub. All rights reserved.
//
import Foundation

typealias ServerResponseCallback = (object: Dictionary<String,AnyObject>?, error: NSError?) -> Void

class VimeoClient {
    
    static let errorDomain = "VimeoClientErrorDomain"
    static let baseURLString = "https://api.vimeo.com"
    static let staffpicksPath = "/channels/staffpicks/videos"
    static let authToken = "063e3847850698597297a5203a2f16b8" // Replace with your own auth token from Vimeo
    
    class func staffpicks(callback: ServerResponseCallback) {
        
        let URLString = baseURLString + staffpicksPath
        var URL = NSURL(string: URLString)
        
        if URL == nil {
            var error = NSError(domain: errorDomain, code: 0, userInfo: [NSLocalizedDescriptionKey : "Unable to create URL"])
            callback(object: nil, error: error)
            return
        }
        
        var request = NSMutableURLRequest(URL: URL!)
        request.HTTPMethod = "GET"
        request.addValue("Bearer " + authToken, forHTTPHeaderField: "Authorization")
        
        var task = NSURLSession.sharedSession().dataTaskWithRequest(request, completionHandler: { (data: NSData?, response: NSURLResponse?, error: NSError?) -> Void in
            
            dispatch_async(dispatch_get_main_queue(), { () -> Void in
                
                
                
                if error != nil {
                    callback(object: nil, error: error)
                    
                    return
                }
                
                //            var JSON: Dictionary<String,AnyObject>? = nil
                //
                //            do {
                //                JSON = try NSJSONSerialization.JSONObjectWithData(data!, options: NSJSONReadingOptions.MutableLeaves) as? Dictionary<String,AnyObject>
                //            }
                //
                //
                //            catch let error as NSError {
                //                callback(videos: nil, error: error)
                //                return
                //            }
                
                
                var JSONError: NSError?
                var JSON = NSJSONSerialization.JSONObjectWithData(data!, options: NSJSONReadingOptions.MutableLeaves, error: &JSONError) as? Dictionary<String,AnyObject>
    
                if JSONError != nil {
    
                    callback(object: nil, error: JSONError)
    
                    return
    
                }
    
                if JSON == nil {

                var error = NSError(domain: self.errorDomain, code: 0, userInfo: [NSLocalizedDescriptionKey : "Unable to parse JSON"])
                callback(object: nil, error: error)
                return
                }
        
                callback(object: nil, error: error)
                
            })
            
        })
        
        task.resume()
    }
}