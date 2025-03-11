# Spring Festival Couplet Generator

[中文文档](README.md) | [English Documentation](README_EN.md)

A Flutter-based intelligent couplet generator app for creating traditional Chinese New Year couplets.

## Features

- Smart Generation: Automatically generates couplets based on user input themes
- Complete Set: Generates upper couplet, lower couplet and horizontal scroll
- Traditional Style: Elegant Chinese traditional design aesthetics
- Sound Feedback: Integrated sound effects for better interaction
- Cross-platform: Supports Android, iOS, Web and more

## Technical Implementation

- Built with Flutter framework for consistent cross-platform experience
- Themed design with traditional Chinese elements
- Audio playback integration for enhanced interaction
- Service layer architecture for clear separation of business logic

## Project Structure

```
lib/
├── main.dart          # Application entry
├── screens/           # UI implementations
│   └── home_screen.dart
├── services/          # Business logic
│   └── couplet_service.dart
└── theme/             # Theme related
    └── app_theme.dart
```

## Getting Started

1. Ensure Flutter development environment is installed
2. Clone the repository
3. Install dependencies:
   ```
   flutter pub get
   ```
4. Run the app:
   ```
   flutter run
   ```

## Contribution

Welcome to submit issues and improvement suggestions! To contribute:

1. Fork the repository
2. Create your feature branch (`git checkout -b feature/AmazingFeature`)
3. Commit your changes (`git commit -m 'Add some AmazingFeature'`)
4. Push to the branch (`git push origin feature/AmazingFeature`)
5. Open a Pull Request

## License

This project is licensed under the MIT License - see the [LICENSE](LICENSE) file for details