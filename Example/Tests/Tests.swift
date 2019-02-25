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
        // TODO: - Create router instance
        let urls = input.enumerated().compactMap({ index, json -> URL? in
            if let url = router.url(json: json) {
                return url
            }
            XCTFail("Couldn't create url from json[\(index)]")
            return nil
        })
        let configs = urls.enumerated().compactMap({ index, url -> Router.DetailsConfig? in
            if let config = router.detailsConfig(from: url) {
                return config
            }
            XCTFail("Couldn't create config from url[\(index)]")
            return nil
        })
        configs.enumerated().forEach({ index, config in
            do {
                try router.checkConfig(config)
            } catch {
                if let err = error as? DetailsConfigError {
                    XCTFail(err.localizedDescription)
                } else {
                    XCTFail(error.localizedDescription)
                }
            }
        })
        
        XCTAssert(configs.count == input.count, "Some of urls is not parsed or not configured")
    }
    
}
