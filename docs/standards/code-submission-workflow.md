# 代码提交流程

**重要规则：修改代码后不要自动提交**

---

## 1. 验证要求

### 1.1 路径检查规则

**⚠️ 重要：执行路径相关命令前必须检查当前工作目录**

在执行编译、打包、启动等与路径强相关的命令前，**必须先检查当前路径是否正确**，避免在错误目录下执行命令。

#### 项目根目录表示

本规约使用 `$PROJECT_ROOT` 表示项目根目录。此变量的值为动态获取：

**获取方式（按优先级）：**

1. **环境变量**（最高优先级）
   ```bash
   # 在 ~/.zshrc 或 ~/.bash_profile 中设置
   export LITTLE_DAYS_HOME=/path/to/little-days
   ```

2. **Git 仓库根目录检测**（默认方式）
   ```bash
   # 自动检测 Git 仓库根目录
   git rev-parse --show-toplevel
   ```

3. **README.md 文件检测**（备用方式）
   ```bash
   # 查找包含 README.md 的目录
   find . -maxdepth 3 -name "README.md" -type f | head -1
   ```

#### AI 助手行为要求

在会话开始时，AI 助手必须：
1. 读取规约文档
2. **动态获取并记住** `$PROJECT_ROOT` 的实际值
3. **在后续所有命令中优先使用** `$PROJECT_ROOT` 而非硬编码路径
4. 在执行路径相关命令前，检查当前目录是否为 `$PROJECT_ROOT`

#### 正确做法

```bash
# ✅ 使用 $PROJECT_ROOT 变量
cd $PROJECT_ROOT
xcodebuild -project LittleDays.xcodeproj -scheme LittleDays

# 或者在命令前检查
if [ "$PWD" != "$PROJECT_ROOT" ]; then
    echo "错误：当前目录不是项目根目录"
    echo "请切换到项目根目录：$PROJECT_ROOT"
    return 1
fi
```

#### 错误做法

```bash
# ❌ 硬编码路径
cd /Users/gaowen/Code/little-days

# ❌ 不检查路径直接执行
xcodebuild -project LittleDays.xcodeproj -scheme LittleDays
```

#### 需要检查路径的命令

- Xcode 编译：`xcodebuild`
- 模拟器运行：`xcrun simctl`
- Git 操作（确保在正确仓库）

---

### 1.2 修改完成后必须验证

- 确保项目能够编译通过
- 确保应用能够在模拟器上正常启动
- 验证基本功能正常

---

### 1.3 验证步骤

#### Xcode 编译验证

**方式 1：使用命令行**
```bash
# 编译项目
xcodebuild -project LittleDays.xcodeproj -scheme LittleDays -destination 'platform=iOS Simulator,name=iPhone 15' clean build

# 或简单编译检查
xcodebuild -project LittleDays.xcodeproj -scheme LittleDays build
```

**方式 2：使用 Xcode**
1. 打开 Xcode 项目
2. 选择 Scheme: LittleDays
3. 选择目标设备（模拟器或真机）
4. 点击 Product → Build（或 ⌘B）
5. 检查 Build Succeeded

#### 模拟器运行验证

```bash
# 启动模拟器
xcrun simctl boot "iPhone 15"

# 安装并运行
xcrun simctl install booted "$PROJECT_ROOT/build/Build/Products/Debug-iphonesimulator/LittleDays.app"
xcrun simctl launch booted com.littledays.app
```

或在 Xcode 中点击 Run（⌘R）

#### 功能验证

- 创建测试数据
- 操作 UI 测试功能
- 验证数据正确保存和读取
- 检查 Core Data 数据是否正确存储

---

### 1.4 验证通过标准

**编译验证通过标准：**
- ✅ Xcode 编译成功（Build Succeeded）
- ✅ 无 Swift 编译错误
- ✅ 无 Swift 编译警告（或明确标注可忽略的警告）

**运行验证通过标准：**
- ✅ 应用在模拟器上成功启动
- ✅ 无崩溃日志
- ✅ UI 正常加载和显示

**功能验证通过标准：**
- ✅ 核心功能操作正常
- ✅ 数据正确保存到 Core Data
- ✅ 无明显 Bug

---

## 2. 提交流程

### 2.1 禁止行为

❌ **严格禁止：**
- 修改代码后立即提交（未验证）
- 存在编译错误时提交
- 存在运行时错误时提交
- 未进行功能验证时提交

---

### 2.2 正确提交流程

**步骤 1：验证完成**
- 确保编译通过
- 确保应用正常启动
- 确保功能验证通过

**步骤 2：询问用户确认**
- 向用户报告验证结果
- 询问用户："代码已验证通过，是否提交？"
- 等待用户明确确认

**步骤 3：执行提交**
```bash
# 只有在用户确认后才执行
git add .
git commit -m "功能：实现 XXX"
git push
```

---

### 2.3 提交信息规范

必须使用中文编写提交信息，格式：
```bash
git commit -m "类型：简短描述"
```

**类型：**
- `功能` - 新功能实现
- `修复` - Bug 修复
- `重构` - 代码重构
- `文档` - 文档更新
- `测试` - 测试相关
- `性能` - 性能优化
- `安全` - 安全修复

**示例：**
```bash
git commit -m "功能：实现衣服拍照录入功能"
git commit -m "修复：解决 Core Data 保存失败的问题"
git commit -m "重构：重构 WardrobeViewModel 的状态管理"
```

---

## 3. 常见问题

### Q1: 为什么要这么严格？

**A:** 确保代码质量，避免：
- 提交无法编译的代码
- 提交有明显 Bug 的代码
- 频繁回滚修复
- 破坏 CI/CD 流程

### Q2: 如果验证失败怎么办？

**A:**
1. 分析错误信息
2. 修复问题
3. 重新验证
4. 验证通过后才能考虑提交

### Q3: 调试代码怎么办？

**A:** 调试代码可以提交，但必须：
- 标记为"调试：添加 XXX 日志"
- 确保不影响现有功能
- 尽快移除调试代码
- 移除前再次验证

### Q4: Xcode 构建很慢怎么办？

**A:**
1. 使用增量编译
2. 使用 Build Settings 优化
3. 清理 Build 文件夹后重新构建

---

## 4. 检查清单

提交前必须通过以下检查：

- [ ] Xcode 编译成功（Build Succeeded）
- [ ] 应用在模拟器上正常启动
- [ ] 基本功能验证通过
- [ ] 用户确认可以提交
- [ ] Git 提交信息符合规范
- [ ] 已删除不必要的调试代码（如果有的话）

---

## 5. 开发环境配置

### 5.1 Xcode 配置

- Xcode 版本：15.0+
- iOS SDK：17.0+
- Swift 版本：5.0+

### 5.2 模拟器配置

- 推荐：iPhone 15 / iPhone 15 Pro
- iOS 版本：17.0+

### 5.3 真机测试

- 开发者证书配置
- Bundle Identifier 设置
- 签名和配置文件（Provisioning Profile）

---

**相关文档**:
- [开发规范](./development-conventions.md) - 编码规范
- [需求设计工作流程](./requirements-design-workflow.md) - 需求设计和实施

---

**文档维护者**: Claude AI Assistant
**最后更新**: 2026-02-28
