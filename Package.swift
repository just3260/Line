// swift-tools-version:4.0
import PackageDescription

let package = Package(
    name: "Line",
    dependencies: [
        .package(url: "https://github.com/vapor/vapor.git", from: "2.4.0"),
        .package(url: "https://github.com/vapor/fluent.git", .upToNextMajor(from: "2.4.0")),
        .package(url: "https://github.com/happiness9721/line-bot-sdk-swift.git", .upToNextMajor(from: "2.0.0"))
    ],
    targets: [
        .target(name: "App", dependencies: ["Vapor", "Fluent", "LineBot"]),
        .target(name: "Run", dependencies: ["App"]),
        .testTarget(name: "AppTests", dependencies: ["App"])
    ]
)
