// swift-tools-version: 5.6
// The swift-tools-version declares the minimum version of Swift required to build this package.

import PackageDescription

let package = Package(
    name: "bklocalrepositorycore",
    defaultLocalization: "en",
    platforms: [
        .iOS(.v13)
    ],
    products: [
        .library(
            name: "bklocalrepositorycore",
            targets: [
                "bklocalrepositorycore"
            ]
        ),
    ],
    dependencies: [
        .package(
            url: "https://github.com/XbikeJavierBC/ghvultangcore.git",
            branch: "main"
        ),
        .package(
            url: "https://github.com/XbikeJavierBC/bkdomauncore.git",
            branch: "main"
        )
    ],
    targets: [
        .target(
            name: "bklocalrepositorycore",
            dependencies: [
                "ghvultangcore",
                "bkdomauncore"
            ]
        ),
        .testTarget(
            name: "bklocalrepositorycoreTests",
            dependencies: [
                "bklocalrepositorycore"
            ]
        ),
    ]
)
