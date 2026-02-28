//
//  AppConfigModels.swift
//  LittleDays
//
//  应用配置和 Tab 数据模型
//

import SwiftUI

// MARK: - AppTab

/// App Tab 定义
enum AppTab: Int, CaseIterable {
    case wardrobe = 0
    case gardening = 1
    case diary = 2

    /// Tab 配置
    var config: TabConfig {
        switch self {
        case .wardrobe:
            return TabConfig(id: 0, title: "衣橱", icon: "tshirt.fill", isEnabled: true)
        case .gardening:
            return TabConfig(id: 1, title: "花园", icon: "leaf.fill", isEnabled: false)
        case .diary:
            return TabConfig(id: 2, title: "手账", icon: "book.fill", isEnabled: false)
        }
    }
}

/// Tab 配置
struct TabConfig: Identifiable {
    let id: Int
    let title: String
    let icon: String
    let isEnabled: Bool
}

// MARK: - AppConfig

/// 主题类型
enum AppTheme: String, CaseIterable, Codable {
    case followSystem = "跟随系统"
    case light = "浅色模式"
    case dark = "深色模式"
}

/// App 配置
struct AppConfig: Codable {
    var theme: AppTheme
    var aiProviderString: String  // 使用字符串存储
    var enableAutoIdentify: Bool

    /// 转换为 AIProvider
    func toAIProvider() -> AIProvider {
        return aiProviderString == "本地 AI" ? .local : .cloud
    }

    /// 从 AIProvider 转换
    mutating func setAIProvider(_ provider: AIProvider) {
        aiProviderString = provider == .local ? "本地 AI" : "云端 AI"
    }

    static let `default` = AppConfig(
        theme: .followSystem,
        aiProviderString: "本地 AI",
        enableAutoIdentify: true
    )
}

// MARK: - AppConfigService

/// App 配置服务
class AppConfigService {
    private let userDefaults = UserDefaults.standard
    private let configKey = "appConfig"

    /// 保存配置
    func saveConfig(_ config: AppConfig) {
        if let data = try? JSONEncoder().encode(config) {
            userDefaults.set(data, forKey: configKey)
        }
    }

    /// 加载配置
    func loadConfig() -> AppConfig {
        guard let data = userDefaults.data(forKey: configKey),
              let config = try? JSONDecoder().decode(AppConfig.self, from: data) else {
            return AppConfig.default
        }
        return config
    }

    /// 重置为默认配置
    func resetToDefault() {
        saveConfig(AppConfig.default)
    }
}
