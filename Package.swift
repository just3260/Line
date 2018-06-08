// swift-tools-version:4.0
import PackageDescription

let package = Package(
    name: "Line",
    dependencies: [
        .package(url: "https://github.com/vapor/vapor.git", from: "2.4.0"),
        .package(url: "https://github.com/vapor-community/mysql-provider", from: "2.0.0"),
        .package(url: "https://github.com/happiness9721/line-bot-sdk-swift.git", .upToNextMajor(from: "2.0.2")),
        .package(url: "https://github.com/BrettRToomey/Jobs.git", from: "1.1.2")
    ],
    targets: [
        .target(name: "App", dependencies: ["Vapor", "MySQLProvider", "LineBot", "Jobs"]),
        .target(name: "Run", dependencies: ["App"]),
        .testTarget(name: "AppTests", dependencies: ["App"])
    ]
)
