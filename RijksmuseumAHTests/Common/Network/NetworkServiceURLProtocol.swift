//
//  NetworkServiceURLProtocol.swift
//  RijksmuseumAHTests
//
//  Created by Laurentiu Cociu on 9/17/25.
//

import Foundation

final class NetworkServiceURLProtocol: URLProtocol {
    static var targetURLs: [NetworkServiceTargetURL] = []
    
    public override class func canInit(with request: URLRequest) -> Bool {
        return true
    }
    
    public override class func canonicalRequest(for request: URLRequest) -> URLRequest {
        return request
    }
    
    public override func startLoading() {
        guard let client = client else {
            return
        }
        
        let matchingTargetURL = NetworkServiceURLProtocol.targetURLs.first(where: { targetURL in
            return targetURL.url == request.url
        })
        
        if let matchingTargetURL = matchingTargetURL {
            switch matchingTargetURL.behaviour {
            case .success(let data):
                let response = URLResponse()
                client.urlProtocol(self, didReceive: response, cacheStoragePolicy: .notAllowed)
                client.urlProtocol(self, didLoad: data)
                client.urlProtocolDidFinishLoading(self)
            case .failure:
                let error = NSError(domain: "Unit tests", code: 0)
                client.urlProtocol(self, didFailWithError: error)
            }
        } else {
            let error = NSError(domain: "Unit tests", code: 0)
            client.urlProtocol(self, didFailWithError: error)
        }
    }
    
    public override func stopLoading() {
        // required override from URLProtocol
    }
}
