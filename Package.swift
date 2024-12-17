// swift-tools-version: 5.10

import PackageDescription

let swiftSettings: [SwiftSetting] = [
    .enableExperimentalFeature("StrictConcurrency"),
    .enableUpcomingFeature("ExistentialAny"),
    .enableUpcomingFeature("GlobalConcurrency"),
]

let package = Package(
    name: "KintoneAPI",
    platforms: [
        .iOS(.v17),
        .macOS(.v14),
    ],
    products: [
        .library(
            name: "KintoneAPI",
            targets: ["KintoneAPI"]
        ),
    ],
    targets: [
        .target(
            name: "KintoneAPI",
            swiftSettings: swiftSettings
        ),
        .testTarget(
            name: "KintoneAPITests",
            dependencies: ["KintoneAPI"],
            swiftSettings: swiftSettings
        ),
    ]
)
