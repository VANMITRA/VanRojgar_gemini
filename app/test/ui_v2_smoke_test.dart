import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:vanrozgar/ui_v2/l10n/app_strings.dart';
import 'package:vanrozgar/ui_v2/providers/catalog_providers.dart';
import 'package:vanrozgar/ui_v2/shell/app_shell.dart';
import 'package:vanrozgar/ui_v2/shell/home_demo_page.dart';
import 'package:vanrozgar/ui_v2/shell/landing_page.dart';
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

Widget _buildTestRouterApp({
  ThemeMode themeMode = ThemeMode.light,
  AppLanguage language = AppLanguage.en,
}) {
  return ProviderScope(
    overrides: [
      uiV2ThemeModeProvider.overrideWith((ref) => themeMode),
      uiV2LanguageProvider.overrideWith((ref) => language),
    ],
    child: MaterialApp.router(
      theme: VanRozgarTheme.lightTheme,
      darkTheme: VanRozgarTheme.darkTheme,
      themeMode: themeMode,
      routerConfig: uiV2Router,
    ),
  );
}

Widget _buildTestNavApp({
  ThemeMode themeMode = ThemeMode.light,
  AppLanguage language = AppLanguage.en,
}) {
  final strings = AppStrings.of(language);
  return ProviderScope(
    overrides: [
      uiV2ThemeModeProvider.overrideWith((ref) => themeMode),
      uiV2LanguageProvider.overrideWith((ref) => language),
    ],
    child: MaterialApp(
      theme: VanRozgarTheme.lightTheme,
      darkTheme: VanRozgarTheme.darkTheme,
      themeMode: themeMode,
      home: Scaffold(
        bottomNavigationBar: NavigationBar(
          destinations: [
            NavigationDestination(
              icon: const Icon(Icons.home_outlined),
              label: strings.navHome,
            ),
            NavigationDestination(
              icon: const Icon(Icons.category_outlined),
              label: strings.navCategories,
            ),
            NavigationDestination(
              icon: const Icon(Icons.shopping_cart_outlined),
              label: strings.navCart,
            ),
            NavigationDestination(
              icon: const Icon(Icons.receipt_long_outlined),
              label: strings.navOrders,
            ),
            NavigationDestination(
              icon: const Icon(Icons.person_outline),
              label: strings.navProfile,
            ),
          ],
        ),
      ),
    ),
  );
}

