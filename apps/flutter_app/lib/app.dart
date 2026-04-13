import 'package:flutter/material.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import 'core/router/app_router.dart';
import 'core/theme/z_theme.dart';
import 'shared/providers/locale_provider.dart';

class VidyaLaxmiApp extends ConsumerWidget {
  const VidyaLaxmiApp({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final router = ref.watch(appRouterProvider);
    final locale = ref.watch(localeProvider);

    return MaterialApp.router(
      title: 'VidyaLaxmi',
      debugShowCheckedModeBanner: false,
      theme: ZTheme.dark(),
      routerConfig: router,
      locale: locale,
      supportedLocales: const [
        Locale('en'),
        Locale('te'),
        Locale('hi'),
      ],
      localizationsDelegates: const [
        GlobalMaterialLocalizations.delegate,
        GlobalWidgetsLocalizations.delegate,
        GlobalCupertinoLocalizations.delegate,
      ],
    );
  }
}
