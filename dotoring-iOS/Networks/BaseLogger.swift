//
//  Logger.swift
//  dotoring-iOS
//
//  Created by 우진 on 11/9/23.
//

import Foundation
import Alamofire

final class BaseLogger: EventMonitor {
    
    let queue = DispatchQueue(label: "LoginLogger")
    
    // 모든 유형의 요청이 재개될 때 호출되는 이벤트입니다.
    func requestDidResume(_ request: Request) {
        print("BaseLogger - requestDidResume() called")
        debugPrint(request)
    }
    
    // DataRequest가 응답을 분석할 때마다 호출되는 이벤트입니다.
    func request<Value>(_ request: DataRequest, didParseResponse response: DataResponse<Value, AFError>) {
        print("BaseLogger - request.didParseResponse() called")
        debugPrint(request)
    }
    
}
