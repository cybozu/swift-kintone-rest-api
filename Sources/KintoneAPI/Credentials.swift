//
//  Credentials.swift
//
//
//  Created by ky0me22 on 2024/12/18.
//

public struct Credentials: Sendable {
    var loginName: String
    var password: String

    public init(loginName: String, password: String) {
        self.loginName = loginName
        self.password = password
    }

    var base64EncodedValue: String {
        let value = "\(loginName):\(password)"
        guard let data = value.data(using: .utf8) else {
            fatalError("Failed to convert value to data")
        }
        return data.base64EncodedString(options: [])
    }
}
