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
    .library(name: "UserDetail", targets: ["UserDetail"]),
    .library(name: "UserList", targets: ["UserList"]),
    .library(name: "SearchUser", targets: ["SearchUser"]),
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
        .product(name: "SharedResource", package: "Common"),
      ]
    ),
    .target(
      name: "Root",
      dependencies: [
        "SearchUser",
        "UserList",
      ]
    ),
    .target(
      name: "UserDetail",
      dependencies: [
        "Components",
        .product(name: "SharedExtension", package: "Common"),
        .product(name: "SharedResource", package: "Common"),
        .product(name: "Entities", package: "Repository"),
        .product(name: "RepoRepository", package: "Repository"),
        .product(name: "UserRepository", package: "Repository"),
        .product(name: "Dependencies", package: "swift-dependencies"),
      ]
    ),
    .target(
      name: "UserList",
      dependencies: [
        "Components",
        "UserDetail",
        .product(name: "SharedExtension", package: "Common"),
        .product(name: "SharedResource", package: "Common"),
        .product(name: "Entities", package: "Repository"),
        .product(name: "UserRepository", package: "Repository"),
        .product(name: "Dependencies", package: "swift-dependencies"),
      ]
    ),
    .target(
      name: "SearchUser",
      dependencies: [
        "Components",
        "UserDetail",
        .product(name: "SharedExtension", package: "Common"),
        .product(name: "SharedResource", package: "Common"),
        .product(name: "Entities", package: "Repository"),
        .product(name: "UserRepository", package: "Repository"),
        .product(name: "Dependencies", package: "swift-dependencies"),
      ]
    ),
    .testTarget(
      name: "SearchUserTests",
      dependencies: [
        "SearchUser",
        .product(name: "Dependencies", package: "swift-dependencies"),
      ]
    ),
    .testTarget(
      name: "UserDetailTests",
      dependencies: [
        "UserDetail",
        .product(name: "Dependencies", package: "swift-dependencies"),
      ]
    ),
    .testTarget(
      name: "UserListTests",
      dependencies: [
        "UserList",
        .product(name: "Dependencies", package: "swift-dependencies"),
      ]
    ),
  ]
)
