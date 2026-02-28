//
//  MainTabView.swift
//  LittleDays
//
//  主 Tab 视图（自定义导航栏 + 设置面板）
//

import SwiftUI
import UIKit

struct MainTabView: View {
    @State private var selectedTab = 0
    @State private var isSettingsVisible = false
    @Namespace private var animation
    @State private var dragOffset: CGFloat = 0
    @State private var sidebarOffset: CGFloat = 0
    @State private var hasTriggeredHaptic = false

    // 触觉反馈生成器
    private let impactFeedback = UIImpactFeedbackGenerator(style: .medium)

    var body: some View {
        GeometryReader { geometry in
            let sidebarWidth = geometry.size.width * 0.45

            ZStack(alignment: .leading) {
                // 主内容 + TabBar
                VStack(spacing: 0) {
                    // 固定导航栏
                    HStack(spacing: 12) {
                        // 侧边栏按钮
                        Button(action: {
                            withAnimation(.easeOut(duration: 0.25)) {
                                isSettingsVisible.toggle()
                                sidebarOffset = isSettingsVisible ? 0 : -geometry.size.width * 0.45
                            }
                        }) {
                            Image(systemName: "line.3.horizontal")
                                .font(.system(size: 20))
                                .foregroundColor(.forestGreen)
                        }

                        // 标题
                        HStack(spacing: 6) {
                            Image(systemName: "sun.max.fill")
                                .font(.system(size: 18))
                                .foregroundColor(.sunlightOrange)
                            Text("小日子")
                                .font(.headline)
                                .foregroundColor(.forestGreen)
                        }

                        Spacer()
                    }
                    .padding(.horizontal, 16)
                    .padding(.vertical, 12)
                    .background(
                        LinearGradient(
                            gradient: Gradient(colors: [
                                Color.morningLight,
                                Color.softYellow
                            ]),
                            startPoint: .topLeading,
                            endPoint: .bottomTrailing
                        )
                    )

                    // 主内容区域
                    tabContent

                    Spacer()

                    // 自定义 TabBar
                    CustomTabBar(selectedTab: $selectedTab)
                }
                .frame(maxWidth: .infinity, maxHeight: .infinity)
                .background(Color.morningLight)
                .gesture(
                    DragGesture()
                        .onChanged { value in
                            // 侧边栏关闭时，只能从左边缘向右拖拽打开
                            if !isSettingsVisible && value.startLocation.x < 50 && value.translation.width > 0 {
                                dragOffset = min(sidebarWidth, value.translation.width)
                                sidebarOffset = -sidebarWidth + dragOffset

                                // 触发震动反馈（只触发一次）
                                if !hasTriggeredHaptic && dragOffset > 10 {
                                    impactFeedback.impactOccurred()
                                    hasTriggeredHaptic = true
                                }
                            }
                        }
                        .onEnded { value in
                            // 重置震动触发标记
                            hasTriggeredHaptic = false

                            // 侧边栏关闭状态
                            if !isSettingsVisible && value.startLocation.x < 50 {
                                let threshold = geometry.size.width * 0.15
                                if value.translation.width > threshold {
                                    withAnimation(.easeOut(duration: 0.25)) {
                                        isSettingsVisible = true
                                        dragOffset = 0
                                        sidebarOffset = 0
                                    }
                                } else {
                                    withAnimation(.easeOut(duration: 0.25)) {
                                        dragOffset = 0
                                        sidebarOffset = -sidebarWidth
                                    }
                                }
                            }
                        }
                )
                .onChange(of: geometry.size) { _ in
                    // 当屏幕尺寸变化时，重新初始化 sidebarOffset
                    sidebarOffset = isSettingsVisible ? 0 : -sidebarWidth
                }
                .onAppear {
                    // 准备触觉反馈引擎
                    impactFeedback.prepare()
                    // 初始化侧边栏位置（关闭状态）
                    sidebarOffset = -sidebarWidth
                }

                // 遮罩层（设置面板展开时显示）
                Color.black.opacity(sidebarOffset > -sidebarWidth * 0.5 ? min(0.3, (sidebarOffset / sidebarWidth + 1.0) * 0.3) : 0)
                    .ignoresSafeArea()
                    .onTapGesture {
                        withAnimation(.easeOut(duration: 0.25)) {
                            isSettingsVisible = false
                            sidebarOffset = -sidebarWidth
                        }
                    }
                    .gesture(
                        DragGesture()
                            .onChanged { value in
                                // 侧边栏打开时，向左拖拽收起
                                if sidebarOffset >= -sidebarWidth * 0.9 && value.translation.width < 0 {
                                    sidebarOffset = max(-sidebarWidth, value.translation.width)
                                }
                            }
                            .onEnded { value in
                                let threshold = geometry.size.width * 0.15
                                if value.translation.width < -threshold {
                                    withAnimation(.easeOut(duration: 0.25)) {
                                        isSettingsVisible = false
                                        sidebarOffset = -sidebarWidth
                                    }
                                } else {
                                    withAnimation(.easeOut(duration: 0.25)) {
                                        sidebarOffset = 0
                                    }
                                }
                            }
                    )

                // 设置面板（覆盖在主内容上）
                HStack(spacing: 0) {
                    SettingsPanel(isVisible: $isSettingsVisible)
                        .frame(width: sidebarWidth)
                }
                .frame(width: sidebarWidth)
                .offset(x: sidebarOffset)
                .allowsHitTesting(false)
            }
        }
    }

    @ViewBuilder
    private var tabContent: some View {
        switch selectedTab {
        case AppTab.wardrobe.rawValue:
            WardrobeView()
        case AppTab.gardening.rawValue:
            GardeningPlaceholderView()
        case AppTab.diary.rawValue:
            DiaryPlaceholderView()
        default:
            EmptyView()
        }
    }
}

#Preview {
    MainTabView()
}
