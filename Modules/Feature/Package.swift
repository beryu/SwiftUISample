// swift-tools-version: 5.8
// The swift-tools-version declares the minimum version of Swift required to build this package.

import PackageDescription

let package = Package(
  name: "Feature",
  defaultLocalization: "en",
  platforms: [
    .iOS(.v15),
  ],
  products: [
    .library(name: "Components", targets: ["Components"]),
    .library(name: "Root", targets: ["Root"]),
    .library(name: "UserList", targets: ["UserList"]),
  ],
  dependencies: [
    .package(url: "https://github.com/pointfreeco/swift-dependencies", from: "0.5.1"),
    .package(path: "../Common"),
    .package(path: "../Repository"),
  ],
  targets: [
    .target(
      name: "Components",
      dependencies: [
        .product(name: "SharedExtension", package: "Common"),
      ]
    ),
    .target(
      name: "Root",
      dependencies: [
        "UserList",
      ]
    ),
    .target(
      name: "UserList",
      dependencies: [
        "Components",
        .product(name: "SharedExtension", package: "Common"),
        .product(name: "SharedResource", package: "Common"),
        .product(name: "Entities", package: "Repository"),
        .product(name: "UserRepository", package: "Repository"),
        .product(name: "Dependencies", package: "swift-dependencies"),
      ]
    ),
//    .testTarget(
//      name: "RootTests",
//      dependencies: ["Root"]
//    ),
  ]
)
