# swift-kintone-rest-api

Providing kintone REST API with Swift interface.

## Requirements

- Development with Xcode 16.0+
- Written in Swift 6.0
- Compatible with iOS 17+, macOS 14+

## Supported API

- `fetchApps` ([GET - /k/v1/apps.json](https://cybozu.dev/ja/kintone/docs/rest-api/apps/get-apps/))
- `fetchFormLayout` ([GET - /k/v1/app/form/layout.json](https://cybozu.dev/ja/kintone/docs/rest-api/apps/form/get-form-layout/))
- `fetchFormFields` ([GET - /k/v1/app/form/fields.json](https://cybozu.dev/ja/kintone/docs/rest-api/apps/form/get-form-fields/))
- `submitRecord` ([POST - /k/v1/record.json](https://cybozu.dev/ja/kintone/docs/rest-api/records/add-record/))

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
    let fields: [RecordField] = [
        RecordField(code: "Number", value: .number("12345")),
        RecordField(code: "SingleLineText", value: .singleLineText("Hello World!")),
        RecordField(code: "CheckBox", value: .checkBox(["Apple", "Banana"])),
    ]
    try await kintoneAPI.submitRecord(appID: 1, fields: fields)
}
```

## Privacy Manifest

This library does not collect or track user information, so it does not include a PrivacyInfo.xcprivacy file.

## Demo

This repository includes demonstration app for iOS.

Open [Example/Example.xcodeproj](/Example/Example.xcodeproj) and Run it.
