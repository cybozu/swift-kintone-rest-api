//
//  KintoneAPI.swift
//
//
//  Created by ky0me22 on 2024/12/04.
//

import Foundation
import UniformTypeIdentifiers

public struct KintoneAPI: Sendable {
    var authenticationMethod: AuthenticationMethod
    var dataRequestHandler: @Sendable (URLRequest) async throws -> (Data, URLResponse)

    public init(
        authenticationMethod: AuthenticationMethod,
        dataRequestHandler: @escaping @Sendable (URLRequest) async throws -> (Data, URLResponse)
    ) {
        self.authenticationMethod = authenticationMethod
        self.dataRequestHandler = dataRequestHandler
    }

    private func makeRequest(
        httpMethod: HTTPMethod,
        endpoint: Endpoint,
        queryItems: [URLQueryItem] = [],
        httpBody: Data? = nil,
        contentType: ContentType = .applicationJSON
    ) -> URLRequest {
        var url = URL(string: "\(endpoint.rawValue)")!
        if !queryItems.isEmpty {
            url.append(queryItems: queryItems)
        }
        var request = URLRequest(url: url)
        request.httpMethod = httpMethod.rawValue
        request.addValue(
            authenticationMethod.headerValue,
            forHTTPHeaderField: authenticationMethod.headerField
        )
        if let httpBody {
            request.addValue(contentType.value, forHTTPHeaderField: "Content-Type")
            request.httpBody = httpBody
        }
        return request
    }

    private func check(response: URLResponse) throws {
        guard let httpResponse = response as? HTTPURLResponse,
              httpResponse.statusCode == 200 else {
            throw KintoneAPIError.invalidResponse
        }
    }

    public func fetchApps(
        appIDs: [Int]? = nil,
        codes: [String]? = nil,
        name: String? = nil,
        spaceIDs: [Int]? = nil,
        offset: Int? = nil,
        limit: Int? = nil
    ) async throws -> [KintoneApp] {
        var queryItems = [URLQueryItem]()
        queryItems.appendQueryItem(name: "ids", value: appIDs?.arrayString)
        queryItems.appendQueryItem(name: "codes", value: codes?.arrayString)
        queryItems.appendQueryItem(name: "name", value: name)
        queryItems.appendQueryItem(name: "spaceIds", value: spaceIDs?.arrayString)
        queryItems.appendQueryItem(name: "offset", value: offset?.description)
        queryItems.appendQueryItem(name: "limit", value: limit?.description)
        let request = makeRequest(httpMethod: .get, endpoint: .apps, queryItems: queryItems)
        let (data, response) = try await dataRequestHandler(request)
        try check(response: response)
        let kintoneAppsResponse = try JSONDecoder().decode(KintoneAppsResponse.self, from: data)
        return kintoneAppsResponse.apps
    }

    public func fetchFormLayout(
        appID: Int
    ) async throws -> [FormLayout] {
        let queryItems = [URLQueryItem(name: "app", value: appID.description)]
        let request = makeRequest(httpMethod: .get, endpoint: .formLayout, queryItems: queryItems)
        let (data, response) = try await dataRequestHandler(request)
        try check(response: response)
        let formLayoutResponse = try JSONDecoder().decode(FormLayoutResponse.self, from: data)
        return formLayoutResponse.layout
    }

    public func fetchFields(
        appID: Int,
        language: Language = .default
    ) async throws -> [FieldProperty] {
        let queryItems = [
            URLQueryItem(name: "app", value: appID.description),
            URLQueryItem(name: "lang", value: language.rawValue),
        ]
        let request = makeRequest(httpMethod: .get, endpoint: .fields, queryItems: queryItems)
        let (data, response) = try await dataRequestHandler(request)
        try check(response: response)
        let fieldsResponse = try JSONDecoder().decode(FieldsResponse.self, from: data)
        return fieldsResponse.properties
    }

    public func submitRecord(
        appID: Int,
        fields: [RecordField]
    ) async throws {
        let httpBody = try JSONEncoder().encode(RecordRequest(appID: appID, fields: fields))
        let request = makeRequest(httpMethod: .post, endpoint: .record, httpBody: httpBody)
        let (_, response) = try await dataRequestHandler(request)
        try check(response: response)
    }
    
    public func uploadFile(
        appID: Int,
        fileName: String,
        type: UTType,
        data: Data
    ) async throws -> String {
        let boundary = "---------\(UUID().uuidString)"
        let mimeType = type.preferredMIMEType ?? "application/octet-stream"
        var httpBody = Data()
        httpBody.append("--\(boundary)\r\n".data(using: .utf8)!)
        httpBody.append("Content-Disposition: form-data; name=\"file\";".data(using: .utf8)!)
        httpBody.append("filename=\"\(fileName)\"\r\n".data(using: .utf8)!)
        httpBody.append("Content-Type: \(mimeType)\r\n\r\n".data(using: .utf8)!)
        httpBody.append(data)
        httpBody.append("\r\n".data(using: .utf8)!)
        httpBody.append("--\(boundary)--\r\n".data(using: .utf8)!)
        let request = makeRequest(httpMethod: .post, endpoint: .file, httpBody: httpBody, contentType: .multipartFormData(boundary))
        let (data, response) = try await dataRequestHandler(request)
        try check(response: response)
        let fileResponse = try JSONDecoder().decode(FileResponse.self, from: data)
        return fileResponse.fileKey
    }
}
