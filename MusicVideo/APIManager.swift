//
//  APIManager.swift
//  MusicVideo
//
//  Created by Simon R Mableson on 9/2/16.
//  Copyright © 2016 Simon R Mableson. All rights reserved.
//

import Foundation

class APIManager {
    
    func loadData(urlString:String, completion: (result:String) -> Void) {
        
        let config = NSURLSessionConfiguration.ephemeralSessionConfiguration()
        
        let session = NSURLSession(configuration: config)
        
        let url = NSURL(string: urlString)!
        
        let task = session.dataTaskWithURL(url) {
            (data, response, error) -> Void in
            
            if error != nil {
                dispatch_async(dispatch_get_main_queue()) {
                    completion(result: (error!.localizedDescription))
                }

            } else {
                
                do {
                    /*
                    AllowFragments is used when top level object is not Array or Dictionary
                    Check the JSON using jsoneditoronline.org
                        {} is Dictionary    [] is Array
                    Therefore use AnyObject for Dictionary
                    */
                    if let json = try NSJSONSerialization.JSONObjectWithData(data!,
                        options: .AllowFragments)
                        as? [String: AnyObject] {

                            print(json)
                            
                            let priority = DISPATCH_QUEUE_PRIORITY_HIGH
                            
                            dispatch_async(dispatch_get_global_queue(priority, 0)) {

                                dispatch_async(dispatch_get_main_queue()) {
                                    completion(result: "NSJSONSerialization Successful")
                                }

                            }
                    }
                
                } catch {
                    dispatch_async(dispatch_get_main_queue()) {
                        completion(result: "Error in NSJSONSerialization")
                    }
                }
            }
        // End of NSJSONSerialization
        
        }

        task.resume()
    }
}