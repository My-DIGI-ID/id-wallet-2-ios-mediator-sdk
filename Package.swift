// swift-tools-version:5.5
// The swift-tools-version declares the minimum version of Swift required to build this package.

import PackageDescription

let package = Package(
    name: "Mediator",
    platforms: [.iOS(.v14)],
    products: [
        // Products define the executables and libraries a package produces, and make them visible to other packages.
        .library(
            name: "Mediator",
            targets: ["Mediator"]
        )
    ],
    dependencies: [
        .package(url: "https://github.com/square/Valet", from: "4.1.2"),
//        .package(name: "Aries", path: "../ios-aries-sdk"),
        .package(url: "https://eu-de.git.cloud.ibm.com/blockchain-practice-dach/projects/ssi-bundeskanzleramt/id-wallet/ios-aries-sdk",
                 .exact("0.1.0"))
        // Dependencies declare other packages that this package depends on.
        // .package(url: /* package url */, from: "1.0.0"),
    ],
    targets: [
        // Targets are the basic building blocks of a package. A target can define a module or a test suite.
        // Targets can depend on other targets in this package, and on products in packages this package depends on.
        .target(
            name: "Mediator",
            dependencies: ["Valet",
                           .product(name: "Aries", package: "ios-aries-sdk")]
        ),
        .testTarget(
            name: "MediatorTests",
            dependencies: ["Mediator"],
            resources: [.copy("Resource")]
        )
    ]
)
