// swift-tools-version: 5.10
import PackageDescription

let package = Package(
    name: "Modules",
    platforms: [.iOS(.v17)],
    products: [
        .library(
            name: "MatchMakerAuth",
            targets: ["MatchMakerAuth"]),
        .library(
            name: "MatchMakerLogin",
            targets: ["MatchMakerLogin"]),
        .library(name: "DesignSystem", targets: ["DesignSystem"])
    ],
    dependencies: [
        .package(url: "https://github.com/firebase/firebase-ios-sdk.git", from: "10.29.0"),
        .package(url: "https://github.com/marmelroy/PhoneNumberKit", from: "3.7.0"),
        .package(url: "https://github.com/SnapKit/SnapKit.git", .upToNextMajor(from: "5.0.1"))
    ],
    targets: [
        .target(name: "DesignSystem"),
        .target(
            name: "MatchMakerAuth",
            dependencies: [
                .product(
                    name: "FirebaseAuth",
                    package: "firebase-ios-sdk"
                )
            ]
        ),
        .target(
            name: "MatchMakerLogin",
            dependencies: [
                "DesignSystem",
                "MatchMakerAuth",
                "PhoneNumberKit",
                "SnapKit"
            ],
            resources: [
                .process("Resources")
            ]
        )
    ]
)
