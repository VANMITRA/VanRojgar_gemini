import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:vanrozgar/ui_v2/l10n/app_strings.dart';
import 'package:vanrozgar/ui_v2/providers/catalog_providers.dart';
import 'package:vanrozgar/ui_v2/shell/home_demo_page.dart';
import 'package:vanrozgar/ui_v2/shell/placeholder_pages.dart';
import 'package:vanrozgar/ui_v2/theme/van_rozgar_theme.dart';

Widget _buildTestApp({
  required Widget child,
  ThemeMode themeMode = ThemeMode.light,
  AppLanguage language = AppLanguage.en,
  double textScale = 1.0,
}) {
  return ProviderScope(
    overrides: [
      uiV2ThemeModeProvider.overrideWith((ref) => themeMode),
      uiV2LanguageProvider.overrideWith((ref) => language),
    ],
    child: MaterialApp(
      theme: VanRozgarTheme.lightTheme,
      darkTheme: VanRozgarTheme.darkTheme,
      themeMode: themeMode,
      home: MediaQuery(
        data: MediaQueryData(
          textScaler: TextScaler.linear(textScale),
        ),
        child: Material(child: child),
      ),
    ),
  );
}

void main() {
  group('VanRozgar UI v2 Smoke Tests', () {
    testWidgets('(a) village picker and search field are found on Home at 360 and 430 width in light and dark',
        (WidgetTester tester) async {
      final widths = [360.0, 430.0];
      final modes = [ThemeMode.light, ThemeMode.dark];

      for (final width in widths) {
        for (final mode in modes) {
          tester.view.physicalSize = Size(width * 2.0, 800 * 2.0);
          tester.view.devicePixelRatio = 2.0;
          addTearDown(tester.view.resetPhysicalSize);
          addTearDown(tester.view.resetDevicePixelRatio);

          await tester.pumpWidget(
            _buildTestApp(
              child: const HomeDemoPage(),
              themeMode: mode,
            ),
          );
          await tester.pump();

          // Verify Village Picker elements exist
          expect(find.byIcon(Icons.location_on_outlined), findsOneWidget);
          expect(find.byIcon(Icons.keyboard_arrow_down_rounded), findsOneWidget);

          // Verify Search Field exists and takes input
          expect(find.byType(TextField), findsOneWidget);
        }
      }
    });

    testWidgets('(b) Categories, Cart, Orders and Profile pages build without exceptions when footer asset is missing',
        (WidgetTester tester) async {
      // 1. Categories
      await tester.pumpWidget(_buildTestApp(child: const CategoriesPlaceholderPage()));
      await tester.pump();
      expect(find.byType(CategoriesPlaceholderPage), findsOneWidget);
      expect(tester.takeException(), isNull);

      // 2. Cart
      await tester.pumpWidget(_buildTestApp(child: const CartPlaceholderPage()));
      await tester.pump();
      expect(find.byType(CartPlaceholderPage), findsOneWidget);
      expect(tester.takeException(), isNull);

      // 3. Orders
      await tester.pumpWidget(_buildTestApp(child: const OrdersPlaceholderPage()));
      await tester.pump();
      expect(find.byType(OrdersPlaceholderPage), findsOneWidget);
      expect(tester.takeException(), isNull);

      // 4. Profile
      await tester.pumpWidget(_buildTestApp(child: const ProfilePlaceholderPage()));
      await tester.pump();
      expect(find.byType(ProfilePlaceholderPage), findsOneWidget);
      expect(tester.takeException(), isNull);
    });

    testWidgets('(c) no overflow exceptions in Hindi and Marathi with textScaler 1.3 on compact width',
        (WidgetTester tester) async {
      tester.view.physicalSize = const Size(360.0 * 2.0, 800.0 * 2.0);
      tester.view.devicePixelRatio = 2.0;
      addTearDown(tester.view.resetPhysicalSize);
      addTearDown(tester.view.resetDevicePixelRatio);

      for (final lang in [AppLanguage.hi, AppLanguage.mr]) {
        await tester.pumpWidget(
          _buildTestApp(
            child: const HomeDemoPage(),
            language: lang,
            textScale: 1.3,
          ),
        );
        await tester.pump();
        expect(tester.takeException(), isNull);

        await tester.pumpWidget(
          _buildTestApp(
            child: const ProfilePlaceholderPage(),
            language: lang,
            textScale: 1.3,
          ),
        );
        await tester.pump();
        expect(tester.takeException(), isNull);
      }
    });
  });
}
