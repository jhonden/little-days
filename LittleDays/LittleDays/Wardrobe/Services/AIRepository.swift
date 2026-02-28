//
//  AIRepository.swift
//  LittleDays
//
//  Created by AI Assistant
//

import Foundation
import UIKit

// MARK: - AI 抽象协议

/// AI服务抽象层
protocol AIRepository {
    /// 分析衣服图片，提取属性
    func analyzeClothing(from image: UIImage) async throws -> ClothingAttributes

    /// 根据场合推荐穿搭
    func recommendOutfits(occasion: String, wardrobe: [Clothing]) async throws -> [OutfitRecommendation]
}

// MARK: - AI提供商

enum AIProvider {
    case local  // 本地AI（Core ML + Vision）
    case cloud  // 云端AI（OpenAI API等）
}

// MARK: - AI服务工厂

class AIRepositoryFactory {
    static func create(provider: AIProvider) -> AIRepository {
        switch provider {
        case .local:
            return LocalAIRepository()
        case .cloud:
            return CloudAIRepository()
        }
    }
}

// MARK: - 本地AI实现（占位）

class LocalAIRepository: AIRepository {
    func analyzeClothing(from image: UIImage) async throws -> ClothingAttributes {
        // TODO: 使用 Vision + Core ML 实现
        // 这里暂时返回默认值
        return ClothingAttributes(
            type: .top,
            color: ["白色"],
            style: .casual,
            season: [.spring, .summer],
            occasion: [.daily],
            confidence: 0.5
        )
    }

    func recommendOutfits(occasion: String, wardrobe: [Clothing]) async throws -> [OutfitRecommendation] {
        // TODO: 实现本地规则引擎
        return []
    }
}

// MARK: - 云端AI实现（占位）

class CloudAIRepository: AIRepository {
    func analyzeClothing(from image: UIImage) async throws -> ClothingAttributes {
        // TODO: 调用云端 API（如 GPT-4 Vision）
        fatalError("Cloud AI implementation pending")
    }

    func recommendOutfits(occasion: String, wardrobe: [Clothing]) async throws -> [OutfitRecommendation] {
        // TODO: 调用云端 API
        fatalError("Cloud AI implementation pending")
    }
}
