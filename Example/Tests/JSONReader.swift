//
//  JSONReader.swift
//  KinoAppRouter_Tests
//
//  Created by Alexander Bozhko on 26/12/2018.
//  Copyright © 2018 CocoaPods. All rights reserved.
//

import Foundation

class JSONReader {
    
    class func read(_ fileName: String?) -> Any? {
        guard let path = Bundle(for: self).path(forResource: fileName, ofType: "json") else { return nil }
        let url = URL(fileURLWithPath: path)
        do {
            let data = try Data(contentsOf: url)
            return try JSONSerialization.jsonObject(with: data, options: .allowFragments)
        } catch {
            return nil
        }
    }
    
}
