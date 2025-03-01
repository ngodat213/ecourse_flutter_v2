import 'package:easy_localization/easy_localization.dart';
import 'package:ecourse_flutter_v2/utils/responsive_layout.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:provider/provider.dart';
import 'core/providers/theme_provider.dart';
import 'core/routes/app_routes.dart';
import 'core/routes/route_guard.dart';
import 'core/services/shared_prefs.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await EasyLocalization.ensureInitialized();
  await SharedPrefs.init();

  runApp(
    EasyLocalization(
      supportedLocales: const [Locale('en'), Locale('vi')],
      path: 'assets/translations',
      fallbackLocale: const Locale('en'),
      child: const MyApp(),
    ),
  );
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(
          create: (_) => ThemeProvider(SharedPrefs.getThemeMode(), context),
        ),
      ],
      child: ScreenUtilInit(
        designSize:
            ResponsiveLayout.isDesktop(context)
                ? const Size(1920, 1080)
                : const Size(360, 800),
        builder:
            (_, __) => Consumer<ThemeProvider>(
              builder: (context, themeProvider, _) {
                return MaterialApp(
                  title: 'ECourse'.tr(),
                  debugShowCheckedModeBanner: false,
                  localizationsDelegates: context.localizationDelegates,
                  supportedLocales: context.supportedLocales,
                  locale: context.locale,
                  themeMode: themeProvider.themeMode,
                  theme: themeProvider.lightTheme,
                  darkTheme: themeProvider.darkTheme,
                  initialRoute: AppRoutes.splash,
                  routes: AppRoutes.getRoutes(),
                  navigatorObservers: [RouteGuard()],
                );
              },
            ),
      ),
    );
  }
}
