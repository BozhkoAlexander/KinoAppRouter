//
//  Router+PageConfig.swift
//  KinoAppRouter
//
//  Created by Alexander Bozhko on 26/12/2018.
//

import Foundation

public extension Router {
    
    public typealias DetailsConfig = (rear: PageConfig?, front: PageConfig?)
    
    public struct PageConfig {
        
        public var id: String
        
        public var needsPaging: Bool
        
        public var preloaded: String?
        
        public init(id: String, needsPaging: Bool = false, preloaded: String? = nil) {
            self.id = id
            self.needsPaging = needsPaging
            self.preloaded = preloaded
        }
        
        public var preloadedJson: Any? {
            guard let data = preloaded?.data(using: .utf8) else { return nil }
            do {
                return try JSONSerialization.jsonObject(with: data, options: .allowFragments)
            } catch {
                return nil
            }
        }
        
    }
    
}
