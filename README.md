# swift-kintone-rest-api

Providing kintone REST API with Swift interface.

## Requirements

- Development with Xcode 16.0+
- Written in Swift 6.0
- Compatible with iOS 17+, macOS 14+

## Supported API

- `fetchApps` (GET - [/k/v1/apps.json](https://kintone.dev/en/docs/kintone/rest-api/apps/get-apps/))
- `fetchFormLayout` (GET - [/k/v1/app/form/layout.json](https://kintone.dev/en/docs/kintone/rest-api/apps/get-form-layout/))
- `fetchFormFields` (GET - [/k/v1/app/form/fields.json](https://kintone.dev/en/docs/kintone/rest-api/apps/get-form-fields/))
- `fetchRecords` (GET - [/k/v1/record.json](https://kintone.dev/en/docs/kintone/rest-api/records/get-records/))
- `removeRecords` (DELETE - [/k/v1/record.json](https://kintone.dev/en/docs/kintone/rest-api/records/delete-records/)) 
- `submitRecord` (POST - [/k/v1/record.json](https://kintone.dev/en/docs/kintone/rest-api/records/add-record/))
- `updateRecord` (PUT - [/k/v1/record.json](https://kintone.dev/en/docs/kintone/rest-api/records/update-record/))
- `downloadFile` (GET - [/k/v1/file.json](https://kintone.dev/en/docs/kintone/rest-api/files/download-file/))
- `uploadFile` (POST - [/k/v1/file.json](https://kintone.dev/en/docs/kintone/rest-api/files/upload-file/))

## Supported Authentication Method

- Cybozu Authorization (`X-Cybozu-Authorization`)
- Cybozu API Token (`X-Cybozu-API-Token`)
- Cybozu Session (`X-Requested-With`)

## Usage

```swift
func fetchAllApps() async throws {
    let credentials = Credentials(loginName: "user", password: "*****")
    let kintoneAPI = KintoneAPI(
        authenticationMethod: .cybozuAuthorization(credentials),
        dataRequestHandler: { request in
            guard let url = request.url else { throw URLError(.badURL) }
            var request = request
            request.url = URL(string: "https://subdomain.cybozu.com\(url.relativeString)")
            return try await URLSession.shared.data(for: request)
        }
    )
    let apps = try await kintoneAPI.fetchApps()
}

func submitRecord() async throws {
    let credentials = Credentials(loginName: "user", password: "*****")
    let kintoneAPI = KintoneAPI(
        authenticationMethod: .cybozuAuthorization(credentials),
        dataRequestHandler: { request in
            guard let url = request.url else { throw URLError(.badURL) }
            var request = request
            request.url = URL(string: "https://subdomain.cybozu.com\(url.relativeString)")
            return try await URLSession.shared.data(for: request)
        }
    )
    let fields: [RecordField.Write] = [
        RecordField.Write(code: "User Number", value: .number("12345")),
        RecordField.Write(code: "Comment", value: .singleLineText("Hello World!")),
        RecordField.Write(code: "Favorites", value: .checkBox(["Apple", "Banana"])),
    ]
    let record = Record.Write(fields: fields)
    try await kintoneAPI.submitRecord(appID: 1, record: record)
}
```

## Privacy Manifest

This library does not collect or track user information, so it does not include a PrivacyInfo.xcprivacy file.

## Demo

This repository includes demonstration app for iOS.

Open [Example/Example.xcodeproj](/Example/Example.xcodeproj) and Run it.
