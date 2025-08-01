// swift-tools-version:5.3
import PackageDescription

let package = Package(
    name: "Colibri",
    platforms: [.iOS(.v13)],
    products: [
        .library(name: "Colibri", targets: ["Colibri"])
    ],
    targets: [
        .binaryTarget(
            name: "c4_swift",
            path: "c4_swift.xcframework"
        ),
        .target(
            name: "CColibriMacOS",
            dependencies: ["c4_swift"],
            path: "Sources/CColibri",
            sources: ["swift_storage_bridge.c"],
            publicHeadersPath: "include",
            cSettings: [
                .headerSearchPath("include")
            ]
        ),
        .target(
            name: "Colibri",
            dependencies: ["c4_swift", "CColibriMacOS"],
            path: "Sources/Colibri",
            sources: ["Colibri.swift"],
            linkerSettings: [
                .linkedLibrary("c++")
            ]
        ),
        .testTarget(
            name: "ColibriTests",
            dependencies: ["Colibri"],
            path: "Tests"
        )
    ]
)
