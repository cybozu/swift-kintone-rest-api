//
//  String+Extension.swift
//
//
//  Created by ky0me22 on 2024/12/06.
//

extension String {
    var normalizedDateTime: String {
        replacingOccurrences(
            of: "\\.\\d\\d\\dZ$",
            with: "Z",
            options: .regularExpression
        )
        .replacingOccurrences(
            of: "(T\\d\\d:\\d\\d)$",
            with: "$0:00Z",
            options: .regularExpression
        )
    }

    var normalizedTime: String {
        replacingOccurrences(
            of: ":\\d\\d.\\d\\d\\d$",
            with: "",
            options: .regularExpression
        )
    }
}
