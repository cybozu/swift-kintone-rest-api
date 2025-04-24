//
//  Array+Extension.swift
//
//
//  Created by ky0me22 on 2024/12/06.
//

import Foundation

extension [URLQueryItem] {
    mutating func appendQueryItem(name: String, value: String?) {
        if let value {
            append(.init(name: name, value: value))
        }
    }

    mutating func appendQueryItems(name: String, values: [String]?) {
        guard let values else { return }
        values.enumerated().forEach { offset, value in
            append(.init(name: "\(name)[\(offset)]", value: value))
        }
    }
}
