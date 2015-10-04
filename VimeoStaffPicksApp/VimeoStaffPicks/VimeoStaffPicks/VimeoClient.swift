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
            
            var responseString = NSString(data: data!, encoding: NSUTF8StringEncoding)
            
            print(response)
            print(responseString)
            
            callback(object: nil, error: nil)
            
        })
        
        task.resume()
    }
}