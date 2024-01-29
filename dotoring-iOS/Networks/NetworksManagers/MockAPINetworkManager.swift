//
//  MockAPINetworkManager.swift
//  dotoring-iOS
//
//  Created by 우진 on 1/27/24.
//

import Foundation
import Alamofire

final class MockAPINetworkManager {
    
    // 싱글턴 적용
    static let shared = MockAPINetworkManager()
    
    let authenticator = OAuthAuthenticator()
    
    let credential = OAuthCredential(accessToken: KeyChain.read(key: KeyChainKey.accessToken) ?? "")
    
    let authInterceptor: AuthenticationInterceptor<OAuthAuthenticator>
    
    // 로거 설정
    let monitors = [BaseLogger()]
    
    let configuration: URLSessionConfiguration
    
    // 세션 설정
    let session: Session
    
    private init(session: Session = Session.default) {
        print("APINetworkManager() called!!!!")
        
        authInterceptor = AuthenticationInterceptor(
                    authenticator: authenticator,
                    credential: credential
                )
        
        // 인터셉터, 여기서 Jwt 확인
        let interceptors = Interceptor(interceptors:
                                    [
                                        BaseInterceptor(),
                                        authInterceptor
                                    ])
        
        // MockURLProtocol 등록
        configuration = URLSessionConfiguration.default
        configuration.protocolClasses = [MockURLProtocol.self]
        
        self.session = Session(configuration: configuration, interceptor: interceptors, eventMonitors: monitors)
    }
    
    func reloadCredential() {
        authInterceptor.credential = OAuthCredential(accessToken: KeyChain.read(key: KeyChainKey.accessToken) ?? "")
    }
    
    // JSON 파일에서 Mock 데이터 로드 및 HTTP 상태 코드 설정 메서드 추가
    func setMockDataAndStatusCode(fromJSONFile fileName: String, statusCode: Int) {
        if let path = Bundle.main.path(forResource: fileName, ofType: "json"),
           let jsonData = try? Data(contentsOf: URL(fileURLWithPath: path)) {
            MockURLProtocol.mockResponseData = jsonData
            MockURLProtocol.mockHTTPResponse = HTTPURLResponse(
                url: URL(string: "https://api.example.com/mock")!,
                statusCode: statusCode,
                httpVersion: "HTTP/1.1",
                headerFields: nil
            )
        } else {
            print("Error: Unable to load mock data from JSON file \(fileName).json")
        }
    }
    
}
