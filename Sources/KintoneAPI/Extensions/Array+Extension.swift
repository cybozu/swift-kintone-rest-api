//
//  Array+Extension.swift
//
//
//  Created by ky0me22 on 2024/12/06.
//

import Foundation

extension [String] {
    func queryItems(name: String) -> [URLQueryItem] {
        self.enumerated().map { offset, value in
            URLQueryItem(name: "\(name)[\(offset)]", value: value)
        }
    }
}
