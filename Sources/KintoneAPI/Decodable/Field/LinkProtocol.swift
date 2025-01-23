//
//  LinkProtocol.swift
//
//
//  Created by ky0me22 on 2024/12/06.
//

public enum LinkProtocol: String, Decodable, Sendable {
    case web = "WEB"
    case call = "CALL"
    case mail = "MAIL"
}
