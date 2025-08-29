//
//  KintoneAPI.swift
//
//
//  Created by ky0me22 on 2024/12/04.
//

import Foundation

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
        guard let httpResponse = response as? HTTPURLResponse else {
            throw KintoneAPIError.invalidResponse
        }
        guard httpResponse.statusCode == 200 else {
            throw KintoneAPIError.requestFailed(ErrorDetail(
                statusCode: httpResponse.statusCode,
                cybozuError: httpResponse.value(forHTTPHeaderField: "X-Cybozu-Error")
            ))
        }
    }

    public func fetchApps(
        appIDs: [Int]? = nil,
        codes: [String]? = nil,
        name: String? = nil,
        spaceIDs: [Int]? = nil,
        offset: Int? = nil,
        limit: Int? = nil
    ) async throws -> FetchAppsResponse {
        let queryItems = [
            appIDs?.compactMap { String(describing: $0) }.queryItems(name: "ids"),
            codes.map { $0.queryItems(name: "codes") },
            name.map { [URLQueryItem(name: "name", value: $0)] },
            spaceIDs?.compactMap { String(describing: $0) }.queryItems(name: "spaceIds"),
            offset.map { [URLQueryItem(name: "offset", value: String(describing: $0))] },
            limit.map { [URLQueryItem(name: "limit", value: String(describing: $0))] },
        ].compactMap(\.self).flatMap(\.self)
        let request = makeRequest(httpMethod: .get, endpoint: .apps, queryItems: queryItems)
        let (data, response) = try await dataRequestHandler(request)
        try check(response: response)
        return try JSONDecoder().decode(FetchAppsResponse.self, from: data)
    }

    public func fetchFormLayout(
        appID: Int
    ) async throws -> FetchFormLayoutResponse {
        let queryItems = [URLQueryItem(name: "app", value: String(describing: appID))]
        let request = makeRequest(httpMethod: .get, endpoint: .formLayout, queryItems: queryItems)
        let (data, response) = try await dataRequestHandler(request)
        try check(response: response)
        return try JSONDecoder().decode(FetchFormLayoutResponse.self, from: data)
    }

    public func fetchFields(
        appID: Int,
        language: Language = .default
    ) async throws -> FetchFieldsResponse {
        let queryItems = [
            URLQueryItem(name: "app", value: String(describing: appID)),
            URLQueryItem(name: "lang", value: language.rawValue),
        ]
        let request = makeRequest(httpMethod: .get, endpoint: .fields, queryItems: queryItems)
        let (data, response) = try await dataRequestHandler(request)
        try check(response: response)
        return try JSONDecoder().decode(FetchFieldsResponse.self, from: data)
    }

    public func fetchAppSettings(
        appID: Int,
        language: Language = .default
    ) async throws -> FetchAppSettingsResponse {
        let queryItems = [
            URLQueryItem(name: "app", value: String(describing: appID)),
            URLQueryItem(name: "lang", value: language.rawValue),
        ]
        let request = makeRequest(httpMethod: .get, endpoint: .appSettings, queryItems: queryItems)
        let (data, response) = try await dataRequestHandler(request)
        try check(response: response)
        return try JSONDecoder().decode(FetchAppSettingsResponse.self, from: data)
    }

    public func fetchAppStatusSettings(
        appID: Int,
        language: Language = .default
    ) async throws -> FetchAppStatusSettingsResponse {
        let queryItems = [
            URLQueryItem(name: "app", value: String(describing: appID)),
            URLQueryItem(name: "lang", value: language.rawValue),
        ]
        let request = makeRequest(httpMethod: .get, endpoint: .appStatus, queryItems: queryItems)
        let (data, response) = try await dataRequestHandler(request)
        try check(response: response)
        return try JSONDecoder().decode(FetchAppStatusSettingsResponse.self, from: data)
    }

    public func fetchAppViewSettings(
        appID: Int,
        language: Language = .default
    ) async throws -> FetchAppViewSettingsResponse {
        let queryItems = [
            URLQueryItem(name: "app", value: String(describing: appID)),
            URLQueryItem(name: "lang", value: language.rawValue),
        ]
        let request = makeRequest(httpMethod: .get, endpoint: .appViews, queryItems: queryItems)
        let (data, response) = try await dataRequestHandler(request)
        try check(response: response)
        return try JSONDecoder().decode(FetchAppViewSettingsResponse.self, from: data)
    }

    public func fetchRecords(
        appID: Int,
        fields: [String]? = nil,
        query: String? = nil,
        totalCount: Bool? = nil
    ) async throws -> FetchRecordsResponse {
        let queryItems = [
            [URLQueryItem(name: "app", value: String(describing: appID))],
            fields.map { $0.queryItems(name: "fields") },
            query.map { [URLQueryItem(name: "query", value: $0)] },
            totalCount.map { [URLQueryItem(name: "totalCount", value: String(describing: $0))] }
        ].compactMap(\.self).flatMap(\.self)
        let request = makeRequest(httpMethod: .get, endpoint: .records, queryItems: queryItems)
        let (data, response) = try await dataRequestHandler(request)
        try check(response: response)
        return try JSONDecoder().decode(FetchRecordsResponse.self, from: data)
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

    public func fetchRecord(
        appID: Int,
        recordID: Int
    ) async throws -> FetchRecordResponse {
        let queryItems = [
            URLQueryItem(name: "app", value: String(describing: appID)),
            URLQueryItem(name: "id", value: String(describing: recordID)),
        ]
        let request = makeRequest(httpMethod: .get, endpoint: .record, queryItems: queryItems)
        let (data, response) = try await dataRequestHandler(request)
        try check(response: response)
        return try JSONDecoder().decode(FetchRecordResponse.self, from: data)
    }

    @discardableResult
    public func submitRecord(
        appID: Int,
        record: Record.Write
    ) async throws -> SubmitRecordResponse {
        let httpBody = try JSONEncoder().encode(SubmitRecordRequest(appID: appID, record: record))
        let request = makeRequest(httpMethod: .post, endpoint: .record, httpBody: httpBody)
        let (data, response) = try await dataRequestHandler(request)
        try check(response: response)
        return try JSONDecoder().decode(SubmitRecordResponse.self, from: data)
    }

    @discardableResult
    public func updateRecord(
        appID: Int,
        recordIdentity: RecordIdentity.Write,
        record: Record.Write
    ) async throws -> UpdateRecordResponse {
        let httpBody = try JSONEncoder().encode(UpdateRecordRequest(appID: appID, recordIdentity: recordIdentity, record: record))
        let request = makeRequest(httpMethod: .put, endpoint: .record, httpBody: httpBody)
        let (data, response) = try await dataRequestHandler(request)
        try check(response: response)
        return try JSONDecoder().decode(UpdateRecordResponse.self, from: data)
    }

    public func fetchRecordComments(
        appID: Int,
        recordID: Int,
        order: Order? = nil,
        offset: Int? = nil,
        limit: Int? = nil
    ) async throws -> FetchRecordCommentsResponse {
        let queryItems = [
            URLQueryItem(name: "app", value: String(describing: appID)),
            URLQueryItem(name: "record", value: String(describing: recordID)),
            order.map { URLQueryItem(name: "order", value: $0.rawValue) },
            offset.map { URLQueryItem(name: "offset", value: String(describing: $0)) },
            limit.map { URLQueryItem(name: "limit", value: String(describing: $0)) },
        ].compactMap(\.self)
        let request = makeRequest(httpMethod: .get, endpoint: .recordComments, queryItems: queryItems)
        let (data, response) = try await dataRequestHandler(request)
        try check(response: response)
        return try JSONDecoder().decode(FetchRecordCommentsResponse.self, from: data)
    }

    @discardableResult
    public func updateStatus(
        appID: Int,
        recordIdentity: RecordIdentity.Write,
        actionName: String,
        assignee: String?
    ) async throws -> UpdateStatusResponse {
        let httpBody = try JSONEncoder().encode(UpdateStatusRequest(appID: appID, recordIdentity: recordIdentity, actionName: actionName, assignee: assignee))
        let request = makeRequest(httpMethod: .put, endpoint: .recordStatus, httpBody: httpBody)
        let (data, response) = try await dataRequestHandler(request)
        try check(response: response)
        return try JSONDecoder().decode(UpdateStatusResponse.self, from: data)
    }

    public func uploadFile(
        fileName: String,
        mimeType: String,
        data: Data
    ) async throws -> UploadFileResponse {
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
        return try JSONDecoder().decode(UploadFileResponse.self, from: data)
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
