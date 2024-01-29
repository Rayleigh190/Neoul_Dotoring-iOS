//
//  MockURLProtocol.swift
//  dotoring-iOS
//
//  Created by 우진 on 1/27/24.
//

import Foundation

class MockURLProtocol: URLProtocol {
    
    // 실제 네트워크 요청 대신 반환할 mock 데이터
    static var mockResponseData: Data?
    static var mockHTTPResponse: HTTPURLResponse?

    override class func canInit(with request: URLRequest) -> Bool {
        return true
    }

    override class func canonicalRequest(for request: URLRequest) -> URLRequest {
        return request
    }

    override func startLoading() {
        if let mockData = MockURLProtocol.mockResponseData, let mockHTTPResponse = MockURLProtocol.mockHTTPResponse {
            // mock 데이터와 HTTP 응답 코드를 사용하여 응답 생성
            self.client?.urlProtocol(self, didReceive: mockHTTPResponse, cacheStoragePolicy: .notAllowed)
            self.client?.urlProtocol(self, didLoad: mockData)
        }
        self.client?.urlProtocol(self, didReceive: HTTPURLResponse(), cacheStoragePolicy: .notAllowed)

        // 요청 완료
        self.client?.urlProtocolDidFinishLoading(self)
    }

    override func stopLoading() {
        // 아무것도 하지 않음
    }    
}
