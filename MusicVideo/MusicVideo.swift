//
//  MusicVideo.swift
//  MusicVideo
//
//  Created by Simon R Mableson on 9/2/16.
//  Copyright © 2016 Simon R Mableson. All rights reserved.
//

import Foundation

class Videos {
    
    //Class Definition
    private var _vName: String
    private var _vRights: String
    private var _vPrice: String
    private var _vImageUrl: String
    private var _vArtist: String
    private var _vVideoUrl: String
    private var _vId: String
    private var _vGenre: String
    private var _vLinkToiTunes: String
    private var _vReleaseDate: String

    //This variable gets created from the UI
    var vImageData:NSData?
    
    //Getters
    var vName: String {
        return _vName
    }
    var vRights: String {
        return _vRights
    }
    var vPrice: String {
        return _vPrice
    }
    var vImageUrl: String {
        return _vImageUrl
    }
    var vArtist: String {
        return _vArtist
    }
    var vVideoUrl: String {
        return _vVideoUrl
    }
    var vId: String {
        return _vId
    }
    var vGenre: String {
        return _vGenre
    }
    var vLinkToiTunes: String {
        return _vLinkToiTunes
    }
    var vReleaseDate: String {
        return _vReleaseDate
    }

    
    //Parse JSON object and populate values
    init(data: JSONDictionary) {

        //Video Name _vName: String
        if let nameData = data["im:name"] as? JSONDictionary,
            vName = nameData["label"] as? String {
                self._vName = vName
        } else {
            _vName = ""
        }
        
        //Video Rights _vRights: String
        if let rightsData = data["rights"] as? JSONDictionary,
            vRights = rightsData["label"] as? String {
                self._vRights = vRights
        } else {
            _vRights = ""
        }
        
        //Video Price _vPrice: String
        if let priceData = data["im:price"] as? JSONDictionary,
            vPriceAttributes = priceData["attributes"] as? JSONDictionary,
            vPrice = vPriceAttributes["amount"] as? String {
                self._vPrice = vPrice
        } else {
            _vPrice = ""
        }

        //Video Image _vImageUrl: String
        if let imageData = data["im:image"] as? JSONArray,
            imageArray = imageData[2] as? JSONDictionary,
            vImageUrl = imageArray["label"] as? String {
                self._vImageUrl = vImageUrl
                    .stringByReplacingOccurrencesOfString("100x100", withString: "600x600")
        } else {
            _vImageUrl = ""
        }
    
        //Video Artist _vArtist: String
        if let artistData = data["im:artist"] as? JSONDictionary,
            vArtist = artistData["label"] as? String {
                self._vArtist = vArtist
        } else {
            _vArtist = ""
        }
        
        //Video URL _vVideoUrl: String
        if let videoData = data["link"] as? JSONArray,
            videoArray = videoData[1] as? JSONDictionary,
            videoAttributes = videoArray["attributes"],
            vVideoUrl = videoAttributes["href"] as? String {
                self._vVideoUrl = vVideoUrl
        } else {
            _vVideoUrl = ""
        }
        
        //Video ID _vId: String
        if let idData = data["id"] as? JSONDictionary,
            vIdAttributes = idData["attributes"] as? JSONDictionary,
            vId = vIdAttributes["im:id"] as? String {
                self._vId = vId
        } else {
            _vId = ""
        }
        
        //Video Genre _vGenre: String
        if let genreData = data["category"] as? JSONDictionary,
            genreAttributes = genreData["attributes"] as? JSONDictionary,
            vGenre = genreAttributes["term"] as? String {
                self._vGenre = vGenre
        } else {
            _vGenre = ""
        }
    
        //Video iTunes link _vLinkToiTunes: String
        if let linkToiTunesData = data["id"] as? JSONDictionary,
            vLinkToiTunes = linkToiTunesData["label"] as? String {
                self._vLinkToiTunes = vLinkToiTunes
        } else {
            _vLinkToiTunes = ""
        }

        //Video Release Date _vReleaseDate: String
        if let releaseDateData = data["im:releaseDate"] as? JSONDictionary,
            vReleaseDateAttributes = releaseDateData["attributes"] as? JSONDictionary,
            vReleaseDate = vReleaseDateAttributes["label"] as? String {
                self._vReleaseDate = vReleaseDate
        } else {
            _vReleaseDate = ""
        }
    
    }
}


