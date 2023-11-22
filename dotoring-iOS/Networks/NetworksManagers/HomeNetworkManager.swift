//
//  HomeNetworkManager.swift
//  dotoring-iOS
//
//  Created by 우진 on 11/12/23.
//

import Foundation
import Alamofire

final class HomeNetworkManager {
    
    // 싱글턴 적용
    static let shared = HomeNetworkManager()
    
    // Create the interceptor
    let authenticator = OAuthAuthenticator()
    
    // Generally load from keychain if it exists
    let credential = OAuthCredential(accessToken: KeyChain.read(key: KeyChainKey.accessToken) ?? "", refreshToken: KeyChain.read(key: KeyChainKey.refreshToken) ?? "")
    
    let authInterceptor: AuthenticationInterceptor<OAuthAuthenticator>
    
    // 로거 설정
    let monitors = [BaseLogger()]
    
    // 세션 설정
    var session : Session
    
    private init(session: Session = Session.default) {
        print("HomeNetworkManager() called!!!!")
        
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
        
        self.session = Session(
            interceptor: interceptors,
            eventMonitors: monitors
        )
    }
    
    func reloadCredential() {
        authInterceptor.credential = OAuthCredential(accessToken: KeyChain.read(key: KeyChainKey.accessToken) ?? "", refreshToken: KeyChain.read(key: KeyChainKey.refreshToken) ?? "")
    }
    
}
