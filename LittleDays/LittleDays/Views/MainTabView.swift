//
//  MainTabView.swift
//  LittleDays
//
//  Created by AI Assistant
//

import SwiftUI

struct MainTabView: View {
    var body: some View {
        TabView {
            WardrobeView()
                .tabItem {
                    Image(systemName: "tshirt")
                    Text("衣橱")
                }

            Text("小花园")
                .tabItem {
                    Image(systemName: "leaf")
                    Text("花园")
                }

            Text("手账")
                .tabItem {
                    Image(systemName: "book")
                    Text("手账")
                }

            SettingsView()
                .tabItem {
                    Image(systemName: "gearshape")
                    Text("设置")
                }
        }
        .accentColor(.orange)
    }
}

#Preview {
    MainTabView()
}
