// swift-tools-version:5.7

import PackageDescription

let package = Package(
    name: "FiscalSerializationLib_v2",
    platforms: [
        .macOS(.v12),
        .iOS(.v13)
    ],
    products: [
        .library(
            name: "FiscalSerializationLib_v2",
            targets: ["FiscalSerializationLib_v2"]
        )
    ],
    dependencies: [
        .package(url: "https://github.com/apple/swift-protobuf.git", from: "1.28.2")
    ],
    targets: [
        .target(
            name: "FiscalSerializationLib_v2",
            dependencies: [
                .product(name: "SwiftProtobuf", package: "swift-protobuf")
            ],
            path: "Sources"
        ),
        .testTarget(
            name: "FiscalSerializationLib_v2Tests",
            dependencies: ["FiscalSerializationLib_v2"],
            path: "Tests"
        )
    ]
)
