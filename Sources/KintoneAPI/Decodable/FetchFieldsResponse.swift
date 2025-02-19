//
//  FetchFieldsResponse.swift
//
//
//  Created by ky0me22 on 2024/12/04.
//

struct FetchFieldsResponse: Decodable {
    var fields: Fields

    init(from decoder: any Decoder) throws {
        fields = try Fields(from: decoder)
    }
}
