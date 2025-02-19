//
//  FetchFormLayoutResponse.swift
//
//
//  Created by ky0me22 on 2024/12/04.
//

struct FetchFormLayoutResponse: Decodable {
    var formLayout: FormLayout

    init(from decoder: any Decoder) throws {
        formLayout = try FormLayout(from: decoder)
    }
}
