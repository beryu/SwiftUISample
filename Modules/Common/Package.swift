// swift-tools-version: 5.8
// The swift-tools-version declares the minimum version of Swift required to build this package.

import PackageDescription

let package = Package(
  name: "Common",
  defaultLocalization: "en",
  platforms: [
    .iOS(.v15),
  ],
  products: [
    .library(name: "Constants", targets: ["Constants"]),
    .library(name: "SharedExtension", targets: ["SharedExtension"]),
    .library(name: "SharedResource", targets: ["SharedResource"]),
  ],
  dependencies: [
    .package(url: "https://github.com/SwiftGen/SwiftGenPlugin", from: "6.6.2"),
  ],
  targets: [
    .target(
      name: "Constants"
    ),
    .target(
      name: "SharedExtension",
      dependencies: [
        "SharedResource"
      ]
    ),
    .target(
      name: "SharedResource",
      plugins: [
        .plugin(name: "SwiftGenPlugin", package: "SwiftGenPlugin"),
      ]
    ),
  ]
)
