//
//  MusicVideo.swift
//  MusicVideo
//
//  Created by Simon R Mableson on 9/2/16.
//  Copyright © 2016 Simon R Mableson. All rights reserved.
//

import Foundation

class Videos {
    
    //Data Encapsulation
    private var _vName: String
    private var _vImageUrl: String
    private var _vVideoUrl: String
    
    //Getters
    var vName: String {
        return _vName
    }
    var vImageUrl: String {
        return _vImageUrl
    }
    var vVideoUrl: String {
        return _vVideoUrl
    }
    
    init(data: JSONDictionary) {
        
        //Video Name
        if let name = data["im:name"] as? JSONDictionary,
            vName = name["label"] as? String {
                self._vName = vName
        } else {
            _vName = ""
        }
        
        
        //Video Image
        if let img = data["im:image"] as? JSONArray,
            image = img[2] as? JSONDictionary,
            vImageUrl = image["label"] as? String {
                self._vImageUrl = vImageUrl
                    .stringByReplacingOccurrencesOfString("100x100", withString: "600x600")
        } else {
            _vImageUrl = ""
        }
    

        //Video URL
        if let movie = data["link"] as? JSONArray,
            vUrl = movie[1] as? JSONDictionary,
            vHref = vUrl["attributes"],
            vVideoUrl = vHref["href"] as? String {
                self._vVideoUrl = vVideoUrl
        } else {
            _vVideoUrl = ""
        }
    
    }
}


