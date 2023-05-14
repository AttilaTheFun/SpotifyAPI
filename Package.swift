// swift-tools-version:5.5

import PackageDescription

let package = Package(
    name: "SpotifyAPI",
    platforms: [
        .iOS(.v13), .macOS(.v10_15), .tvOS(.v13), .watchOS(.v6)
    ],
    products: [
        .library(
            name: "SpotifyAPI",
            targets: ["SpotifyWebAPI", "SpotifyExampleContent"]
        ),
    ],
    dependencies: packageDependencies,
    targets: [
        .target(
            name: "SpotifyWebAPI",
            dependencies: [
                .product(name: "RegularExpressions", package: "RegularExpressions"),
                .product(name: "Logging", package: "swift-log"),
                .product(name: "Crypto", package: "swift-crypto"),
                .product(name: "OpenCombine", package: "OpenCombine"),
                .product(name: "OpenCombineDispatch", package: "OpenCombine"),
                .product(name: "OpenCombineFoundation", package: "OpenCombine")
            ],
            exclude: ["README.md"]
        ),
        .target(
            name: "SpotifyExampleContent",
            dependencies: ["SpotifyWebAPI"],
            exclude: ["README.md"],
            resources: [
                .process("Resources")
            ]
        ),
    ]
)

var packageDependencies: [Package.Dependency] {
    
    var dependencies: [Package.Dependency] = [
        .package(
            name: "RegularExpressions",
            url: "https://github.com/Peter-Schorn/RegularExpressions.git",
            from: "2.2.0"
        ),
        .package(
            name: "swift-log",
            url: "https://github.com/apple/swift-log.git",
            from: "1.4.0"
        ),
        .package(
            name: "OpenCombine",
            url: "https://github.com/AttilaTheFun/OpenCombine.git",
            from: "0.12.1"
        ),
        .package(
            name: "swift-crypto",
            url: "https://github.com/apple/swift-crypto.git",
            from: "1.1.3"
        ),
        .package(
            url: "https://github.com/apple/swift-docc-plugin",
            from: "1.0.0"
        )
    ]

    return dependencies
}
