//
//  OAuthAuthenticator.swift
//  dotoring-iOS
//
//  Created by 우진 on 11/12/23.
//

import Foundation
import Alamofire

class OAuthAuthenticator: Authenticator {
    func apply(_ credential: OAuthCredential, to urlRequest: inout URLRequest) {
        print("OAuthAuthenticator - apply() called")
        urlRequest.headers.add(.authorization(bearerToken: credential.accessToken))
    }

    func refresh(_ credential: OAuthCredential,
                 for session: Session,
                 completion: @escaping (Result<OAuthCredential, Error>) -> Void) {
        print("OAuthAuthenticator - refresh() called")
        // Refresh the credential using the refresh token...then call completion with the new credential.
        //
        // The new credential will automatically be stored within the `AuthenticationInterceptor`. Future requests will
        // be authenticated using the `apply(_:to:)` method using the new credential.
        
        let urlToCall = BaseRouter.reIssue
        HomeNetworkManager
            .shared
            .session
            .request(urlToCall)
            .responseDecodable(of: LoginAPIResponse.self) { response in
                
                switch response.result {
                case .success(let successData):
                    
                    if successData.success == true {
                        print("OAuthAuthenticator - refresh() : 재인증 성공")
                        // 토큰 저장
                        guard let accessTokenData = response.response?.value(forHTTPHeaderField: "Authorization") else { return }
                        // accessToken 파싱
                        let parsedAccessToken = String(accessTokenData.dropFirst(7))
                        // 토큰 정보 저장
                        KeyChain.create(key: KeyChainKey.accessToken, token: parsedAccessToken)
                        
                        let newCredential = OAuthCredential(accessToken: parsedAccessToken)
                        completion(.success(newCredential))
                    } else if successData.error?.code == "9002" {
                        print("OAuthAuthenticator - refresh() : refreshToken 만료")
//                        Alert.showAuthErrorAlert(title: "인증 만료", message: "인증이 만료됐습니다. 다시 로그인해 주세요.")
                    } else {
                        print("OAuthAuthenticator - refresh() : 재인증 실패")
//                        Alert.showAlert(title: "인증 오류", message: "인증 오류가 발생했습니다. 다시 로그인해 주세요.")
                    }
                case .failure(let error):
                    print("OAuthAuthenticator - refresh() : 재인증 요청 실패 => \(error)")
//                    Alert.showAlert(title: "인증 오류", message: "인증 오류가 발생했습니다. 다시 로그인해 주세요.")
                }
            }
    }

    func didRequest(_ urlRequest: URLRequest,
                    with response: HTTPURLResponse,
                    failDueToAuthenticationError error: Error) -> Bool {
        print("OAuthAuthenticator - didRequest() called")
        // If authentication server CANNOT invalidate credentials, return `false`
        
        if response.statusCode == 401 {
            return true
        }
        
        return false

        // If authentication server CAN invalidate credentials, then inspect the response matching against what the
        // authentication server returns as an authentication failure. This is generally a 401 along with a custom
        // header value.
        // return response.statusCode == 401
    }

    func isRequest(_ urlRequest: URLRequest, authenticatedWith credential: OAuthCredential) -> Bool {
        print("OAuthAuthenticator - isRequest() called")
        // If authentication server CANNOT invalidate credentials, return `true`
        return true

        // If authentication server CAN invalidate credentials, then compare the "Authorization" header value in the
        // `URLRequest` against the Bearer token generated with the access token of the `Credential`.
        // let bearerToken = HTTPHeader.authorization(bearerToken: credential.accessToken).value
        // return urlRequest.headers["Authorization"] == bearerToken
    }
}

// 백엔드에서 status를 수정 해서 보내주면 삭제할 부분
//extension OAuthAuthenticator {
//    func handleAuthenticationError(urlRequest: URLRequest, response: HTTPURLResponse, error: Error) {
//    
//        print("Handling authentication error in another ViewController")
//        
//        if didRequest(urlRequest, with: response, failDueToAuthenticationError: error) {
//            print("handleAuthenticationError - didRequest() called")
//            
//            refresh(HomeNetworkManager.shared.credential, for: HomeNetworkManager.shared.session) { result in
//
//                switch result {
//                case .success:
//                    HomeNetworkManager.shared.reloadCredential()
//                case .failure:
//                    break
//                }
//                return
//            }
//        } else {
//            print("Authentication error, but not retrying the request.")
//            return
//        }
//    }
//}
