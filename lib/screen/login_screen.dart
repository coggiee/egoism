import 'package:flutter/cupertino.dart';
import 'package:go_router/go_router.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:egoism/main.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  @override
  void initState() {
    _setupAuthListener();
    super.initState();
  }

  void _setupAuthListener() {
    supabase.auth.onAuthStateChange.listen((data) {
      final event = data.event;
      if (event == AuthChangeEvent.signedIn) {
        context.go('/profile');
      }
    });
  }

  Future<AuthResponse> _googleSignIn() async {
    /// Web Client ID that you registered with Google Cloud.
    const webClientId =
        '461880774278-gc4lm6rb791es036vjefafkrl38nqm41.apps.googleusercontent.com';

    /// iOS Client ID that you registered with Google Cloud.
    const iosClientId =
        '461880774278-dd40ri26nh6bn5qfqttqqhiptnofpmmm.apps.googleusercontent.com';

    // Google sign in on Android will work without providing the Android
    // Client ID registered on Google Cloud.

    final GoogleSignIn googleSignIn = GoogleSignIn(
      clientId: iosClientId,
      serverClientId: webClientId,
    );
    final googleUser = await googleSignIn.signIn();
    final googleAuth = await googleUser?.authentication;
    final accessToken = googleAuth?.accessToken;
    final idToken = googleAuth?.idToken;

    if (accessToken == null) {
      throw 'No Access Token found.';
    }
    if (idToken == null) {
      throw 'No ID Token found.';
    }

    return supabase.auth.signInWithIdToken(
      provider: OAuthProvider.google,
      idToken: idToken,
      accessToken: accessToken,
    );
  }

  @override
  Widget build(BuildContext context) {
    return CupertinoPageScaffold(
      navigationBar: const CupertinoNavigationBar(
        middle: Text('로그인'),
        automaticallyImplyLeading: true,
      ),
      child: Center(
        child: CupertinoButton.filled(
          onPressed: _googleSignIn,
          child: const Text('Google 로그인'),
        ),
      ),
    );
  }
}
