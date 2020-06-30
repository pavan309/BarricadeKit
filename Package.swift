// swift-tools-version:5.2
// The swift-tools-version declares the minimum version of Swift required to build this package.

import PackageDescription

let package = Package(
    name: "BarricadeKit",
    platforms: [.iOS(.v10)],
    products: [
        .library(
            name: "BarricadeKit",
            targets: ["BarricadeKit"]),
    ],
    targets: [
        .target(
            name: "BarricadeKit",
            path: "Core"),
        .testTarget(
            name: "BarricadeKitTests",
            dependencies: ["BarricadeKit"],
            path: "Core"),
    ],
    swiftLanguageVersions: [.v5]
)
