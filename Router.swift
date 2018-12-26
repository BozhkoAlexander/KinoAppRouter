//
//  KinoAppRouter.swift
//  KinoAppRouter
//
//  Created by Alexander Bozhko on 26/12/2018.
//

import Foundation

public class Router {
    
    let scheme: String
    
    public init() {
        self.scheme = Router.scheme()
    }
    
    // MARK: - Public properties
    
    private var baseComponents: URLComponents {
        var components = URLComponents()
        components.scheme = scheme
        components.host = "page"
        
        return components
    }
    
}

extension Router {
    
    // MARK: - Helpers
    
    private class func scheme() -> String {
        var scheme = "kino-app"
        if let urlTypes = Bundle.main.object(forInfoDictionaryKey: "CFBundleURLTypes") as? Array<Dictionary<String, Any>> {
            let urls = urlTypes.compactMap({ ($0["CFBundleURLSchemes"] as? Array<String>)?.first })
            if urls.count > 1, let s = urls.filter({ $0.contains("kino") }).first {
                scheme = s
            } else if !urls.isEmpty {
                scheme = urls[0]
            }
        }
        return scheme
    }
    
}
