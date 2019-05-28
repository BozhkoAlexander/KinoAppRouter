//
//  CustomUrls.swift
//  KinoAppRouter_Tests
//
//  Created by Alexander Bozhko on 06/03/2019.
//  Copyright © 2019 CocoaPods. All rights reserved.
//

import Foundation


enum CustomURL: String, CaseIterable {
    
    case ad = "kino-app://page/fullscreenad?json=%7B%22Type%22%3A16%2C%22Service%22%3A%22adform%22%2C%22ExternalId%22%3A%22322481%22%2C%22Width%22%3A320%2C%22Height%22%3A480%2C%22Place%22%3A%22AppStart%22%2C%22AverageColor%22%3A%22%2340434a%22%2C%22ImageUrl%22%3A%22https%3A%2F%2Fvideofg.azureedge.net%2Fimg%2Fads%2Fdragon.jpg%22%2C%22Analytics%22%3A%7B%22GA%22%3A%22%22%2C%22Server%22%3A%22%22%7D%7D"
    case newMovieDetails = "bergen-kino://page/movie?frontUrl=https%3a%2f%2fapidev.filmgrail.com%2fapiv2_22%2fMovies%2fFront%2fGet%3fid%3d781535%26showtimeDate%3d&rearUrl="
    case profile = "bergen-kino://page/custom?url=https%3A%2F%2Fapidev.filmgrail.com%2Fapiv2_22%2FUser%2Fprofile%2FGet%3Fid%3D17295"
    case nonTitledProfile = "bergen-kino://page/custom?url=https%3A%2F%2Fapidev.filmgrail.com%2Fapiv2_22%2FUser%2Fprofile%2FGet%3Fid%3D17295&needsTitle=false"
    case rearlayout = "bergen-kino://page/movie?frontUrl=https%3A%2F%2Fapidev.filmgrail.com%2Fapiv2_23%2FMovies%2FFront%2FGet%3Fid%3D776756%26showtimeDate%3D&rearUrl=https%3A%2F%2Fapidev.filmgrail.com%2Fapiv2_23%2FMovies%2FRear%2FGet%3Fid%3D776756&rearLayout=fullscreen"
    
    var url: URL? {
        return URL(string: rawValue)
    }
    
}
