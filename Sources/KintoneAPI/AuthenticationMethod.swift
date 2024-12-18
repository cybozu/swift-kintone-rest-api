//
//  AuthenticationMethod.swift
//
//
//  Created by ky0me22 on 2024/12/17.
//

public enum AuthenticationMethod: Sendable {
    case cybozuAuthorization(Credentials)
    case cybozuAPIToken(String)
    case cybozuSession

    var headerField: String {
        switch self {
        case .cybozuAuthorization:
            "X-Cybozu-Authorization"
        case .cybozuAPIToken:
            "X-Cybozu-API-Token"
        case .cybozuSession:
            "X-Requested-With"
        }
    }

    var headerValue: String {
        switch self {
        case let .cybozuAuthorization(credentials):
            credentials.base64EncodedValue
        case let .cybozuAPIToken(token):
            token
        case .cybozuSession:
            "URLRequest"
        }
    }
}
