import 'dart:convert';
import 'package:http/http.dart' as http;

class CoupletService {
  final String baseUrl = 'https://openrouter.ai/api/v1/chat/completions';
  String? apiKey; // 用户需要提供自己的API密钥

  CoupletService({this.apiKey});

  /// 设置API密钥
  void setApiKey(String key) {
    apiKey = key;
  }

  /// 根据主题生成春联
  Future<Map<String, String>> generateCouplet(String theme) async {
    if (apiKey == null || apiKey!.isEmpty) {
      throw Exception('请先设置OpenRouter API密钥');
    }

    final response = await http.post(
      Uri.parse(baseUrl),
      headers: {
        'Content-Type': 'application/json',
        'Authorization': 'Bearer $apiKey',
      },
      body: jsonEncode({
        'model': 'deepseek/deepseek-r1:free',
        'messages': [
          {
            'role': 'user',
            'content': [
              {
                'type': 'text',
                'text': '请根据主题"$theme"生成一副春联，包含上联、下联和横批。格式要求：返回JSON格式，包含三个字段：upper（上联）、lower（下联）和horizontal（横批）。上下联要求字数相同，平仄相对，意境优美。'
              }
            ]
          }
        ]
      }),
    );

    if (response.statusCode == 200) {
      final data = jsonDecode(response.body);
      try {
        // 解析AI返回的内容
        final content = data['choices'][0]['message']['content'];
        print('API返回内容: $content'); // 调试输出，查看原始内容
        
        // 尝试从内容中提取JSON
        final jsonStart = content.indexOf('{');
        final jsonEnd = content.lastIndexOf('}') + 1;
        if (jsonStart >= 0 && jsonEnd > jsonStart) {
          final jsonStr = content.substring(jsonStart, jsonEnd);
          print('提取的JSON字符串: $jsonStr'); // 调试输出，查看提取的JSON
          
          // 确保JSON字符串是有效的UTF-8编码
          final validJsonStr = _ensureValidUtf8(jsonStr);
          final couplet = jsonDecode(validJsonStr);
          
          // 确保返回的字符串是有效的UTF-8编码
          return {
            'upper': _ensureValidUtf8(couplet['upper'] ?? ''),
            'lower': _ensureValidUtf8(couplet['lower'] ?? ''),
            'horizontal': _ensureValidUtf8(couplet['horizontal'] ?? ''),
          };
        } else {
          print('未找到JSON格式内容，尝试从文本中提取'); // 调试输出
          // 如果无法解析JSON，尝试从文本中提取
          final lines = content.split('\n');
          String upper = '', lower = '', horizontal = '';
          for (final line in lines) {
            if (line.contains('上联') || line.contains('上联：')) {
              upper = line.replaceAll(RegExp(r'上联[：:]*\s*'), '');
            } else if (line.contains('下联') || line.contains('下联：')) {
              lower = line.replaceAll(RegExp(r'下联[：:]*\s*'), '');
            } else if (line.contains('横批') || line.contains('横批：')) {
              horizontal = line.replaceAll(RegExp(r'横批[：:]*\s*'), '');
            }
          }
          
          // 确保返回的字符串是有效的UTF-8编码
          return {
            'upper': _ensureValidUtf8(upper),
            'lower': _ensureValidUtf8(lower),
            'horizontal': _ensureValidUtf8(horizontal),
          };
        }
      } catch (e) {
        throw Exception('解析春联数据失败: $e');
      }
    } else {
      throw Exception('生成春联失败: ${response.statusCode} ${response.body}');
    }
  }

  /// 确保字符串是有效的UTF-8编码
  String _ensureValidUtf8(String text) {
    if (text.isEmpty) return text;
    
    try {
      // 检查是否包含乱码特征（如æ开头的字符）
      if (text.contains('æ') || text.contains('ç') || text.contains('å')) {
        print('检测到可能的编码问题，尝试修复...');
        // 尝试使用Latin-1编码解析，然后再转为UTF-8
        // 这是因为有些API返回的数据可能是UTF-8编码被错误地以Latin-1解析
        List<int> bytes = [];
        for (int i = 0; i < text.length; i++) {
          bytes.add(text.codeUnitAt(i));
        }
        return utf8.decode(bytes, allowMalformed: true);
      }
      
      // 标准UTF-8处理
      final encoded = utf8.encode(text);
      return utf8.decode(encoded);
    } catch (e) {
      print('字符编码处理错误: $e');
      // 尝试更强力的修复方法
      try {
        // 尝试使用Latin-1编码解析
        List<int> bytes = [];
        for (int i = 0; i < text.length; i++) {
          bytes.add(text.codeUnitAt(i));
        }
        return utf8.decode(bytes, allowMalformed: true);
      } catch (e2) {
        print('强力修复失败: $e2');
        // 如果所有方法都失败，尝试移除无效字符
        final cleanedText = text.runes
            .map((rune) {
              try {
                return String.fromCharCode(rune);
              } catch (e) {
                return '';
              }
            })
            .join();
        return cleanedText;
      }
    }
  }
}