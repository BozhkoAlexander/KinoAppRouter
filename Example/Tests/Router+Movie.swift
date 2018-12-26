//
//  Router+Movie.swift
//  KinoAppRouter_Tests
//
//  Created by Alexander Bozhko on 26/12/2018.
//  Copyright © 2018 CocoaPods. All rights reserved.
//

import Foundation
import KinoAppRouter

extension Router {
    
    func url(json: Any) -> URL? {
        guard let json = json as? Dictionary<String, Any> else { return nil }
        guard let movieId = json["MovieId"] as? Int else { return nil }
        let path = String(format: "movie-%i", movieId)
        
        let title = json["Title"] as? String ?? String()
        let subtitle = json["Subtitle"] as? String ?? String()
        let rating = json["Rating"] as? Double ?? 0
        let ratingsCount = json["RatingsCount"] as? Int ?? 0
        let image = json["Poster"] as? String ?? String()
        let averageColor = json["PosterAverageColor"] as? String ?? String()
        
        var frontString = """
[{
"Type": 104,
"GroupId": null,
"Prefix": null,
"Id": %i,
"Title": "%@",
"Subtitle": "%@",
"Rating": %d,
"RatingsCount": %i
}]
"""
        
        var rearString = """
[{
"Type": 108,
"GroupId": null,
"Image": "%@",
"AverageColor": "%@"
}]
"""
        
        frontString = String(format: frontString, movieId, title, subtitle, rating, ratingsCount)
        rearString = String(format: rearString, image, averageColor)
        
        let rearId = String(format: "%@-rear", path)
        let frontId = path
        
        let rearConfig = Router.PageConfig(id: rearId, needsPaging: false, preloaded: rearString)
        let frontConfig = Router.PageConfig(id: frontId, needsPaging: true, preloaded: frontString)
        
        return url(path: path, rearConfig: rearConfig, frontConfig: frontConfig)
    }
    
}
