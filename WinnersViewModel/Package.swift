// swift-tools-version: 5.9
// The swift-tools-version declares the minimum version of Swift required to build this package.

import PackageDescription

let package = Package(
    name: "WinnersViewModel",
    platforms: [
        .iOS(.v15)
    ],
    products: [
        // Products define the executables and libraries a package produces, making them visible to other packages.
        .library(
            name: "WinnersViewModel",
            targets: ["WinnersViewModel"]),
    ],
    dependencies: [
        .package(path: "../WinnersModel"),
        .package(url: "https://github.com/stephencelis/SQLite.swift.git", from: "0.15.3")
    ],
    targets: [
        // Targets are the basic building blocks of a package, defining a module or a test suite.
        // Targets can depend on other targets in this package and products from dependencies.
        .target(
            name: "WinnersViewModel",
            dependencies: ["WinnersModel",
                           .product(name: "SQLite",
                                    package: "SQLite.swift")]),
        .testTarget(
            name: "WinnersViewModelTests",
            dependencies: ["WinnersViewModel"]
        ),
    ]
)
