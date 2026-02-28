//
//  AppModule.swift
//  LittleDays
//
//  Created by AI Assistant
//

/// App模块定义
enum AppModule {
    case wardrobe      // 衣橱
    case gardening     // 种花（预留）
    case diary         // 日记（预留）
    case recipe        // 食谱（预留）
}

/// 模块协议
protocol Module {
    var id: AppModule { get }
    var name: String { get }
    var icon: String { get }
}
