import 'package:egoism/service/router.dart';
import 'package:egoism/service/secure_storage.dart';
import 'package:flutter/cupertino.dart';
import 'package:supabase_flutter/supabase_flutter.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();

  await dotenv.load(fileName: ".env");
  await Supabase.initialize(
    url: dotenv.env['SUPABASE_URL']!,
    anonKey: dotenv.env['SUPABASE_ANON_KEY']!,
    authOptions: FlutterAuthClientOptions(
      autoRefreshToken: true,
      localStorage: MySecureStorage(),
    ),
  );

  runApp(const MyApp());
}

final supabase = Supabase.instance.client;

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return CupertinoApp.router(
      routerConfig: CustomRouter.router,
      debugShowCheckedModeBanner: false,
      title: 'Flutter Example',
    );
  }
}
