pragma Singleton
import QtQuick

QtObject {
    // Colors (Near-Black Minimal Palette)
    readonly property color bgBase: "#090a0f"
    readonly property color bgSurface: "#11141c"
    readonly property color bgElevated: "#181d28"
    readonly property color bgHover: "#202736"
    readonly property color bgActive: "#283144"

    readonly property color borderSubtle: "#1c2333"
    readonly property color borderFocus: "#38455e"

    readonly property color textPrimary: "#f0f6fc"
    readonly property color textSecondary: "#8b949e"
    readonly property color textMuted: "#484f58"

    readonly property color accent: "#58a6ff"
    readonly property color accentDim: "#1f3a5f"
    readonly property color success: "#3fb950"
    readonly property color warning: "#d29922"
    readonly property color danger: "#f85149"

    // Spacing & Radii
    readonly property int radiusXs: 4
    readonly property int radiusSm: 6
    readonly property int radiusMd: 10
    readonly property int radiusLg: 14
    readonly property int radiusFull: 999

    readonly property int spaceXs: 4
    readonly property int spaceSm: 8
    readonly property int spaceMd: 12
    readonly property int spaceLg: 16
    readonly property int spaceXl: 24

    // Dimensions
    readonly property int barHeight: 38
    readonly property int panelWidth: 340
    readonly property int launcherWidth: 540
    readonly property int launcherHeight: 400

    // Typography
    readonly property string fontSans: "Inter, Roboto, sans-serif"
    readonly property string fontMono: "JetBrainsMono Nerd Font, monospace"

    // Animation Timings
    readonly property int animFast: 120
    readonly property int animNormal: 180
    readonly property int animSmooth: 240
}
