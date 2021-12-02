// swift-tools-version:5.5

import PackageDescription

let package = Package(
    name: "SimpleFDB",
    platforms: [.macOS(.v12)],
    dependencies: [
        .package(url: "https://github.com/kirilltitov/FDBSwift.git", .upToNextMajor(from: "5.0.0-RC-3")),
    ],
    targets: [
        .executableTarget(
            name: "SimpleFDB",
            dependencies: [
                .product(name: "FDB", package: "FDBSwift"),
            ]
        ),
        .testTarget(
            name: "SimpleFDBTests",
            dependencies: ["SimpleFDB"]
        ),
    ]
)
