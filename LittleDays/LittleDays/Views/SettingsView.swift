//
//  SettingsView.swift
//  LittleDays
//
//  Created by AI Assistant
//

import SwiftUI

struct SettingsView: View {
    var body: some View {
        NavigationView {
            Form {
                Section("AI服务") {
                    HStack {
                        Text("AI提供商")
                        Spacer()
                        Text("本地")
                            .foregroundColor(.secondary)
                    }

                    HStack {
                        Text("自动识别")
                        Spacer()
                        Toggle("", isOn: .constant(true))
                    }
                }

                Section("关于") {
                    HStack {
                        Text("版本")
                        Spacer()
                        Text("1.0.0")
                            .foregroundColor(.secondary)
                    }

                    HStack {
                        Text("项目")
                        Spacer()
                        Text("LittleDays")
                            .foregroundColor(.secondary)
                    }
                }
            }
            .navigationTitle("设置")
        }
    }
}

#Preview {
    SettingsView()
}
