//
//  CustomTabBar.swift
//  LittleDays
//
//  自定义 TabBar 组件
//

import SwiftUI

/// 自定义 TabBar
struct CustomTabBar: View {
    @Binding var selectedTab: Int

    var body: some View {
        VStack(spacing: 0) {
            // 上边缘分隔线
            Rectangle()
                .fill(Color.forestGreen.opacity(0.3))
                .frame(height: 1)

            HStack(spacing: 0) {
                ForEach(AppTab.allCases, id: \.rawValue) { tab in
                    let config = tab.config
                    TabBarButton(
                        title: config.title,
                        icon: config.icon,
                        tag: tab.rawValue,
                        isSelected: selectedTab == tab.rawValue,
                        isEnabled: config.isEnabled,
                        action: {
                            if config.isEnabled {
                                withAnimation(.spring()) {
                                    selectedTab = tab.rawValue
                                }
                            }
                        }
                    )
                }
            }
            .frame(height: 40)
            .background(Color.forestGreen)
        }
        .ignoresSafeArea(edges: .bottom)
    }
}

/// Tab 按钮
struct TabBarButton: View {
    let title: String
    let icon: String
    let tag: Int
    let isSelected: Bool
    let isEnabled: Bool
    let action: () -> Void

    var body: some View {
        Button(action: action) {
            VStack(spacing: 4) {
                Image(systemName: icon)
                    .font(.system(size: 24))
                Text(title)
                    .font(.caption)
            }
            .foregroundColor(buttonColor)
            .opacity(isEnabled ? 1.0 : 0.4)
            .frame(maxWidth: .infinity)
            .padding(.top, 14)
        }
        .disabled(!isEnabled)
    }

    private var buttonColor: Color {
        if isSelected && isEnabled {
            return .sunlightOrange
        } else {
            return .white
        }
    }
}
