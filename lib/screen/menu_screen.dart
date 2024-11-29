import 'package:flutter/cupertino.dart';
import 'package:go_router/go_router.dart';

class MenuScreen extends StatelessWidget {
  const MenuScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return CupertinoPageScaffold(
      navigationBar: const CupertinoNavigationBar(
        middle: Text('메뉴 선택'),
      ),
      child: SafeArea(
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              CupertinoButton(
                onPressed: () {
                  context.push('/login');
                },
                child: const Text('supabase 로그인'),
              ),
              CupertinoButton(
                onPressed: () {
                  context.push('/emotion');
                },
                child: const Text('감정 분석'),
              ),
              CupertinoButton(
                onPressed: () {
                  context.push('/animation');
                },
                child: const Text('애니메이션'),
              )
            ],
          ),
        ),
      ),
    );
  }
}
