// swift-tools-version:4.0
// The swift-tools-version declares the minimum version of Swift required to build this package.

import PackageDescription

let package = Package(
    name: "AbsenceSwift",
    products: [
        .library(name: "AbsenceSwift", targets: ["AbsenceSwift"]),
    ],
    dependencies: [
        .package(url: "https://github.com/cpageler93/Quack", from: "1.5.0"),
        .package(url: "https://github.com/cpageler93/SwiftyHawk", from: "0.1.2"),
    ],
    targets: [
        .target(name: "AbsenceSwift", dependencies: ["Quack", "SwiftyHawk"]),
        .testTarget(name: "AbsenceSwiftTests", dependencies: ["AbsenceSwift"]),
    ]
)
