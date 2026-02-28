//
//  ClothingModels.swift
//  LittleDays
//
//  Created by AI Assistant
//

import Foundation

// MARK: - 衣服基础数据（与AI解耦）

/// 衣服类型
enum ClothingType: String, CaseIterable, Codable {
    case top = "上衣"
    case bottom = "下装"
    case dress = "连衣裙"
    case outerwear = "外套"
    case shoes = "鞋子"
    case accessory = "配饰"
    case bag = "包包"
    case other = "其他"
}

/// 衣服风格
enum ClothingStyle: String, CaseIterable, Codable {
    case casual = "休闲"
    case formal = "正式"
    case sport = "运动"
    case vintage = "复古"
    case minimalist = "极简"
    case romantic = "浪漫"
    case bohemian = "波西米亚"
    case other = "其他"
}

/// 季节
enum Season: String, CaseIterable, Codable {
    case spring = "春"
    case summer = "夏"
    case autumn = "秋"
    case winter = "冬"
}

/// 场合
enum Occasion: String, CaseIterable, Codable {
    case daily = "日常"
    case work = "工作"
    case date = "约会"
    case party = "聚会"
    case travel = "旅行"
    case exercise = "运动"
    case formal = "正式"
}

/// 衣服属性（AI识别结果）
struct ClothingAttributes: Codable {
    let type: ClothingType
    let color: [String]
    let style: ClothingStyle
    let season: [Season]
    let occasion: [Occasion]
    let confidence: Float
}

/// 衣服实体
struct Clothing: Identifiable, Codable {
    let id: UUID
    let imageData: Data
    let attributes: ClothingAttributes
    let createdAt: Date
    let notes: String?
}

/// 穿搭推荐
struct OutfitRecommendation: Identifiable, Codable {
    let id: UUID
    let clothing: [Clothing]
    let reason: String
    let score: Float
}
