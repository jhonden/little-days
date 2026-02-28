//
//  ColorExtension.swift
//  LittleDays
//
//  阳光森林色系
//

import SwiftUI

extension Color {
    // 阳光森林色系

    /// 森林绿（树叶绿）
    static let forestGreen = Color(hex: "#4CAF50")

    /// 浅苔绿（阳光照在叶子上）
    static let lightMoss = Color(hex: "#81C784")

    /// 晨光绿（背景色）
    static let morningLight = Color(hex: "#A5D6A7")

    /// 阳光橙（强调色）
    static let sunlightOrange = Color(hex: "#FF9800")

    /// 暖黄色（光斑）
    static let warmYellow = Color(hex: "#FFB74D")

    /// 柔和黄（浅色背景，渐变色）
    static let softYellow = Color(hex: "#FFF3E0")

    /// 森林褐（树干色）
    static let forestBrown = Color(hex: "#8D6E63")

    /// 柔和灰（文字色）
    static let softGray = Color(hex: "#9E9E9E")
}

extension Color {
    /// 从十六进制颜色字符串创建 Color
    /// - Parameter hex: 十六进制颜色字符串，例如 "#FF9800"
    init(hex: String) {
        let hex = hex.trimmingCharacters(in: CharacterSet.alphanumerics.inverted)
        var int: UInt64 = 0
        Scanner(string: hex).scanHexInt64(&int)
        let a, r, g, b: UInt64
        switch hex.count {
        case 3:
            (a, r, g, b) = (255, (int >> 8) * 17, (int >> 4 & 0xF) * 17, (int & 0xF) * 17)
        case 6:
            (a, r, g, b) = (255, int >> 16, int >> 8 & 0xFF, int & 0xFF)
        case 8:
            (a, r, g, b) = (int >> 24, int >> 16 & 0xFF, int >> 8 & 0xFF, int & 0xFF)
        default:
            (a, r, g, b) = (1, 1, 1, 0)
        }

        self.init(
            .sRGB,
            red: Double(r) / 255,
            green: Double(g) / 255,
            blue: Double(b) / 255,
            opacity: Double(a) / 255
        )
    }
}
