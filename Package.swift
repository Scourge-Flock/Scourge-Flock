// swift-tools-version: 6.2
// The swift-tools-version declares the minimum version of Swift required to build this package.

import CompilerPluginSupport
import PackageDescription

let package = Package(
    name: "ScourgeFlock",
    platforms: [
        .macOS(.v26)
    ],
    products: [
        // Products define the executables and libraries a package produces, making them visible to other packages.
        .library(
            name: "ScourgeFlock",
            targets: ["ScourgeFlock"]
        ),
        .library(
            name: "ScourgeService",
            targets: ["ScourgeService"]
        ),
    ],
    dependencies: [
        .package(url: "https://github.com/swiftlang/swift-syntax.git", from: "602.0.0")
    ],
    targets: [
        .macro(
            name: "ScourgeServiceMacro",
            dependencies: [
                .product(name: "SwiftSyntax", package: "swift-syntax"),
                .product(name: "SwiftSyntaxMacros", package: "swift-syntax"),
                .product(name: "SwiftCompilerPlugin", package: "swift-syntax"),
            ]
        ),
        // Targets are the basic building blocks of a package, defining a module or a test suite.
        // Targets can depend on other targets in this package and products from dependencies.
        .target(
            name: "ScourgeFlock",
            dependencies: ["ScourgeService"]
        ),
        .target(
            name: "ScourgeService",
            dependencies: [
                .target(name: "ScourgeServiceMacro")
            ]
        ),
        .testTarget(
            name: "ScourgeFlockTests",
            dependencies: ["ScourgeFlock", "ScourgeService", "ScourgeServiceMacro"]
        ),
    ]
)
