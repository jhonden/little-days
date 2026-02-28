# 开发规范

本文档定义了 LittleDays iOS 项目开发过程中的编码规范。

---

## 1. 文档和注释语言规范

**重要：因为项目在中国开发，以下情况必须优先使用中文：**

### 1.1 代码注释

- 业务逻辑注释必须使用中文
- 复杂算法或配置说明必须使用中文
- 示例：
  ```swift
  // 检查衣服类型是否已存在，确保唯一性约束
  if clothingRepository.existsByType(type) {
      throw ClothingError.duplicateType
  }
  ```

### 1.2 文档输出

- 代码文档（Documentation Comments）优先使用中文
- 架构设计文档、API 文档使用中文
- 用户手册、开发指南使用中文

### 1.3 日志输出

- 应用日志信息使用英文（便于日志分析和问题排查）
- 示例：`print("Failed to load clothing image: \(error)")`

### 1.4 用户界面文本

- UI 文本使用中文
- 错误提示、警告信息使用中文
- 示例：`Text("衣橱")`、`Text("照片加载失败")`

### 1.5 例外情况

- 技术术语保持英文（如 JSON、API、Core Data、MVVM 等）
- 变量名、类名、方法名等标识符使用英文
- 配置文件中的 key 使用英文

---

## 2. Swift 编码规范

### 2.1 命名规范

- **类型名**：使用大驼峰命名法（PascalCase）
  ```swift
  struct ClothingAttributes { }
  class WardrobeViewModel { }
  ```

- **函数和变量名**：使用小驼峰命名法（camelCase）
  ```swift
  func analyzeClothing(from image: UIImage) { }
  let clothingType = ClothingType.top
  ```

- **常量**：使用小驼峰命名法（camelCase）
  ```swift
  let maxImageSize = 1024.0
  static let defaultConfidenceThreshold = 0.7
  ```

- **枚举值**：使用小驼峰命名法（camelCase）
  ```swift
  enum ClothingType {
      case top
      case bottom
  }
  ```

### 2.2 代码组织

- 使用 `MARK` 注释组织代码
  ```swift
  class WardrobeViewModel: ObservableObject {
      // MARK: - Properties
      @Published var clothingItems: [Clothing] = []

      // MARK: - Initialization
      init() { }

      // MARK: - Public Methods
      func addClothing(from image: UIImage) { }

      // MARK: - Private Methods
      private func processImage(_ image: UIImage) { }
  }
  ```

### 2.3 访问控制

- 默认使用 `private`，根据需要逐步放宽
- 使用 `internal` 作为模块内部的默认访问级别
- 仅在需要时使用 `public` 或 `open`

### 2.4 可选类型

- 优先使用可选类型而非隐式解包
- 使用 `guard let` 或 `if let` 安全解包
- 避免强制解包（`!`），除非有明确理由并添加注释

### 2.5 异常处理

- 使用 Swift 的 `Result` 类型处理异步操作
- 使用 `do-catch` 处理可能抛出的错误
- 自定义错误类型遵循 `Error` 协议
  ```swift
  enum ClothingError: Error, LocalizedError {
      case invalidImage
      case duplicateType
      case saveFailed

      var errorDescription: String? {
          switch self {
          case .invalidImage: return "图片格式不正确"
          case .duplicateType: return "衣服类型已存在"
          case .saveFailed: return "保存失败"
          }
      }
  }
  ```

---

## 3. SwiftUI 开发规范

### 3.1 组件规范

- 使用 SwiftUI 的 `View` 协议构建视图
- 优先使用函数式视图组合
- 避免在 View 中放置过多业务逻辑

### 3.2 状态管理

- 使用 `@State` 管理视图本地状态
- 使用 `@Published` + `ObservableObject` 管理共享状态
- 使用 `@EnvironmentObject` 传递全局状态
- 避免滥用 `@ObservedObject`，根据场景选择合适的状态管理方式

### 3.3 视图修饰符（ViewModifier）

- 将可复用的视图修饰符定义为独立的 `ViewModifier`
- 示例：
  ```swift
  struct CardModifier: ViewModifier {
      func body(content: Content) -> some View {
          content
              .padding()
              .background(Color.white)
              .cornerRadius(12)
              .shadow(radius: 4)
      }
  }

  // 使用
  Text("Hello")
      .modifier(CardModifier())
  ```

### 3.4 预览（Preview）

- 为每个 View 提供 Preview
- 使用 `#Preview` 宏（SwiftUI 新语法）
- 示例：
  ```swift
  #Preview {
      WardrobeView()
  }
  ```

---

## 4. MVVM 架构规范

### 4.1 架构分层

