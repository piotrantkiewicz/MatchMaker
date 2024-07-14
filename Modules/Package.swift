// swift-tools-version: 5.10
import PackageDescription

let package = Package(
    name: "Modules",
    products: [
        .library(
            name: "MatchMakerLogin",
            targets: ["MatchMakerLogin"]),
    ],
    dependencies: [
        .package(url: "https://github.com/marmelroy/PhoneNumberKit", from: "3.7.0"),
        .package(url: "https://github.com/SnapKit/SnapKit.git", .upToNextMajor(from: "5.0.1"))
    ],
    targets: [
        .target(
            name: "MatchMakerLogin",
            dependencies: [
                "SnapKit",
                "PhoneNumberKit"
            ]
        ),
    ]
)
