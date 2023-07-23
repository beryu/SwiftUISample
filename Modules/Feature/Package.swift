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
    .library(name: "Root", targets: ["Root"]),
  ],
  dependencies: [
    .package(url: "https://github.com/pointfreeco/swift-dependencies", from: "0.5.1"),
    .package(path: "../Common"),
  ],
  targets: [
    .target(
      name: "Root",
      dependencies: []
    ),
//    .testTarget(
//      name: "RootTests",
//      dependencies: ["Root"]
//    ),
  ]
)
