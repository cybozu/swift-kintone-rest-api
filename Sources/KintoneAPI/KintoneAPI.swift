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
    ) async throws -> FormLayout {
        let queryItems = [URLQueryItem(name: "app", value: appID.description)]
        let request = makeRequest(httpMethod: .get, endpoint: .formLayout, queryItems: queryItems)
        let (data, response) = try await dataRequestHandler(request)
        try check(response: response)
        let fetchFormLayoutResponse = try JSONDecoder().decode(FetchFormLayoutResponse.self, from: data)
        return fetchFormLayoutResponse.formLayout
    }

    public func fetchFields(
        appID: Int,
        language: Language = .default
    ) async throws -> Fields {
        let queryItems = [
            URLQueryItem(name: "app", value: appID.description),
            URLQueryItem(name: "lang", value: language.rawValue),
        ]
        let request = makeRequest(httpMethod: .get, endpoint: .fields, queryItems: queryItems)
        let (data, response) = try await dataRequestHandler(request)
        try check(response: response)
        let fetchFieldsResponse = try JSONDecoder().decode(FetchFieldsResponse.self, from: data)
        return fetchFieldsResponse.fields
    }

    public func fetchAppSettings(
        appID: Int,
        language: Language = .default
    ) async throws -> AppSettings {
        let queryItems = [
            URLQueryItem(name: "app", value: appID.description),
            URLQueryItem(name: "lang", value: language.rawValue),
        ]
        let request = makeRequest(httpMethod: .get, endpoint: .appSettings, queryItems: queryItems)
        let (data, response) = try await dataRequestHandler(request)
        try check(response: response)
        let fetchAppSettingsResponse = try JSONDecoder().decode(FetchAppSettingsResponse.self, from: data)
        return fetchAppSettingsResponse.appSettings
    }

    public func fetchAppStatusSettings(
        appID: Int,
        language: Language = .default
    ) async throws -> AppStatusSettings {
        let queryItems = [
            URLQueryItem(name: "app", value: appID.description),
            URLQueryItem(name: "lang", value: language.rawValue),
        ]
        let request = makeRequest(httpMethod: .get, endpoint: .appStatus, queryItems: queryItems)
        let (data, response) = try await dataRequestHandler(request)
        try check(response: response)
        let fetchAppStatusResponse = try JSONDecoder().decode(FetchAppStatusResponse.self, from: data)
        return fetchAppStatusResponse.appStatusSettings
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
    ) async throws -> RecordComments {
        var queryItems = [URLQueryItem]()
        queryItems.appendQueryItem(name: "app", value: appID.description)
        queryItems.appendQueryItem(name: "record", value: recordID.description)
        queryItems.appendQueryItem(name: "order", value: order?.rawValue)
        queryItems.appendQueryItem(name: "offset", value: offset?.description)
        queryItems.appendQueryItem(name: "limit", value: limit?.description)
        let request = makeRequest(httpMethod: .get, endpoint: .recordComments, queryItems: queryItems)
        let (data, response) = try await dataRequestHandler(request)
        try check(response: response)
        let fetchRecordCommentsResponse = try JSONDecoder().decode(FetchRecordCommentsResponse.self, from: data)
        return fetchRecordCommentsResponse.recordComments
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
