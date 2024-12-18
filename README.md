# kintone REST API with Swift

Providing kintone REST API with Swift interface.

## Requirements

- Development with Xcode 15.4+
- Written in Swift 5.10
- Compatible with iOS 17+, macOS 14+

## Supported API

- `fetchApps` ([GET - /k/v1/apps.json](https://cybozu.dev/ja/kintone/docs/rest-api/apps/get-apps/))
- `fetchFormLayout` ([GET - /k/v1/app/form/layout.json](https://cybozu.dev/ja/kintone/docs/rest-api/apps/form/get-form-layout/))
- `fetchFormFields` ([GET - /k/v1/app/form/fields.json](https://cybozu.dev/ja/kintone/docs/rest-api/apps/form/get-form-fields/))
- `submitRecord` ([POST - /k/v1/record.json](https://cybozu.dev/ja/kintone/docs/rest-api/records/add-record/))

## Privacy Manifest

This library does not collect or track user information, so it does not include a PrivacyInfo.xcprivacy file.
