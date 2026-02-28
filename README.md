# LittleDays

> 小日子 - 记录生活中的小美好

## 项目简介

一个温馨的生活记录App，记录穿衣搭配、种花养草、日常手账等生活点滴。

### 当前版本：1.0 - 我的衣橱
- 拍照录入衣服
- 衣服分类管理
- 基于场景的穿搭推荐
- AI 智能识别（本地/云端可选）

### 未来规划
- 🌱 小花园 - 种花养草记录
- 📔 手账本 - 日常心情与回忆
- 🍳 食谱集 - 美食烹饪记录

## 技术栈

- Swift 5.0
- SwiftUI
- iOS 17.0+
- Vision Framework（图像识别）
- Core ML（本地AI）
- Core Data（数据持久化）

## 项目结构

```
LittleDays/
├── LittleDays.xcodeproj/       # Xcode 项目文件
├── LittleDays/
│   ├── LittleDays/
│   │   ├── LittleDaysApp.swift      # App 入口
│   │   ├── Views/                    # 通用视图
│   │   │   ├── MainTabView.swift
│   │   │   └── SettingsView.swift
│   │   ├── Wardrobe/                 # 衣橱模块
│   │   │   ├── WardrobeView.swift
│   │   │   ├── Models/
│   │   │   │   └── ClothingModels.swift
│   │   │   └── Services/
│   │   │       └── AIRepository.swift
│   │   ├── Shared/                   # 共享代码
│   │   │   └── Models/
│   │   │       └── AppModule.swift
│   │   ├── Gardening/                # 种花模块（预留）
│   │   ├── Diary/                    # 手账模块（预留）
│   │   └── Assets.xcassets/
```

## AI 架构

项目采用依赖倒置原则，AI 层完全解耦：

```
App 层
    ↓
AIRepository 协议
    ↓
├── LocalAIRepository (Core ML + Vision)
└── CloudAIRepository (OpenAI API)
```

可通过 `AIRepositoryFactory.create(provider:)` 轻松切换 AI 提供商。

## 开发环境

- Xcode 15.0+
- iOS 17.0+
- Swift 5.0+

## License

MIT
