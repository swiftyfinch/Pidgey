// swift-tools-version:5.4

import PackageDescription

let package = Package(
    name: "Pidgey",
    platforms: [.macOS(.v11)],
    products: [
        .executable(name: "pidgey", targets: ["Pidgey"])
    ],
    dependencies: [
        .package(url: "https://github.com/apple/swift-argument-parser", from: "0.4.3"),
        .package(url: "https://github.com/Alamofire/Alamofire", from: "5.4.3"),
        .package(url: "https://github.com/kishikawakatsumi/KeychainAccess", from: "4.2.2"),
        .package(url: "https://github.com/onevcat/Rainbow", from: "4.0.0")
    ],
    targets: [
        .executableTarget(name: "Pidgey", dependencies: [
            .product(name: "ArgumentParser", package: "swift-argument-parser"),
            "Alamofire",
            "KeychainAccess",
            "Rainbow"
        ])
    ]
)
