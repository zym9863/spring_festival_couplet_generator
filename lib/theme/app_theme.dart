import 'package:flutter/material.dart';

class AppTheme {
  // 基础色谱
  static const Color storyRed = Color(0xFFD32F2F); // 故宫红 (CMYK 0/100/90/10 近似值)
  static const Color imperialGold = Color(0xFFD4AF37); // 帝王金
  static const Color indigoBlue = Color(0xFF1A5599); // 靛青 (PANTONE 19-4053 近似值)
  static const Color paperBackground = Color(0xFFFAF0DC); // 米色宣纸纹理
  
  // 辅助色
  static const Color inkBlack = Color(0xFF333333); // 墨黑
  static const Color cinnabarRed = Color(0xFFE63946); // 朱砂红
  static const Color jadeGreen = Color(0xFF3A9679); // 松石绿
  static const Color lotusRed = Color(0xFFEAC7C7); // 藕粉
  static const Color indigoBlue2 = Color(0xFF5465FF); // 黛蓝
  
  // 渐变
  static const LinearGradient redGoldGradient = LinearGradient(
    colors: [storyRed, imperialGold],
    begin: Alignment.topLeft,
    end: Alignment.bottomRight,
  );
  
  static const LinearGradient goldGradient = LinearGradient(
    colors: [Color(0xFFD4AF37), Color(0xFFF5E1A4), Color(0xFFD4AF37)],
    begin: Alignment.topLeft,
    end: Alignment.bottomRight,
  );
  
  // 文本样式
  static TextStyle get titleStyle => const TextStyle(
    fontFamily: 'FZLTH', // 方正隶书
    fontSize: 24,
    fontWeight: FontWeight.bold,
    color: storyRed,
    letterSpacing: 2.0,
  );
  
  static TextStyle get subtitleStyle => const TextStyle(
    fontFamily: 'FZLTH',
    fontSize: 18,
    fontWeight: FontWeight.w600,
    color: inkBlack,
  );
  
  static TextStyle get bodyStyle => const TextStyle(
    fontFamily: 'FZSTK', // 方正书宋
    fontSize: 16,
    color: inkBlack,
  );
  
  static TextStyle get coupletStyle => const TextStyle(
    fontFamily: 'FZLTH',
    fontSize: 22,
    fontWeight: FontWeight.bold,
    color: storyRed,
    letterSpacing: 4.0,
    height: 1.5,
  );
  
  static TextStyle get horizontalStyle => const TextStyle(
    fontFamily: 'FZLTH',
    fontSize: 28,
    fontWeight: FontWeight.bold,
    color: storyRed,
    letterSpacing: 8.0,
  );
  
  // 装饰
  static BoxDecoration get paperDecoration => BoxDecoration(
    color: paperBackground,
  );
  
  static BoxDecoration get cardDecoration => BoxDecoration(
    color: Colors.white.withOpacity(0.9),
    borderRadius: BorderRadius.circular(12),
    boxShadow: [
      BoxShadow(
        color: Colors.black.withOpacity(0.1),
        blurRadius: 10,
        offset: const Offset(0, 4),
      ),
    ],
    border: Border.all(color: imperialGold.withOpacity(0.3), width: 1),
  );
  
  static BoxDecoration get coupletContainerDecoration => BoxDecoration(
    color: paperBackground,
    borderRadius: BorderRadius.circular(8),
    border: Border.all(color: storyRed, width: 2),
    boxShadow: [
      BoxShadow(
        color: Colors.black.withOpacity(0.1),
        blurRadius: 6,
        offset: const Offset(0, 2),
      ),
    ],
  );
  
  // 按钮样式
  static ButtonStyle get primaryButtonStyle => ElevatedButton.styleFrom(
    backgroundColor: storyRed,
    foregroundColor: Colors.white,
    elevation: 4,
    padding: const EdgeInsets.symmetric(vertical: 16, horizontal: 24),
    shape: RoundedRectangleBorder(
      borderRadius: BorderRadius.circular(8),
      side: const BorderSide(color: imperialGold, width: 1),
    ),
    textStyle: const TextStyle(
      fontFamily: 'FZLTH',
      fontSize: 18,
      fontWeight: FontWeight.bold,
      letterSpacing: 2,
    ),
  );
  
  static ButtonStyle get outlinedButtonStyle => OutlinedButton.styleFrom(
    foregroundColor: storyRed,
    side: const BorderSide(color: storyRed, width: 1.5),
    padding: const EdgeInsets.symmetric(vertical: 12, horizontal: 16),
    shape: RoundedRectangleBorder(
      borderRadius: BorderRadius.circular(8),
    ),
  );
  
  // 输入框装饰
  static InputDecoration get inputDecoration => InputDecoration(
    filled: true,
    fillColor: Colors.white,
    border: OutlineInputBorder(
      borderRadius: BorderRadius.circular(8),
      borderSide: const BorderSide(color: imperialGold, width: 1),
    ),
    enabledBorder: OutlineInputBorder(
      borderRadius: BorderRadius.circular(8),
      borderSide: BorderSide(color: imperialGold.withOpacity(0.5), width: 1),
    ),
    focusedBorder: OutlineInputBorder(
      borderRadius: BorderRadius.circular(8),
      borderSide: const BorderSide(color: imperialGold, width: 2),
    ),
    contentPadding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
  );
  
  // 应用主题数据
  static ThemeData get themeData => ThemeData(
    primaryColor: storyRed,
    scaffoldBackgroundColor: paperBackground,
    colorScheme: ColorScheme.fromSeed(
      seedColor: storyRed,
      primary: storyRed,
      secondary: imperialGold,
      tertiary: indigoBlue,
      background: paperBackground,
    ),
    textTheme: TextTheme(
      displayLarge: titleStyle,
      displayMedium: subtitleStyle,
      bodyLarge: bodyStyle,
    ),
    elevatedButtonTheme: ElevatedButtonThemeData(
      style: primaryButtonStyle,
    ),
    outlinedButtonTheme: OutlinedButtonThemeData(
      style: outlinedButtonStyle,
    ),
    inputDecorationTheme: InputDecorationTheme(
      filled: true,
      fillColor: Colors.white,
      border: OutlineInputBorder(
        borderRadius: BorderRadius.circular(8),
        borderSide: const BorderSide(color: imperialGold, width: 1),
      ),
    ),
    cardTheme: CardThemeData(
      elevation: 4,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(12),
        side: BorderSide(color: imperialGold.withOpacity(0.3), width: 1),
      ),
    ),
    appBarTheme: const AppBarTheme(
      backgroundColor: storyRed,
      foregroundColor: Colors.white,
      centerTitle: true,
      elevation: 0,
      titleTextStyle: TextStyle(
        fontFamily: 'FZLTH',
        fontSize: 22,
        fontWeight: FontWeight.bold,
        color: Colors.white,
        letterSpacing: 4,
      ),
    ),
    useMaterial3: true,
  );
}
