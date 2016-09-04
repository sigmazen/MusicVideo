//
//  ViewController.swift
//  MusicVideo
//
//  Created by Simon R Mableson on 9/2/16.
//  Copyright © 2016 Simon R Mableson. All rights reserved.
//

//  Github collaboration: Setting : Marsoftek

import UIKit

class ViewController: UIViewController {
    
    var videos = [Videos]()

    override func viewDidLoad() {
        super.viewDidLoad()

        //Call API
        let api = APIManager()
        api.loadData("https://itunes.apple.com/us/rss/topmusicvideos/limit-10/json", completion: didLoadData)
    }

    
    func didLoadData(videos: [Videos]) {
        
        print(reachabilityStatus)
        
        //Set the Class level variable to be the incoming value
        self.videos = videos

        //Loop through and print to console
        for video in videos {
            print("Video name is \(video.vName)")
        }

        //Call function
        writeOutVideos()
    
    }
    
    func writeOutVideos() {
        //Since videos variable is declared at a Class level 
        //  and didLoadData is setting it, we can reference it
        
        //Pulling value from Class variable
//        for video in videos {
//            print("Function Video name is \(video.vName)")
//        }
        
        //Getting the index value of the video
        //Original loop approach
//        for var i = 0; i < videos.count; i += 1 {
//            print ("\(i) name is \(videos[i].vName)")
//        }
        
        //Slightly more modern approach
//        for i in 0..<videos.count {
//            print ("\(i) name is \(videos[i].vName)")
//        }
        
        //Latest approach
        for (index, video) in videos.enumerate() {
            print ("\(index) name is \(video.vName)")
        }
    }
    
    
//    func didLoadData(result:String) {
//        let alert = UIAlertController(title: (result), message: nil, preferredStyle: .Alert)
//        let okAction = UIAlertAction(title: "Ok", style: .Default) {
//            action -> Void in
//        }
//
//        alert.addAction(okAction)
//        self.presentViewController(alert, animated: true, completion: nil)
//    }

}