//
//  KeyedDecodingContainer+Extension.swift
//
//
//  Created by ky0me22 on 2025/01/22.
//

import Foundation

extension KeyedDecodingContainer {
    func customDecode<T, S>(
        _ type: T.Type,
        forKey key: KeyedDecodingContainer<K>.Key,
        initializer: (T) -> S?
    ) throws -> S where S: Decodable, T: Decodable {
        let rawValue = try decode(type, forKey: key)
        guard let value = initializer(rawValue) else {
            throw DecodingError.typeMismatch(S.self, .init(
                codingPath: [key],
                debugDescription: "Failed to decode \(key)"
            ))
        }
        return value
    }

    func customDecodeIfPresent<T, S>(
        _ type: T.Type,
        forKey key: KeyedDecodingContainer<K>.Key,
        initializer: (T) -> S?
    ) throws -> S? where S: Decodable, T: Decodable {
        guard let rawValue = try decodeIfPresent(type, forKey: key) else {
            return nil
        }
        guard let value = initializer(rawValue) else {
            throw DecodingError.typeMismatch(S.self, .init(
                codingPath: [key],
                debugDescription: "Failed to decode \(key)"
            ))
        }
        return value
    }
}
