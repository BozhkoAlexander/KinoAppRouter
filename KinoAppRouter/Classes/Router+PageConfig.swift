//
//  Router+PageConfig.swift
//  KinoAppRouter
//
//  Created by Alexander Bozhko on 26/12/2018.
//

import Foundation

public extension Router {
    
    typealias DetailsConfig = (rear: PageConfig?, front: PageConfig?)
    
    struct PageConfig {
        
        public var id: String
        
        public var needsPaging: Bool
        
        public var needsTitle: Bool
        
        public var preloaded: String?
        
        public var url: URL? {
            guard needsPaging else { return nil }
            return URL(string: id)
        }
        
        public init?(id: String, needsPaging: Bool = false, needsTitle: Bool = true, preloaded: String? = nil) {
            guard !id.isEmpty else { return nil }
            self.id = id
            self.needsPaging = needsPaging
            self.needsTitle = needsTitle
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
