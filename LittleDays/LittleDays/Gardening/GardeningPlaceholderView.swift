//
//  GardeningPlaceholderView.swift
//  LittleDays
//
//  花园模块占位视图
//

import SwiftUI

struct GardeningPlaceholderView: View {
    var body: some View {
        ScrollView {
            VStack(spacing: 24) {
                // 标题区域
                VStack(spacing: 12) {
                    Image(systemName: "leaf.fill")
                        .font(.system(size: 80))
                        .foregroundColor(.forestGreen)

                    Text("小花园")
                        .font(.title)
                        .foregroundColor(.forestGreen)

                    Text("功能即将上线，敬请期待...")
                        .font(.subheadline)
                        .foregroundColor(.softGray)
                }
                .padding(.top, 60)

                // 功能预告
                VStack(alignment: .leading, spacing: 16) {
                    featureItem(
                        icon: "camera.macro",
                        title: "植物记录",
                        description: "记录每一株植物的成长历程"
                    )

                    featureItem(
                        icon: "drop.fill",
                        title: "浇水提醒",
                        description: "智能提醒，不忘记照顾每一株"
                    )

                    featureItem(
                        icon: "calendar",
                        title: "成长日记",
                        description: "记录开花、换盆等重要时刻"
                    )
                }
                .padding(.horizontal, 24)
            }
        }
    }

    private func featureItem(icon: String, title: String, description: String) -> some View {
        HStack(alignment: .top, spacing: 16) {
            Image(systemName: icon)
                .font(.system(size: 32))
                .foregroundColor(.forestGreen)
                .frame(width: 40)

            VStack(alignment: .leading, spacing: 4) {
                Text(title)
                    .font(.headline)
                    .foregroundColor(.primary)

                Text(description)
                    .font(.subheadline)
                    .foregroundColor(.secondary)
            }
        }
        .padding()
        .background(Color.white)
        .cornerRadius(12)
        .shadow(color: Color.black.opacity(0.1), radius: 4, x: 0, y: 2)
    }
}

#Preview {
    GardeningPlaceholderView()
}
