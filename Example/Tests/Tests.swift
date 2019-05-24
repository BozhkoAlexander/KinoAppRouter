import XCTest
import KinoAppRouter

class Tests: XCTestCase {
    
    var input: Array<Any>! = nil
    
    let router = Router.shared
    
    override func setUp() {
        super.setUp()
        
        input = (JSONReader.read("movies") as? Dictionary<String, Any>)?["Items"] as? Array<Any>
    }
    
    override func tearDown() {
        super.tearDown()
        
        input = nil
    }
    
    func testRouter() {
        XCTAssertNotNil(input, "No input data")
        var urls = input.enumerated().compactMap({ index, json -> URL? in
            if let url = router.url(json: json) {
                return url
            }
            XCTFail("Couldn't create url from json[\(index)]")
            return nil
        })
        // Add custom urls to test
        let customs = CustomURL.allCases
        let customUrls = customs.compactMap({ $0.url })
        urls.insert(contentsOf: customUrls, at: 0)
        let configs = urls.enumerated().compactMap({ index, url -> Router.DetailsConfig? in
            if let config = router.detailsConfig(from: url) {
                return config
            }
            XCTFail("Couldn't create config from url[\(index)]")
            return nil
        })
        configs.enumerated().forEach({ index, config in
            do {
                let custom = customs.count > index ? customs[index] : nil
                try router.checkConfig(config, custom: custom)
            } catch {
                let string = "\(index): \(urls[index]) - "
                if let err = error as? DetailsConfigError {
                    XCTFail(string + err.localizedDescription)
                } else {
                    XCTFail(string + error.localizedDescription)
                }
            }
        })
        
        XCTAssert(configs.count == input.count + customUrls.count, "Some of urls is not parsed or not configured")
    }
    
}