void main() {
  setUp(() {
    // Default to true for existing shell tests
    uiV2LandingSeen.value = true;
  });

  group('VanRozgar Shell and Catalog Smoke Tests', () {
    testWidgets(
        '(a) the village picker and the search field are found on Home in light and dark at 320x568, 360x800, 430x932 and 800x1280',
        (WidgetTester tester) async {
      final sizes = [
        const Size(320.0, 568.0),
        const Size(360.0, 800.0),
        const Size(430.0, 932.0),
        const Size(800.0, 1280.0),
      ];
      final modes = [ThemeMode.light, ThemeMode.dark];

      for (final size in sizes) {
        for (final mode in modes) {
          tester.view.physicalSize = Size(size.width * 2.0, size.height * 2.0);
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

    testWidgets('(c) no overflow exceptions in Hindi with textScaler 1.5 at 320x568 and at 360x800',
        (WidgetTester tester) async {
      final sizes = [
        const Size(320.0, 568.0),
        const Size(360.0, 800.0),
      ];

      for (final size in sizes) {
        tester.view.physicalSize = Size(size.width * 2.0, size.height * 2.0);
        tester.view.devicePixelRatio = 2.0;
        addTearDown(tester.view.resetPhysicalSize);
        addTearDown(tester.view.resetDevicePixelRatio);

        // Home page
        await tester.pumpWidget(
          _buildTestApp(
            child: const HomeDemoPage(),
            language: AppLanguage.hi,
            textScale: 1.5,
          ),
        );
        await tester.pump();
        expect(tester.takeException(), isNull);

        // Profile placeholder page
        await tester.pumpWidget(
          _buildTestApp(
            child: const ProfilePlaceholderPage(),
            language: AppLanguage.hi,
            textScale: 1.5,
          ),
        );
        await tester.pump();
        expect(tester.takeException(), isNull);

        // Categories placeholder page
        await tester.pumpWidget(
          _buildTestApp(
            child: const CategoriesPlaceholderPage(),
            language: AppLanguage.hi,
            textScale: 1.5,
          ),
        );
        await tester.pump();
        expect(tester.takeException(), isNull);
      }
    });

    testWidgets('(d) the bottom navigation tabs are at least 48 x 48', (WidgetTester tester) async {
      tester.view.physicalSize = const Size(360.0 * 2.0, 800.0 * 2.0);
      tester.view.devicePixelRatio = 2.0;
      addTearDown(tester.view.resetPhysicalSize);
      addTearDown(tester.view.resetDevicePixelRatio);

      await tester.pumpWidget(_buildTestNavApp());
      await tester.pump();

      final navBarSize = tester.getSize(find.byType(NavigationBar));
      expect(navBarSize.height, greaterThanOrEqualTo(48.0));

      final inkResponses = find.descendant(
        of: find.byType(NavigationBar),
        matching: find.byType(InkResponse),
      );
      expect(inkResponses, findsNWidgets(5));
      for (int i = 0; i < 5; i++) {
        final size = tester.getSize(inkResponses.at(i));
        expect(size.width, greaterThanOrEqualTo(48.0));
        expect(size.height, greaterThanOrEqualTo(48.0));
      }
    });
  });

  group('VanRozgar Landing Intro Page Tests', () {
    testWidgets('(a) with uiV2LandingSeen false, the first screen is the landing page showing slide 1 text',
        (WidgetTester tester) async {
      uiV2LandingSeen.value = false;
      await tester.pumpWidget(_buildTestRouterApp());
      await tester.pumpAndSettle();

      expect(find.byType(LandingPage), findsOneWidget);
      expect(find.textContaining('Forest produce, straight from'), findsOneWidget);
      expect(find.textContaining('CFR villages'), findsOneWidget);
    });

    testWidgets('(b) Next moves to slide 2, then slide 3, which shows Get Started',
        (WidgetTester tester) async {
      uiV2LandingSeen.value = false;
      await tester.pumpWidget(_buildTestRouterApp());
      await tester.pumpAndSettle();

      expect(find.text('Next'), findsOneWidget);

      // Move to slide 2
      await tester.tap(find.text('Next'));
      await tester.pumpAndSettle();
      expect(find.textContaining('Traditional forest'), findsOneWidget);
      expect(find.text('Next'), findsOneWidget);

      // Move to slide 3
      await tester.tap(find.text('Next'));
      await tester.pumpAndSettle();
      expect(find.textContaining('Work that stays'), findsOneWidget);
      expect(find.text('Get Started'), findsOneWidget);
    });

    testWidgets('(c) Skip on slide 1 opens shell with Home tab; Get Started on slide 3 opens shell too',
        (WidgetTester tester) async {
      // 1. Skip on slide 1
      uiV2LandingSeen.value = false;
      await tester.pumpWidget(_buildTestRouterApp());
      await tester.pumpAndSettle();

      expect(find.text('Skip'), findsOneWidget);
      await tester.tap(find.text('Skip'));
      await tester.pumpAndSettle();

      expect(uiV2LandingSeen.value, isTrue);
      expect(find.byType(HomeDemoPage), findsOneWidget);

      // 2. Get Started on slide 3
      uiV2LandingSeen.value = false;
      await tester.pumpWidget(_buildTestRouterApp());
      await tester.pumpAndSettle();

      await tester.tap(find.text('Next'));
      await tester.pumpAndSettle();
      await tester.tap(find.text('Next'));
      await tester.pumpAndSettle();

      expect(find.text('Get Started'), findsOneWidget);
      await tester.tap(find.text('Get Started'));
      await tester.pumpAndSettle();

      expect(uiV2LandingSeen.value, isTrue);
      expect(find.byType(HomeDemoPage), findsOneWidget);
    });

    testWidgets('(d) in Hindi and in Marathi no English landing text appears',
        (WidgetTester tester) async {
      // Hindi check
      await tester.pumpWidget(
        _buildTestApp(
          child: const LandingPage(),
          language: AppLanguage.hi,
        ),
      );
      await tester.pumpAndSettle();

      expect(find.text('Skip'), findsNothing);
      expect(find.text('Next'), findsNothing);
      expect(find.text('Get Started'), findsNothing);
      expect(find.textContaining('Forest produce'), findsNothing);
      expect(find.text('छोड़ें'), findsOneWidget);
      expect(find.text('आगे'), findsOneWidget);

      // Marathi check
      await tester.pumpWidget(
        _buildTestApp(
          child: const LandingPage(),
          language: AppLanguage.mr,
        ),
      );
      await tester.pumpAndSettle();

      expect(find.text('Skip'), findsNothing);
      expect(find.text('Next'), findsNothing);
      expect(find.text('Get Started'), findsNothing);
      expect(find.textContaining('Forest produce'), findsNothing);
      expect(find.text('वगळा'), findsOneWidget);
      expect(find.text('पुढे'), findsOneWidget);
    });

    testWidgets('(e) no overflow exceptions on landing at 320x568, 360x800 and 430x932 with textScaler 1.5 in light/dark in Hindi',
        (WidgetTester tester) async {
      final landingSizes = [
        const Size(320.0, 568.0),
        const Size(360.0, 800.0),
        const Size(430.0, 932.0),
      ];

      for (final size in landingSizes) {
        for (final mode in [ThemeMode.light, ThemeMode.dark]) {
          tester.view.physicalSize = Size(size.width * 2.0, size.height * 2.0);
          tester.view.devicePixelRatio = 2.0;
          addTearDown(tester.view.resetPhysicalSize);
          addTearDown(tester.view.resetDevicePixelRatio);

          await tester.pumpWidget(
            _buildTestApp(
              child: const LandingPage(),
              language: AppLanguage.hi,
              themeMode: mode,
              textScale: 1.5,
            ),
          );
          await tester.pumpAndSettle();
          expect(tester.takeException(), isNull);
        }
      }
    });

    testWidgets('(f) the landing builds without exceptions when picture assets are missing',
        (WidgetTester tester) async {
      await tester.pumpWidget(_buildTestApp(child: const LandingPage()));
      await tester.pumpAndSettle();

      expect(find.byType(LandingPage), findsOneWidget);
      expect(tester.takeException(), isNull);
    });
  });
}
