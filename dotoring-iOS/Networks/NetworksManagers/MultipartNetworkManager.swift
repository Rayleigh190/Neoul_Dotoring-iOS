//
//  MultipartNetworkManager.swift
//  dotoring-iOS
//
//  Created by 우진 on 12/30/23.
//

import Foundation
import Alamofire

final class MultipartNetworkManager {
    
    // 싱글턴 적용
    static let shared = MultipartNetworkManager()
    
    // 인터셉터, 여기서 Jwt 확인
    let interceptors = Interceptor(interceptors:
                                    [
                                        MultipartInterceptor()
                                    ])
    
    // 로거 설정
    let monitors = [BaseLogger()]
    
    // 세션 설정
    var session : Session
    
    private init(session: Session = Session.default) {
        self.session = Session(
            interceptor: interceptors,
            eventMonitors: monitors
        )
    }
    
}
