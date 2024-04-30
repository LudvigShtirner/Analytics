// swift-tools-version: 5.7
// The swift-tools-version declares the minimum version of Swift required to build this package.

import PackageDescription

private let analytics = "Analytics"
private let analyticsTests = "AnalyticsTests"

let package = Package(
    name: analytics,
    platforms: [.iOS(.v15)],
    products: [
        .library(name: analytics, targets: [analytics]),
    ],
    dependencies: [
        
    ],
    targets: [
        .target(name: analytics,
                dependencies: []),
        .testTarget(name: analyticsTests,
                    dependencies: [
                        .byName(name: analytics)
                    ]),
    ]
)
