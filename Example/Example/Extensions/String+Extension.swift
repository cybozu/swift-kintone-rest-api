//
//  String+Extension.swift
//  Example
//
//  Created by ky0me22 on 2024/12/18.
//

extension String {
    init(optional instance: (some CustomStringConvertible)?) {
        self.init(String(describing: instance))
    }
}
