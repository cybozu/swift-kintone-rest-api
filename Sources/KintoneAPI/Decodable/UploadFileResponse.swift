//
//  UploadFileResponse.swift
//
//
//  Created by ky0me22 on 2025/01/21.
//

public typealias FileKey = String

struct UploadFileResponse: Decodable {
    var fileKey: FileKey
}
