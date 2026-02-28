//
//  MainTabView.swift
//  LittleDays
//
//  主 Tab 视图（自定义导航栏 + 设置面板）
//

import SwiftUI

struct MainTabView: View {
    @State private var selectedTab = 0
    @State private var isSettingsVisible = false
    @Namespace private var animation

    var body: some View {
        GeometryReader { geometry in
            ZStack(alignment: .leading) {
                // 主内容 + TabBar
                VStack(spacing: 0) {
                    // 导航栏（带渐变背景）
                    NavigationView {
                        tabContent
                            .navigationBarTitleDisplayMode(.inline)
                            .toolbar {
                                ToolbarItem(placement: .principal) {
                                    HStack(spacing: 8) {
                                        Image(systemName: "sun.max.fill")
                                            .foregroundColor(.sunlightOrange)
                                        Text("LittleDays")
                                            .font(.headline)
                                            .foregroundColor(.forestGreen)
                                    }
                                }
                                ToolbarItem(placement: .navigationBarLeading) {
                                    Button(action: {
                                        withAnimation(.easeInOut(duration: 0.5)) {
                                            isSettingsVisible.toggle()
                                        }
                                    }) {
                                        Image(systemName: "sidebar.left")
                                            .foregroundColor(.forestGreen)
                                    }
                                }
                            }
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
                            .ignoresSafeArea(edges: .top)
                    }

                    Spacer()

                    // 自定义 TabBar
                    CustomTabBar(selectedTab: $selectedTab)
                }
                .frame(maxWidth: .infinity, maxHeight: .infinity)
                .background(Color.morningLight)

                // 遮罩层（设置面板展开时显示）
                Color.black.opacity(isSettingsVisible ? 0.3 : 0)
                    .ignoresSafeArea()
                    .onTapGesture {
                        withAnimation(.easeInOut(duration: 0.5)) {
                            isSettingsVisible = false
                        }
                    }

                // 设置面板（覆盖在主内容上）
                HStack(spacing: 0) {
                    SettingsPanel(isVisible: $isSettingsVisible)
                        .frame(width: geometry.size.width * 0.45)
                }
                .frame(width: geometry.size.width * 0.45)
                .offset(x: isSettingsVisible ? 0 : -geometry.size.width * 0.45)
                .animation(.easeInOut(duration: 0.5), value: isSettingsVisible)
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
