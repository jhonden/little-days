//
//  SettingsPanel.swift
//  LittleDays
//
//  设置面板组件
//

import SwiftUI

/// 设置面板
struct SettingsPanel: View {
    @Binding var isVisible: Bool
    @State private var selectedAIProvider: AIProvider = .local
    @State private var selectedTheme: AppTheme = .followSystem

    var body: some View {
        VStack(spacing: 0) {
            // 顶部收起按钮
            HStack {
                Button(action: {
                    withAnimation(.spring(response: 0.5, dampingFraction: 0.7)) {
                        isVisible = false
                    }
                }) {
                    Image(systemName: "sidebar.left")
                        .font(.system(size: 20))
                        .foregroundColor(.white)
                }
                Spacer()
            }
            .padding()

            Divider()
                .background(Color.white.opacity(0.2))

            ScrollView {
                VStack(spacing: 24) {
                    SettingsGroup(title: "🤖 AI 服务") {
                        SettingsRow(
                            title: "本地 AI",
                            isSelected: selectedAIProvider == .local,
                            action: { selectedAIProvider = .local }
                        )
                        SettingsRow(
                            title: "云端 AI",
                            isSelected: selectedAIProvider == .cloud,
                            action: { selectedAIProvider = .cloud }
                        )
                    }

                    SettingsGroup(title: "💾 数据管理") {
                        SettingsRow(title: "清理缓存", isArrow: true) {
                            // TODO: 实现清理缓存功能
                        }
                        SettingsRow(title: "导出数据", isArrow: true) {
                            // TODO: 实现导出数据功能
                        }
                        SettingsRow(title: "导入数据", isArrow: true) {
                            // TODO: 实现导入数据功能
                        }
                    }

                    SettingsGroup(title: "🎨 主题设置") {
                        SettingsRow(
                            title: "跟随系统",
                            isSelected: selectedTheme == .followSystem,
                            action: { selectedTheme = .followSystem }
                        )
                        SettingsRow(
                            title: "浅色模式",
                            isSelected: selectedTheme == .light,
                            action: { selectedTheme = .light }
                        )
                        SettingsRow(
                            title: "深色模式",
                            isSelected: selectedTheme == .dark,
                            action: { selectedTheme = .dark }
                        )
                    }

                    SettingsGroup(title: "ℹ️ 关于") {
                        SettingsRow(title: "版本 1.0.0")
                        SettingsRow(title: "项目地址", isArrow: true) {
                            // TODO: 打开项目地址
                        }
                    }
                }
                .padding()
            }

            Spacer()
        }
        .frame(maxWidth: .infinity, maxHeight: .infinity)
        .background(Color.forestGreen.opacity(0.95))
        .foregroundColor(.white)
    }
}

/// 设置分组
struct SettingsGroup<Content: View>: View {
    let title: String
    @ViewBuilder let content: Content

    var body: some View {
        VStack(alignment: .leading, spacing: 8) {
            Text(title)
                .font(.caption)
                .foregroundColor(.white.opacity(0.8))

            VStack(spacing: 0) {
                content
            }
            .background(Color.white.opacity(0.1))
            .cornerRadius(8)
        }
    }
}

/// 设置行
struct SettingsRow: View {
    let title: String
    var isSelected: Bool = false
    var isArrow: Bool = false
    var action: (() -> Void)? = nil

    var body: some View {
        Button(action: {
            action?()
        }) {
            HStack {
                Text(title)
                    .font(.body)

                Spacer()

                if isSelected {
                    Image(systemName: "checkmark")
                        .foregroundColor(.sunlightOrange)
                }

                if isArrow {
                    Image(systemName: "chevron.right")
                        .font(.system(size: 14))
                        .foregroundColor(.white.opacity(0.6))
                }
            }
            .padding(.horizontal, 12)
            .padding(.vertical, 10)
        }
        .buttonStyle(PlainButtonStyle())
    }
}
