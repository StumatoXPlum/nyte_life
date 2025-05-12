import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'screens/auth/sign_up_screen.dart/sign_up_screen.dart';
import 'screens/user_onboarding/cubit/on_boarding_cubit.dart';
import 'core/constants.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Supabase.initialize(
    url: AppSecrets.supabaseUrl,
    anonKey: AppSecrets.anonKey,
  );
  runApp(
    BlocProvider(create: (context) => OnboardingCubit(), child: const MyApp()),
  );
  SystemChrome.setEnabledSystemUIMode(SystemUiMode.immersiveSticky);
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return ScreenUtilInit(
      designSize: const Size(390, 844),
      minTextAdapt: true,
      splitScreenMode: true,
      builder:
          (context, child) => MaterialApp(
            debugShowCheckedModeBanner: false,
            title: 'NyteLife',
            home: SignUpScreen(),
          ),
    );
  }

  // Widget _getInitialScreen() {
  //   final user = Supabase.instance.client.auth.currentUser;
  //   return user != null ? CustomBottomBar() : SignUpScreen();
  // }
}
