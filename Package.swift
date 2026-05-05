// swift-tools-version: 5.9
import PackageDescription

let package = Package(
    name: "fledge-plugin-flip",
    platforms: [.macOS(.v13)],
    targets: [
        .executableTarget(
            name: "fledge-plugin-flip",
            path: "Sources"
        )
    ]
)