```
┌─────────────┐
│     UI      │  SwiftUI View
│  (View)     │  负责展示和用户交互
└──────┬──────┘
       │
       ↓
┌─────────────┐
│  ViewModel  │  ObservableObject
│ (ViewModel) │  负责业务逻辑和状态管理
└──────┬──────┘
       │
       ↓
┌─────────────┐
│    Model    │  Struct / Entity
│  (Model)    │  负责数据定义
└─────────────┘
```

### 4.2 View 规范

- View 只负责 UI 展示和用户交互
- 不包含业务逻辑
- 通过 `@ObservedObject` 或 `@StateObject` 绑定 ViewModel
- 示例：
  ```swift
  struct WardrobeView: View {
      @StateObject private var viewModel = WardrobeViewModel()

      var body: some View {
          List(viewModel.clothingItems) { item in
              ClothingRow(item: item)
          }
      }
  }
  ```

### 4.3 ViewModel 规范

- 继承 `ObservableObject`
- 使用 `@Published` 发布状态变化
- 包含业务逻辑
- 不引用任何 UIKit 或 SwiftUI 组件
- 示例：
  ```swift
  class WardrobeViewModel: ObservableObject {
      @Published var clothingItems: [Clothing] = []
      @Published var isLoading = false

      private let repository: ClothingRepository

      func loadClothing() {
          isLoading = true
          // 业务逻辑...
      }
  }
  ```

### 4.4 Model 规范

- 使用 `struct` 定义数据模型
- 遵循 `Codable` 协议支持序列化
- 遵循 `Identifiable` 协议用于列表展示
- 示例：
  ```swift
  struct Clothing: Identifiable, Codable {
      let id: UUID
      let type: ClothingType
      let imageData: Data
      let createdAt: Date
  }
  ```

---

## 5. Core Data 规范

### 5.1 命名规范

- Entity 名称使用单数形式（如 `Clothing` 而非 `Clothings`）
- Attribute 使用小驼峰命名
- Relationship 使用小驼峰命名

### 5.2 模型设计

- 为每个 Entity 创建对应的 Swift 扩展
- 使用 `NSManagedObject` 的子类
- 示例：
  ```swift
  @objc(Clothing)
  public class Clothing: NSManagedObject {
      @NSManaged public var id: UUID
      @NSManaged public var type: String
      @NSManaged public var imageData: Data
      @NSManaged public var createdAt: Date
  }
  ```

### 5.3 上下文管理

- 使用 `@Environment(\.managedObjectContext)` 获取上下文
- 在 ViewModel 中注入 `NSManagedObjectContext`
- 及时保存上下文，避免内存泄漏

### 5.4 Core Data 和 Model 转换

- 创建转换函数在 Core Data Entity 和 Model 之间转换
- 示例：
  ```swift
  extension Clothing {
      func toModel() -> ClothingModel {
          return ClothingModel(
              id: id,
              type: ClothingType(rawValue: type) ?? .other,
              imageData: imageData,
              createdAt: createdAt
          )
      }
  }
  ```

---

## 6. 测试规范

### 6.1 单元测试

- 核心业务逻辑必须有单元测试
- 测试文件命名：`{类名}Tests.swift`
- 使用 XCTest 框架
- 示例：
  ```swift
  import XCTest
  @testable import LittleDays

  class WardrobeViewModelTests: XCTestCase {
      func testAddClothing() throws {
          // Given
          let viewModel = WardrobeViewModel()

          // When
          viewModel.addClothing(from: mockImage)

          // Then
          XCTAssertEqual(viewModel.clothingItems.count, 1)
      }
  }
  ```

### 6.2 UI 测试

- 关键用户流程必须有 UI 测试
- 测试文件命名：`{类名}UITests.swift`
- 使用 XCUITest 框架

---

## 7. iOS 安全规范

### 7.1 权限使用

- 遵循最小权限原则
- 在 Info.plist 中说明权限使用目的
- 提前检查权限状态，优雅处理拒绝情况

### 7.2 数据存储

- 敏感数据使用 Keychain 存储
- 普通数据使用 UserDefaults 或 Core Data
- 加密敏感的图片和数据

### 7.3 网络安全

- 使用 HTTPS 通信
- 验证 API 响应数据
- 对用户输入进行验证和清理

---

## 8. Git 工作流规范

- 每个功能开发一个分支
- 功能完成后合并到 main 分支
- 合并前确保功能验证通过
- 详细流程见：[代码提交流程](./code-submission-workflow.md)

---

**相关文档**:
- [代码提交流程](./code-submission-workflow.md) - 代码验证和提交
- [需求设计工作流程](./requirements-design-workflow.md) - 需求设计和实施

---

**文档维护者**: Claude AI Assistant
**最后更新**: 2026-02-28
