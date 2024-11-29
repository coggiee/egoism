import 'package:egoism/service/emotion_analysis_api.dart';
import 'package:flutter/cupertino.dart';

class EmotionAnalysisScreen extends StatefulWidget {
  const EmotionAnalysisScreen({super.key});

  @override
  // ignore: library_private_types_in_public_api
  _EmotionAnalysisScreenState createState() => _EmotionAnalysisScreenState();
}

class _EmotionAnalysisScreenState extends State<EmotionAnalysisScreen> {
  final TextEditingController _textController = TextEditingController();
  final EmotionAnalysisService _emotionService = EmotionAnalysisService();

  Map<String, dynamic> _emotionResult = {'label': 0, 'score': 0.0};

  Future<void> _analyzeText() async {
    if (_textController.text.isNotEmpty) {
      final result = await _emotionService.analyzeEmotion(_textController.text);
      setState(() {
        _emotionResult = result;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return CupertinoPageScaffold(
      navigationBar: const CupertinoNavigationBar(
        middle: Text('감정 분석'),
      ),
      child: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            children: [
              CupertinoTextField(
                controller: _textController,
                placeholder: '감정을 분석할 텍스트를 입력하세요',
                maxLines: 3,
              ),
              const SizedBox(height: 16),
              CupertinoButton.filled(
                onPressed: _analyzeText,
                child: const Text('감정 분석'),
              ),
              const SizedBox(height: 16),
              const Text(
                '분석 결과',
                style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
              ),
              const SizedBox(height: 8),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  Column(
                    children: [
                      const Text('라벨',
                          style: TextStyle(color: CupertinoColors.activeGreen)),
                      Text(_emotionResult['label'] == '0' ? '부정' : '긍정')
                    ],
                  ),
                  Column(
                    children: [
                      const Text('점수',
                          style:
                              TextStyle(color: CupertinoColors.destructiveRed)),
                      Text(_emotionResult['score'].toString())
                    ],
                  ),
                ],
              )
            ],
          ),
        ),
      ),
    );
  }
}
