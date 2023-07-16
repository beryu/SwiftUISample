// swift-tools-version: 5.8
// The swift-tools-version declares the minimum version of Swift required to build this package.

import PackageDescription

let package = Package(
  name: "Network",
  platforms: [
    .iOS(.v15),
  ],
  products: [
    .library(
      name: "API",
      targets: ["API"]),
  ],
  dependencies: [
    .package(path: "../Common"),
  ],
  targets: [
    .target(
      name: "API",
      dependencies: [
        .product(name: "Constants", package: "Common"),
      ]),
    .testTarget(
      name: "APITests",
      dependencies: ["API"]),
  ]
)
