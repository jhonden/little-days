//
//  DiaryPlaceholderView.swift
//  LittleDays
//
//  手账模块占位视图
//

import SwiftUI

struct DiaryPlaceholderView: View {
    var body: some View {
        ScrollView {
            VStack(spacing: 24) {
                // 标题区域
                VStack(spacing: 12) {
                    Image(systemName: "book.fill")
                        .font(.system(size: 80))
                        .foregroundColor(.sunlightOrange)

                    Text("手账本")
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
                        icon: "heart.fill",
                        title: "每日心情",
                        description: "记录每一天的心情和感受"
                    )

                    featureItem(
                        icon: "photo.stack",
                        title: "照片墙",
                        description: "收藏美好瞬间，回顾回忆"
                    )

                    featureItem(
                        icon: "star.fill",
                        title: "重要日子",
                        description: "纪念日提醒，不错过重要时刻"
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
    DiaryPlaceholderView()
}
