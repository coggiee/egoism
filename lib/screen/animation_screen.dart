import 'package:flutter/cupertino.dart';

class AnimationScreen extends StatelessWidget {
  const AnimationScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return const CupertinoPageScaffold(
      navigationBar: CupertinoNavigationBar(
        middle: Text('애니메이션'),
        automaticallyImplyLeading: true,
      ),
      child: Center(
        child: Text('Animation'),
      ),
    );
  }
}
