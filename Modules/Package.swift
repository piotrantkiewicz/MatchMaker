// swift-tools-version: 5.10
import PackageDescription

let package = Package(
    name: "Modules",
    platforms: [.iOS(.v17)],
    products: [
        .library(name: "DesignSystem", targets: ["DesignSystem"]),
        .library(
            name: "MatchMakerAuth",
            targets: ["MatchMakerAuth"]),
        .library(
            name: "MatchMakerCore",
            targets: ["MatchMakerCore"]),
        .library(
            name: "MatchMakerDiscovery",
            targets: ["MatchMakerDiscovery"]),
        .library(
            name: "MatchMakerLogin",
            targets: ["MatchMakerLogin"]),
        .library(
            name: "MatchMakerSettings",
            targets: ["MatchMakerSettings"]),
    ],
    dependencies: [
        .package(url: "https://github.com/firebase/firebase-ios-sdk.git", from: "10.29.0"),
        .package(url: "https://github.com/marmelroy/PhoneNumberKit", from: "3.7.0"),
        .package(url: "https://github.com/SnapKit/SnapKit.git", .upToNextMajor(from: "5.0.1")),
        .package(url: "https://github.com/SDWebImage/SDWebImage.git", from: "5.1.0"),
        .package(url: "https://github.com/Swinject/Swinject.git", from: "2.9.1"),
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
        .target(name: "MatchMakerCore"),
        .target(
            name: "MatchMakerDiscovery",
            dependencies: [
                "DesignSystem",
                "MatchMakerAuth",
                "MatchMakerCore",
                "SDWebImage",
                "SnapKit",
                "Swinject",
                .product(name: "FirebaseAuth", package: "firebase-ios-sdk"),
                .product(name: "FirebaseDatabase", package: "firebase-ios-sdk"),
            ]
        ),
        .target(
            name: "MatchMakerLogin",
            dependencies: [
                "DesignSystem",
                "MatchMakerAuth",
                "MatchMakerCore",
                "PhoneNumberKit",
                "SnapKit",
                "Swinject",
            ],
            resources: [
                .process("Resources")
            ]
        ),
        .target(
            name: "MatchMakerSettings",
            dependencies: [
                "DesignSystem",
                "MatchMakerAuth",
                "MatchMakerCore",
                "SnapKit",
                "SDWebImage",
                "Swinject",
                .product(name: "FirebaseAuth", package: "firebase-ios-sdk"),
                .product(name: "FirebaseDatabase", package: "firebase-ios-sdk"),
                .product(name: "FirebaseStorage", package: "firebase-ios-sdk"),
            ],
            resources: [
                .process("Resources")
            ]
        )
    ]
)
