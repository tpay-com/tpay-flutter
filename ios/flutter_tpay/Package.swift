// swift-tools-version: 5.9
// The swift-tools-version declares the minimum version of Swift required to build this package.

import PackageDescription

let package = Package(
    name: "flutter_tpay",
    platforms: [
        .iOS("13.0")
    ],
    products: [
        .library(name: "flutter-tpay", targets: ["flutter_tpay"])
    ],
    dependencies: [
        .package(url: "https://github.com/tpay-com/tpay-ios.git", exact: "1.4.3")
    ],
    targets: [
        .target(
            name: "flutter_tpay",
            dependencies: [
                .product(name: "Tpay", package: "tpay-ios")
            ]
        )
    ]
)
