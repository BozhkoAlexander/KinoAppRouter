//
//  Router.swift
//  Router
//
//  Created by Alexander Bozhko on 26/12/2018.
//

import Foundation

public class Router {
    
    let scheme: String
    
    // MARK: - Singletone
    
    public static let shared = Router()

    internal init() {
        self.scheme = Router.scheme()
    }
    
    // MARK: - Public properties & methods
    
    public var baseURL: URL? {
        var components = URLComponents()
        components.scheme = scheme
        components.host = pageKey
        
        return components.url
    }
    
    public func url(path: String? = nil, rearConfig: PageConfig? = nil, frontConfig: PageConfig? = nil) -> URL? {
        var components = URLComponents()
        if let path = path, !path.isEmpty {
            components.path = String(format: "/%@", path)
        }
        var q = Array<URLQueryItem>()
        if let rear = rearConfig {
            if rear.needsPaging {
                q.append(URLQueryItem(name: rearKey, value: rear.id))
            }
            if let json = rear.preloaded {
                q.append(URLQueryItem(name: rearJsonKey, value: json))
            }
        }
        if let front = frontConfig {
            if front.needsPaging {
                q.append(URLQueryItem(name: frontKey, value: front.id))
            }
            if let json = front.preloaded {
                q.append(URLQueryItem(name: frontJsonKey, value: json))
            }
        }
        components.queryItems = q
        
        return components.url(relativeTo: baseURL)
    }
    
    public func detailsConfig(from url: URL) -> DetailsConfig? {
        guard let components = URLComponents(url: url, resolvingAgainstBaseURL: true) else { return nil }
        var pageId = components.path
        pageId.removeFirst()
        
        var rear: PageConfig? = nil
        var front: PageConfig? = nil
        
        if let q = components.queryItems {
            let rearId = q.filter({ $0.name.lowercased() == rearKey }).first?.value
            let rearJson = q.filter({ $0.name.lowercased() == rearJsonKey }).first?.value
            if rearId != nil || rearJson != nil {
                let needsPaging = rearId != nil
                let id = needsPaging ? rearId! : String(format: "%@-%@", pageId, rearKey)
                rear = PageConfig(id: id, needsPaging: needsPaging, preloaded: rearJson)
            }
            
            let frontId = q.filter({ $0.name.lowercased() == frontKey }).first?.value
            let frontJson = q.filter({ $0.name.lowercased() == frontJsonKey }).first?.value
            if frontId != nil || frontJson != nil {
                let needsPaging = frontId != nil
                let id = needsPaging ? frontId! : String(format: "%@-%@", pageId, frontKey)
                front = PageConfig(id: id, needsPaging: needsPaging, preloaded: frontJson)
            }
            
            if rear == nil && front == nil {
                let json = q.filter({ $0.name.lowercased() == jsonKey }).first?.value
                if json != nil {
                    let id = String(format: "%@-%@", pageId, rearKey)
                    rear = PageConfig(id: id, needsPaging: false, preloaded: json)
                }
            }
        }
        
        return DetailsConfig(rear: rear, front)
    }
    
    // MARK: - Private properties
    
    private let pageKey = "page"
    
    private let rearKey = "rearurl"
    private let rearJsonKey = "rearjson"
    private let frontKey = "fronturl"
    private let frontJsonKey = "frontjson"
    private let jsonKey = "json"
    
}

// MARK: - Helpers

extension Router {
    
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
