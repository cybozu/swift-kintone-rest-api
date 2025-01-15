//
//  URLRequest+Extension.swift
//
//
//  Created by ky0me22 on 2025/01/15.
//

import Foundation

extension URLRequest {
    public func inserted(domain: String) throws -> Self {
        guard let url else { throw KintoneAPIError.unresolvedRequestURL }
        var request = self
        request.url = URL(string: "https://\(domain)\(url.absoluteString)")
        return request
    }
}
