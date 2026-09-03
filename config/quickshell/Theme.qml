pragma Singleton
import QtQuick

QtObject {
    // Near-black Minimal Palette
    readonly property color bgBase: "#0a0b0e"
    readonly property color bgSurface: "#12151b"
    readonly property color bgSurfaceHover: "#1c202a"
    readonly property color bgSurfaceActive: "#252b38"

    readonly property color borderSubtle: "#1f2430"
    readonly property color borderFocus: "#3b4252"

    readonly property color textPrimary: "#e6edf3"
    readonly property color textSecondary: "#8b949e"
    readonly property color textMuted: "#484f58"

    readonly property color accent: "#58a6ff"
    readonly property color accentDim: "#1f6feb"
    readonly property color danger: "#f85149"
    readonly property color warning: "#d29922"
    readonly property color success: "#3fb950"

    readonly property int radiusSm: 6
    readonly property int radiusMd: 8
    readonly property int radiusLg: 12

    readonly property string fontMono: "JetBrainsMono Nerd Font"
    readonly property string fontSans: "Inter, Noto Sans, sans-serif"
}
