//
//  KintoneAPI.swift
//
//
//  Created by ky0me22 on 2024/12/04.
//

import Foundation

public struct KintoneAPI: Sendable {
    public typealias FileKey = String
    
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
        let fetchAppsResponse = try JSONDecoder().decode(FetchAppsResponse.self, from: data)
        return fetchAppsResponse.apps
    }

    public func fetchFormLayout(
        appID: Int
    ) async throws -> [FormLayout] {
        let queryItems = [URLQueryItem(name: "app", value: appID.description)]
        let request = makeRequest(httpMethod: .get, endpoint: .formLayout, queryItems: queryItems)
        let (data, response) = try await dataRequestHandler(request)
        try check(response: response)
        let fetchFormLayoutResponse = try JSONDecoder().decode(FetchFormLayoutResponse.self, from: data)
        return fetchFormLayoutResponse.layout
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
        let fetchFieldsResponse = try JSONDecoder().decode(FetchFieldsResponse.self, from: data)
        return fetchFieldsResponse.properties
    }

    @discardableResult
    public func submitRecord(
        appID: Int,
        record: Record.Write
    ) async throws -> RecordIdentity.Read {
        let httpBody = try JSONEncoder().encode(SubmitRecordRequest(appID: appID, record: record))
        let request = makeRequest(httpMethod: .post, endpoint: .record, httpBody: httpBody)
        let (data, response) = try await dataRequestHandler(request)
        try check(response: response)
        let submitRecordResponse = try JSONDecoder().decode(SubmitRecordResponse.self, from: data)
        return submitRecordResponse.recordIdentity
    }
    
    @discardableResult
    public func updateRecord(
        appID: Int,
        recordIdentity: RecordIdentity.Write,
        record: Record.Write
    ) async throws -> RecordIdentity.Read {
        let httpBody = try JSONEncoder().encode(UpdateRecordRequest(appID: appID, recordIdentity: recordIdentity, record: record))
        let request = makeRequest(httpMethod: .put, endpoint: .record, httpBody: httpBody)
        let (data, response) = try await dataRequestHandler(request)
        try check(response: response)
        let updateRecordResponse = try JSONDecoder().decode(UpdateRecordResponse.self, from: data)
        return RecordIdentity.Read(id: recordIdentity.id, revision: updateRecordResponse.revision)
    }
    
    public func fetchRecords(
        appID: Int,
        fields: [String]? = nil,
        query: String? = nil
    ) async throws -> [Record.Read] {
        var queryItems = [URLQueryItem]()
        queryItems.appendQueryItem(name: "app", value: appID.description)
        queryItems.appendQueryItem(name: "fields", value: fields?.arrayString)
        queryItems.appendQueryItem(name: "query", value: query)
        let request = makeRequest(httpMethod: .get, endpoint: .records, queryItems: queryItems)
        let (data, response) = try await dataRequestHandler(request)
        try check(response: response)
        let fetchRecordsResponse = try JSONDecoder().decode(FetchRecordsResponse.self, from: data)
        return fetchRecordsResponse.records
    }
    
    public func removeRecords(
        appID: Int,
        recordIdentities: [RecordIdentity.Write]
    ) async throws {
        let httpBody = try JSONEncoder().encode(RemoveRecordsRequest(appID: appID, recordIdentities: recordIdentities))
        let request = makeRequest(httpMethod: .delete, endpoint: .records, httpBody: httpBody)
        let (_, response) = try await dataRequestHandler(request)
        try check(response: response)
    }
    
    public func uploadFile(
        fileName: String,
        mimeType: String,
        data: Data
    ) async throws -> FileKey {
        let boundary = "---------\(UUID().uuidString)"
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
        let uploadFileResponse = try JSONDecoder().decode(UploadFileResponse.self, from: data)
        return uploadFileResponse.fileKey
    }
    
    public func downloadFile(
        fileKey: String
    ) async throws -> Data {
        let queryItems = [URLQueryItem(name: "fileKey", value: fileKey)]
        let request = makeRequest(httpMethod: .get, endpoint: .file, queryItems: queryItems)
        let (data, response) = try await dataRequestHandler(request)
        try check(response: response)
        return data
    }
}
