// swift-tools-version: 5.8
// The swift-tools-version declares the minimum version of Swift required to build this package.

import PackageDescription

let package = Package(
  name: "Repository",
  platforms: [
    .iOS(.v15),
  ],
  products: [
    .library(name: "Entities", targets: ["Entities"]),
    .library(name: "RepoRepository", targets: ["RepoRepository"]),
    .library(name: "UserRepository", targets: ["UserRepository"]),
  ],
  dependencies: [
    .package(url: "https://github.com/pointfreeco/swift-dependencies", from: "0.5.1"),
    .package(path: "../Network"),
  ],
  targets: [
    .target(
      name: "Entities"
    ),
    .target(
      name: "RepoRepository",
      dependencies: [
        .product(name: "API", package: "Network"),
        "Entities",
        .product(name: "Dependencies", package: "swift-dependencies"),
      ]
    ),
    .target(
      name: "UserRepository",
      dependencies: [
        .product(name: "API", package: "Network"),
        "Entities",
        .product(name: "Dependencies", package: "swift-dependencies"),
      ]
    ),
    .testTarget(
      name: "RepoRepositoryTests",
      dependencies: ["RepoRepository"]
    ),
    .testTarget(
      name: "UserRepositoryTests",
      dependencies: ["UserRepository"]
    ),
  ]
)
