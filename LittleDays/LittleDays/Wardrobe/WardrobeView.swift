//
//  WardrobeView.swift
//  LittleDays
//
//  Created by AI Assistant
//

import SwiftUI

struct WardrobeView: View {
    var body: some View {
        NavigationView {
            VStack {
                Image(systemName: "tshirt")
                    .font(.system(size: 60))
                    .foregroundColor(.orange)
                    .padding()

                Text("衣橱模块")
                    .font(.title2)
                    .padding()

                Text("记录你的每一件衣物")
                    .font(.subheadline)
                    .foregroundColor(.secondary)
            }
            .navigationTitle("我的衣橱")
        }
    }
}

#Preview {
    WardrobeView()
}
