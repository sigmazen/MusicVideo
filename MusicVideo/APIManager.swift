//
//  APIManager.swift
//  MusicVideo
//
//  Created by Simon R Mableson on 9/2/16.
//  Copyright © 2016 Simon R Mableson. All rights reserved.
//

import Foundation

class APIManager {
    
//    func loadData(urlString:String, completion: (result:String) -> Void) {
    func loadData(urlString:String, completion: [Videos] -> Void) {
        
        let config = NSURLSessionConfiguration.ephemeralSessionConfiguration()
        
        let session = NSURLSession(configuration: config)
        
        let url = NSURL(string: urlString)!
        
        let task = session.dataTaskWithURL(url) {
            (data, response, error) -> Void in
            
            if error != nil {
                //This will output the error to the main queue for showing in UI
//                dispatch_async(dispatch_get_main_queue()) {
//                    completion(result: (error!.localizedDescription))
//                }

                //This will print to the console
                print(error!.localizedDescription)

            } else {
                
                do {
                    /*
                    AllowFragments is used when top level object is not Array or Dictionary
                    Check the JSON using jsoneditoronline.org
                        {} is Dictionary    [] is Array
                    Therefore use AnyObject for Dictionary
                    -----------
                    The following pulls in the overall JSON object as a Dictionary
                    Then parses through feed / entry and loads into a Video object
                    */
                    if let json = try NSJSONSerialization
                        .JSONObjectWithData(data!, options: .AllowFragments) as? JSONDictionary,
                        feed = json["feed"] as? JSONDictionary,
                        entries = feed["entry"] as? JSONArray {

                            //print(json)

                            //Load up the array
                            var videos = [Videos]()
                            for entry in entries {
                                let entry = Videos(data: entry as! JSONDictionary)
                                videos.append(entry)
                            }

                            //Write out array counter to console
                            let i = videos.count
                            print("iTunesApiManager - Total Count is \(i)")
                            print(" ")
                            
                            //If successful write out array to console
                            let priority = DISPATCH_QUEUE_PRIORITY_HIGH
                            dispatch_async(dispatch_get_global_queue(priority, 0)) {
                                dispatch_async(dispatch_get_main_queue()) {
                                    completion(videos)
                                }

                            }
                    }
                
                } catch {
                    //This will output the error to the main queue for showing in UI
//                    dispatch_async(dispatch_get_main_queue()) {
//                        completion(result: "Error in NSJSONSerialization")
//                    }
                    //This will print to the console
                    print("Error in NSJSONSerialization")
                }
            }
        // End of NSJSONSerialization
        
        }

        task.resume()
    }
}