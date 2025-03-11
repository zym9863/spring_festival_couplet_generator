# 春联生成器 (Spring Festival Couplet Generator)

[中文文档](README.md) | [English Documentation](README_EN.md)

一个基于Flutter开发的智能春联生成器应用，让您轻松创作传统新年春联。

## 功能特点

- 智能生成：根据用户输入的主题自动生成匹配的春联
- 完整对联：支持生成上联、下联和横批的完整组合
- 传统风格：采用优雅的中国传统设计风格
- 音效反馈：集成了音效，提供更好的交互体验
- 跨平台支持：支持Android、iOS、Web等多个平台

## 技术实现

- 使用Flutter框架开发，确保跨平台一致的用户体验
- 采用主题化设计，实现了优雅的传统中国风界面
- 集成音频播放功能，增强用户交互体验
- 采用服务层架构，实现了业务逻辑的清晰分离

## 项目结构

```
lib/
├── main.dart          # 应用入口
├── screens/           # 界面实现
│   └── home_screen.dart
├── services/          # 业务逻辑
│   └── couplet_service.dart
└── theme/            # 主题相关
    └── app_theme.dart
```

## 开始使用

1. 确保已安装Flutter开发环境
2. 克隆项目到本地
3. 运行以下命令安装依赖：
   ```
   flutter pub get
   ```
4. 运行应用：
   ```
   flutter run
   ```

## 贡献

欢迎提交问题和改进建议！如果您想为项目做出贡献，请：

1. Fork 本仓库
2. 创建您的特性分支 (`git checkout -b feature/AmazingFeature`)
3. 提交您的改动 (`git commit -m 'Add some AmazingFeature'`)
4. 推送到分支 (`git push origin feature/AmazingFeature`)
5. 开启一个 Pull Request

## 许可证

本项目采用 MIT 许可证 - 查看 [LICENSE](LICENSE) 文件了解详情
