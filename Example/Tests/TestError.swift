//
//  TestError.swift
//  KinoAppRouter_Tests
//
//  Created by Alexander Bozhko on 26/12/2018.
//  Copyright © 2018 CocoaPods. All rights reserved.
//

import Foundation
import KinoAppRouter

enum DetailsConfigError: Error {
    
    case unknown
    
    case noContent
    
    case duplicatedPages
    
    var localizedDescription: String {
        switch self {
        case .unknown: return "Unknown error"
        case .noContent: return "No content"
        case .duplicatedPages: return "Duplicated pages"
        }
    }
    
}

extension Router {
    
    func checkConfig(_ detailsConfig: Router.DetailsConfig) throws {
        let rear = detailsConfig.rear
        let front = detailsConfig.front
        guard rear != nil || front != nil else {
            throw DetailsConfigError.noContent
        }
        guard rear?.id != front?.id else {
            throw DetailsConfigError.duplicatedPages
        }
        guard rear?.needsPaging != false || rear?.preloadedJson != nil else {
            throw DetailsConfigError.noContent
        }
        guard front?.needsPaging != false || front?.preloadedJson != nil else {
            throw DetailsConfigError.noContent
        }
    }
    
}
