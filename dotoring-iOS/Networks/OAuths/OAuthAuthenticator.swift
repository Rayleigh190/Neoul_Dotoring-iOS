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
    }

    func didRequest(_ urlRequest: URLRequest,
                    with response: HTTPURLResponse,
                    failDueToAuthenticationError error: Error) -> Bool {
        print("OAuthAuthenticator - didRequest() called")
        // If authentication server CANNOT invalidate credentials, return `false`
        return false

        // If authentication server CAN invalidate credentials, then inspect the response matching against what the
        // authentication server returns as an authentication failure. This is generally a 401 along with a custom
        // header value.
        // return response.statusCode == 401
    }

    func isRequest(_ urlRequest: URLRequest, authenticatedWith credential: OAuthCredential) -> Bool {
        // If authentication server CANNOT invalidate credentials, return `true`
        return true

        // If authentication server CAN invalidate credentials, then compare the "Authorization" header value in the
        // `URLRequest` against the Bearer token generated with the access token of the `Credential`.
        // let bearerToken = HTTPHeader.authorization(bearerToken: credential.accessToken).value
        // return urlRequest.headers["Authorization"] == bearerToken
    }
}
