import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:audioplayers/audioplayers.dart'; // 导入 audioplayers 包
import '../services/couplet_service.dart';
import '../theme/app_theme.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  Image? _coupletImage;

  final TextEditingController _themeController = TextEditingController();
  final TextEditingController _apiKeyController = TextEditingController();
  final TextEditingController _upperController = TextEditingController();
  final TextEditingController _lowerController = TextEditingController();
  final TextEditingController _horizontalController = TextEditingController();
  
  final CoupletService _coupletService = CoupletService();
  bool _isLoading = false;
  String _errorMessage = '';

  final AudioPlayer _audioPlayer = AudioPlayer();

  @override
  void dispose() {
    _themeController.dispose();
    _apiKeyController.dispose();
    _upperController.dispose();
    _lowerController.dispose();
    _horizontalController.dispose();
    _audioPlayer.dispose();
    super.dispose();
  }

  Future<void> _generateCouplet() async {
    final theme = _themeController.text.trim();
    final apiKey = _apiKeyController.text.trim();
    
    if (theme.isEmpty) {
      setState(() {
        _errorMessage = '请输入主题';
      });
      return;
    }
    
    if (apiKey.isEmpty) {
      setState(() {
        _errorMessage = '请输入OpenRouter API密钥';
      });
      return;
    }

    setState(() {
      _isLoading = true;
      _errorMessage = '';
    });

    try {
      _coupletService.setApiKey(apiKey);
      final couplet = await _coupletService.generateCouplet(theme);
      
      setState(() {
        _upperController.text = couplet['upper'] ?? '';
        _lowerController.text = couplet['lower'] ?? '';
        _horizontalController.text = couplet['horizontal'] ?? '';
        _isLoading = false;
        _coupletImage = Image.asset('assets/generated_1741682642636.png');
        try {
      _audioPlayer.play(AssetSource('sound-effect-1741682665805.mp3')).then((_) {
  }).catchError((error) {
  print('音效播放失败: $error');
  });
        } catch (e) {
          print('音效播放失败: $e');
          // 音效播放失败不影响主要功能
        }
      });
    } catch (e) {
      setState(() {
        _errorMessage = e.toString();
        _isLoading = false;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: AppTheme.storyRed,
        title: Text('春联生成器', style: AppTheme.titleStyle.copyWith(color: Colors.white)),
        centerTitle: true,
        elevation: 0,
      ),
      body: Container(
        decoration: AppTheme.paperDecoration,
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                // API密钥输入区
                Card(
                  elevation: 4,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(12),
                    side: BorderSide(color: AppTheme.imperialGold.withOpacity(0.3), width: 1),
                  ),
                  child: Container(
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(12),
                      gradient: LinearGradient(
                        colors: [Colors.white, AppTheme.paperBackground.withOpacity(0.3)],
                        begin: Alignment.topCenter,
                        end: Alignment.bottomCenter,
                      ),
                    ),
                    padding: const EdgeInsets.all(16.0),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Row(
                          children: [
                            Icon(Icons.key, color: AppTheme.storyRed, size: 20),
                            const SizedBox(width: 8),
                            Text('OpenRouter API密钥', 
                              style: AppTheme.subtitleStyle),
                          ],
                        ),
                        const SizedBox(height: 12),
                        TextField(
                          controller: _apiKeyController,
                          decoration: AppTheme.inputDecoration.copyWith(
                            hintText: '请输入您的OpenRouter API密钥',
                            hintStyle: TextStyle(color: AppTheme.inkBlack.withOpacity(0.5)),
                            prefixIcon: Icon(Icons.lock_outline, color: AppTheme.imperialGold),
                            isDense: true,
                          ),
                          obscureText: true,
                        ),
                        const SizedBox(height: 8),
                        Row(
                          children: [
                            Icon(Icons.info_outline, size: 14, color: AppTheme.indigoBlue),
                            const SizedBox(width: 4),
                            Text('获取密钥: https://openrouter.ai', 
                              style: TextStyle(fontSize: 12, color: AppTheme.indigoBlue, fontStyle: FontStyle.italic)),
                          ],
                        ),
                      ],
                    ),
                  ),
                ),
                
                const SizedBox(height: 16),
                
                // 主题输入区
                Card(
                  elevation: 4,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(12),
                    side: BorderSide(color: AppTheme.imperialGold.withOpacity(0.3), width: 1),
                  ),
                  child: Container(
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(12),
                      gradient: LinearGradient(
                        colors: [Colors.white, AppTheme.paperBackground.withOpacity(0.3)],
                        begin: Alignment.topCenter,
                        end: Alignment.bottomCenter,
                      ),
                    ),
                    padding: const EdgeInsets.all(16.0),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Row(
                          children: [
                            Icon(Icons.brush, color: AppTheme.storyRed, size: 20),
                            const SizedBox(width: 8),
                            Text('春联主题', style: AppTheme.subtitleStyle),
                          ],
                        ),
                        const SizedBox(height: 12),
                        TextField(
                          controller: _themeController,
                          decoration: AppTheme.inputDecoration.copyWith(
                            hintText: '例如：新年、福、春天、家庭...',
                            hintStyle: TextStyle(color: AppTheme.inkBlack.withOpacity(0.5)),
                            prefixIcon: Icon(Icons.celebration, color: AppTheme.imperialGold),
                          ),
                        ),
                        const SizedBox(height: 20),
                        SizedBox(
                          width: double.infinity,
                          height: 56,
                          child: ElevatedButton(
                            onPressed: _isLoading ? null : _generateCouplet,
                            style: AppTheme.primaryButtonStyle,
                            child: _isLoading 
                              ? SizedBox(
                                  width: 24, 
                                  height: 24, 
                                  child: CircularProgressIndicator(
                                    color: Colors.white,
                                    strokeWidth: 3,
                                  )
                                )
                              : Row(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    Icon(Icons.auto_awesome, color: AppTheme.imperialGold),
                                    const SizedBox(width: 8),
                                    Text('生成春联', style: TextStyle(fontSize: 18, letterSpacing: 2)),
                                  ],
                                ),
                          ),
                        ),
                        
                        if (_errorMessage.isNotEmpty)
                          Padding(
                            padding: const EdgeInsets.only(top: 8.0),
                            child: Text(_errorMessage, 
                              style: const TextStyle(color: Colors.red)),
                          ),
                      ],
                    ),
                  ),
                ),
                
                const SizedBox(height: 24),
                
                // 对联展示区
                if (_horizontalController.text.isNotEmpty || 
                    _upperController.text.isNotEmpty || 
                    _lowerController.text.isNotEmpty)
                  Card(
                    elevation: 4,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(12),
                      side: BorderSide(color: AppTheme.storyRed.withOpacity(0.5), width: 1.5),
                    ),
                    color: AppTheme.paperBackground,
                    child: Container(
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(12),
                        image: const DecorationImage(
                          image: AssetImage('assets/generated_1741682642636.png'),
                          fit: BoxFit.cover,
                          opacity: 0.1,
                        ),
                      ),
                      padding: const EdgeInsets.all(16.0),
                      child: Column(
                        children: [
                          // 横批
                          if (_horizontalController.text.isNotEmpty)
                            Container(
                              width: double.infinity,
                              padding: const EdgeInsets.symmetric(vertical: 16),
                              decoration: BoxDecoration(
                                border: Border.all(color: AppTheme.storyRed, width: 2),
                                color: Colors.white.withOpacity(0.8),
                                borderRadius: BorderRadius.circular(8),
                                boxShadow: [
                                  BoxShadow(
                                    color: AppTheme.inkBlack.withOpacity(0.1),
                                    blurRadius: 6,
                                    offset: const Offset(0, 2),
                                  ),
                                ],
                              ),
                              child: Column(
                                children: [
                                  Container(
                                    padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 4),
                                    decoration: BoxDecoration(
                                      color: AppTheme.storyRed,
                                      borderRadius: BorderRadius.circular(16),
                                    ),
                                    child: Text('横批', 
                                      style: TextStyle(fontSize: 14, color: Colors.white, fontWeight: FontWeight.bold)),
                                  ),
                                  const SizedBox(height: 12),
                                  Row(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: [
                                      Expanded(
                                        child: TextField(
                                          controller: _horizontalController,
                                          textAlign: TextAlign.center,
                                          style: AppTheme.horizontalStyle,
                                          decoration: const InputDecoration(
                                            border: InputBorder.none,
                                            isDense: true,
                                          ),
                                        ),
                                      ),
                                      Container(
                                        decoration: BoxDecoration(
                                          shape: BoxShape.circle,
                                          border: Border.all(color: AppTheme.imperialGold, width: 1),
                                          color: Colors.white,
                                        ),
                                        child: IconButton(
                                          icon: Icon(Icons.content_copy, color: AppTheme.storyRed),
                                          onPressed: () {
                                            Clipboard.setData(ClipboardData(
                                              text: _horizontalController.text
                                            ));
                                            ScaffoldMessenger.of(context).showSnackBar(
                                              SnackBar(
                                                content: Text('横批已复制到剪贴板'),
                                                backgroundColor: AppTheme.storyRed,
                                              )
                                            );
                                          },
                                        ),
                                      ),
                                    ],
                                  ),
                                ],
                              ),
                            ),
                          
                          const SizedBox(height: 24),
                          
                          // 上下联
                          if (_coupletImage != null)
                            Padding(
                              padding: const EdgeInsets.only(bottom: 16.0),
                              child: Container(
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(8),
                                  boxShadow: [
                                    BoxShadow(
                                      color: AppTheme.inkBlack.withOpacity(0.2),
                                      blurRadius: 8,
                                      offset: const Offset(0, 3),
                                    ),
                                  ],
                                ),
                                child: ClipRRect(
                                  borderRadius: BorderRadius.circular(8),
                                  child: _coupletImage,
                                ),
                              ),
                            ),
                          Row(
                            children: [
                              // 上联
                              if (_upperController.text.isNotEmpty)
                                Expanded(
                                  child: Container(
                                    padding: const EdgeInsets.symmetric(vertical: 16, horizontal: 8),
                                    decoration: BoxDecoration(
                                      border: Border.all(color: AppTheme.storyRed, width: 2),
                                      color: Colors.white.withOpacity(0.8),
                                      borderRadius: BorderRadius.circular(8),
                                      boxShadow: [
                                        BoxShadow(
                                          color: AppTheme.inkBlack.withOpacity(0.1),
                                          blurRadius: 6,
                                          offset: const Offset(0, 2),
                                        ),
                                      ],
                                    ),
                                    child: Column(
                                      children: [
                                        Container(
                                          padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 4),
                                          decoration: BoxDecoration(
                                            color: AppTheme.storyRed,
                                            borderRadius: BorderRadius.circular(16),
                                          ),
                                          child: Text('上联', 
                                            style: TextStyle(fontSize: 14, color: Colors.white, fontWeight: FontWeight.bold)),
                                        ),
                                        const SizedBox(height: 12),
                                        TextField(
                                          controller: _upperController,
                                          textAlign: TextAlign.center,
                                          style: AppTheme.coupletStyle,
                                          maxLines: 2,
                                          decoration: const InputDecoration(
                                            border: InputBorder.none,
                                            isDense: true,
                                          ),
                                        ),
                                        Container(
                                          decoration: BoxDecoration(
                                            shape: BoxShape.circle,
                                            border: Border.all(color: AppTheme.imperialGold, width: 1),
                                            color: Colors.white,
                                          ),
                                          child: IconButton(
                                            icon: Icon(Icons.content_copy, color: AppTheme.storyRed),
                                            onPressed: () {
                                              Clipboard.setData(ClipboardData(
                                                text: _upperController.text
                                              ));
                                              ScaffoldMessenger.of(context).showSnackBar(
                                                SnackBar(
                                                  content: Text('上联已复制到剪贴板'),
                                                  backgroundColor: AppTheme.storyRed,
                                                )
                                              );
                                            },
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                ),
                              
                              const SizedBox(width: 16),
                              
                              // 下联
                              if (_lowerController.text.isNotEmpty)
                                Expanded(
                                  child: Container(
                                    padding: const EdgeInsets.symmetric(vertical: 16, horizontal: 8),
                                    decoration: BoxDecoration(
                                      border: Border.all(color: AppTheme.storyRed, width: 2),
                                      color: Colors.white.withOpacity(0.8),
                                      borderRadius: BorderRadius.circular(8),
                                      boxShadow: [
                                        BoxShadow(
                                          color: AppTheme.inkBlack.withOpacity(0.1),
                                          blurRadius: 6,
                                          offset: const Offset(0, 2),
                                        ),
                                      ],
                                    ),
                                    child: Column(
                                      children: [
                                        Container(
                                          padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 4),
                                          decoration: BoxDecoration(
                                            color: AppTheme.storyRed,
                                            borderRadius: BorderRadius.circular(16),
                                          ),
                                          child: Text('下联', 
                                            style: TextStyle(fontSize: 14, color: Colors.white, fontWeight: FontWeight.bold)),
                                        ),
                                        const SizedBox(height: 12),
                                        TextField(
                                          controller: _lowerController,
                                          textAlign: TextAlign.center,
                                          style: AppTheme.coupletStyle,
                                          maxLines: 2,
                                          decoration: const InputDecoration(
                                            border: InputBorder.none,
                                            isDense: true,
                                          ),
                                        ),
                                        Container(
                                          decoration: BoxDecoration(
                                            shape: BoxShape.circle,
                                            border: Border.all(color: AppTheme.imperialGold, width: 1),
                                            color: Colors.white,
                                          ),
                                          child: IconButton(
                                            icon: Icon(Icons.content_copy, color: AppTheme.storyRed),
                                            onPressed: () {
                                              Clipboard.setData(ClipboardData(
                                                text: _lowerController.text
                                              ));
                                              ScaffoldMessenger.of(context).showSnackBar(
                                                SnackBar(
                                                  content: Text('下联已复制到剪贴板'),
                                                  backgroundColor: AppTheme.storyRed,
                                                )
                                              );
                                            },
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                ),
                            ],
                          ),
                          
                          const SizedBox(height: 16),
                          
                          // 复制全部按钮
                          SizedBox(
                            width: double.infinity,
                            child: Container(
                              margin: const EdgeInsets.only(top: 8),
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(8),
                                boxShadow: [
                                  BoxShadow(
                                    color: AppTheme.inkBlack.withOpacity(0.1),
                                    blurRadius: 4,
                                    offset: const Offset(0, 2),
                                  ),
                                ],
                              ),
                              child: OutlinedButton.icon(
                                icon: Icon(Icons.copy_all, color: AppTheme.imperialGold),
                                label: Text('复制全部', style: TextStyle(fontFamily: 'FZLTH', letterSpacing: 2)),
                                onPressed: () {
                                  final allText = '横批：${_horizontalController.text}\n'
                                      '上联：${_upperController.text}\n'
                                      '下联：${_lowerController.text}';
                                  Clipboard.setData(ClipboardData(text: allText));
                                  ScaffoldMessenger.of(context).showSnackBar(
                                    SnackBar(
                                      content: Text('春联已全部复制到剪贴板'),
                                      backgroundColor: AppTheme.storyRed,
                                    )
                                  );
                                },
                                style: AppTheme.outlinedButtonStyle,
                            ),
                          ),
                      )],
                      ),
                    ),
                  ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
