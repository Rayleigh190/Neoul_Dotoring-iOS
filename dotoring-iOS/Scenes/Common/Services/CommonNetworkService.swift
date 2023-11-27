//
//  CommonNetworkService.swift
//  dotoring-iOS
//
//  Created by 우진 on 11/18/23.
//

import Foundation
import Alamofire
import JWTDecode

class CommonNetworkService {
    
    /// 로그인을 요청합니다.
    /// - Parameters:
    ///   - userID: 사용자 아이디
    ///   - userPW: 사용자 비밀번호
    ///   - setAutoLogin: 자동 로그인 체크 여부
    ///   - completion: 로그인 요청 응답과 에러를 반환
    class func getLogin(userID: String, userPW: String, setAutoLogin: Bool, _ completion: @escaping (LoginAPIResponse?, Error?) -> Void) {
        // 사용자가 입력한 아이디와 비밀번호를 받습니다.
        let urlToCall = BaseRouter.userLogin(userID: userID, userPW: userPW)
        
        BaseNetworkManager
            .shared
            .session
            .request(urlToCall)
            .validate(statusCode: 200..<300) // 200~300 사이가 아니면 interceptor에서 retry를 함
            .responseDecodable(of: LoginAPIResponse.self) { response in
                switch response.result {
                case .success(let successData):
                    print("HomeNetworkService - getLogin() : 로그인 성공")
                    if successData.success == true {
                        // 토큰 저장
                        guard let accessTokenData = response.response?.value(forHTTPHeaderField: "Authorization") else { return }
//                        guard let refreshTokenData = response.response?.value(forHTTPHeaderField: "Set-Cookie") else { return }
                        
                        // accessToken 파싱
                        let parsedAccessToken = String(accessTokenData.dropFirst(7))
                        
                        // refreshToken 파싱
//                        let startIndex = refreshTokenData.index(after: refreshTokenData.firstIndex(of: "=")!)
//                        let endIndex = refreshTokenData.index(before: refreshTokenData.firstIndex(of: ";")!)
//                        let parsedRefreshToken = String(refreshTokenData[startIndex...endIndex])
                        
//                        print("HomeNetworkService - parsed Access Token : \(parsedAccessToken)")
//                        print("HomeNetworkService - parsed Refresh Token : \(parsedRefreshToken)")
                        
                        var decodedAccessToken: JWT
//                        var decodedRefreshToken: JWT
                        
                        do {
                            decodedAccessToken = try decode(jwt: parsedAccessToken)
//                            decodedRefreshToken = try decode(jwt: parsedRefreshToken)
//                            print("decoded Access Token : \(decodedAccessToken)")
//                            print("decoded Refresh Token : \(decodedRefreshToken)")
                        } catch {
                            print("HomeNetworkService - 토큰 디코딩 실패")
                            debugPrint(error)
                            return
                        }
                        
                        // MENTO 또는 MENTI UI 설정
                        if decodedAccessToken["aud"].string == "MENTO" {
                            print("HomeNetworkService - 로그인 유저 타입 : 멘토")
                            UserDefaults.standard.set("mento", forKey: "UIStyle")
                        } else {
                            print("HomeNetworkService - 로그인 유저 타입 : 멘티")
                            UserDefaults.standard.set("mentee", forKey: "UIStyle")
                        }
                        
                        // 토큰 정보 저장
                        KeyChain.create(key: KeyChainKey.accessToken, token: parsedAccessToken)
//                        KeyChain.create(key: KeyChainKey.refreshToken, token: parsedRefreshToken)
                        
                        // 자동 로그인 체크 했을시 id, pw 저장
                        if setAutoLogin {
                            KeyChain.create(key: KeyChainKey.userID, token: userID)
                            KeyChain.create(key: KeyChainKey.userPW, token: userPW)
                            print("HomeNetworkService - saveUserAccountInfo() : 자동 로그인 정보 저장")
                        }
                        
                        return completion(successData, nil)
                    } else {
                        // 로그인 실패
                        print("HomeNetworkService - getLogin() : 로그인 실패")
                        return completion(successData, nil)
                    }
                case .failure(let error):
                    print("HomeNetworkService - getLogin() : 로그인 요청 에러")
                    return completion(nil, error)
                }
            }
    }
    
}
