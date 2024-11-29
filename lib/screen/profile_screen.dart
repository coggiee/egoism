import 'package:flutter/cupertino.dart';
import 'package:egoism/main.dart';
import 'package:go_router/go_router.dart';

class ProfileScreen extends StatelessWidget {
  const ProfileScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final user = supabase.auth.currentUser;
    final profileImageUrl = user?.userMetadata?['avatar_url'];
    final fullName = user?.userMetadata?['full_name'];

    return CupertinoPageScaffold(
      navigationBar: CupertinoNavigationBar(
        middle: const Text('Profile'),
        trailing: CupertinoButton(
          padding: EdgeInsets.zero,
          onPressed: () async {
            await supabase.auth.signOut();
            if (context.mounted) {
              context.go('/');
            }
          },
          child: const Text('Sign out'),
        ),
      ),
      child: SafeArea(
        child: Center(
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              if (profileImageUrl != null)
                ClipOval(
                  child: Image.network(
                    profileImageUrl,
                    width: 100,
                    height: 100,
                    fit: BoxFit.cover,
                  ),
                ),
              const SizedBox(height: 16),
              Text(
                fullName ?? '',
                style:
                    CupertinoTheme.of(context).textTheme.navLargeTitleTextStyle,
              ),
              const SizedBox(height: 32),
            ],
          ),
        ),
      ),
    );
  }
}
