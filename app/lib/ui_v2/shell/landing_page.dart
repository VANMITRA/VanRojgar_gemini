import 'dart:math' as math;
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import '../l10n/app_strings.dart';
import '../providers/catalog_providers.dart';
import '../theme/van_rozgar_tokens.dart';
import 'app_shell.dart';

/// The 3-slide introductory landing screen for VanRozgar.
///
/// Introduces CFR produce with swipeable illustrated slides before transitioning
/// to the guest catalog shop.
class LandingPage extends ConsumerStatefulWidget {
  const LandingPage({super.key});

  @override
  ConsumerState<LandingPage> createState() => _LandingPageState();
}

class _LandingPageState extends ConsumerState<LandingPage> {
  final PageController _pageController = PageController();
  int _currentPage = 0;

  @override
  void dispose() {
    _pageController.dispose();
    super.dispose();
  }

  void _finishLanding() {
    uiV2LandingSeen.value = true;
    if (mounted) {
      context.go('/');
    }
  }

  void _handleNext() {
    if (_currentPage < 2) {
      if (MediaQuery.disableAnimationsOf(context)) {
        _pageController.jumpToPage(_currentPage + 1);
      } else {
        _pageController.animateToPage(
          _currentPage + 1,
          duration: const Duration(milliseconds: 300),
          curve: Curves.easeInOut,
        );
      }
    } else {
      _finishLanding();
    }
  }

  void _handleBack() {
    if (_currentPage > 0) {
      if (MediaQuery.disableAnimationsOf(context)) {
        _pageController.jumpToPage(_currentPage - 1);
      } else {
        _pageController.animateToPage(
          _currentPage - 1,
          duration: const Duration(milliseconds: 300),
          curve: Curves.easeInOut,
        );
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    final language = ref.watch(uiV2LanguageProvider);
    final strings = AppStrings.of(language);
    final theme = Theme.of(context);
    final isDark = theme.brightness == Brightness.dark;
    final tokens = theme.extension<VanRozgarColorTokens>() ??
        (isDark ? VanRozgarColorTokens.dark : VanRozgarColorTokens.light);

    return PopScope(
      canPop: _currentPage == 0,
      onPopInvokedWithResult: (didPop, result) {
        if (!didPop && _currentPage > 0) {
          _handleBack();
        }
      },
      child: Scaffold(
        backgroundColor: tokens.page,
        body: SafeArea(
          child: Column(
            children: [
              // 1. Top Bar: Language Chips (Left) & Skip Text Button (Right)
              _buildTopBar(context, language, strings, tokens),

              // 2. Main Slide Body (PageView with 3 slides)
              Expanded(
                child: PageView(
                  controller: _pageController,
                  physics: const BouncingScrollPhysics(),
                  onPageChanged: (index) {
                    setState(() {
                      _currentPage = index;
                    });
                  },
                  children: [
                    // Slide 1: pictures on LEFT, text on RIGHT
                    _LandingSlide(
                      slideIndex: 0,
                      isMirrored: false,
                      lead: strings.landingSlide1Lead,
                      highlight: strings.landingSlide1Highlight,
                      tail: strings.landingSlide1Tail,
                      subtitle: strings.landingSlide1Subtitle,
                      pictureLabel: strings.landingSlide1PictureLabel,
                      topAsset: VanRozgarTokens.landingSlide1Top,
                      bottomAsset: VanRozgarTokens.landingSlide1Bottom,
                      tokens: tokens,
                    ),

                    // Slide 2: text on LEFT, pictures on RIGHT (mirrored)
                    _LandingSlide(
                      slideIndex: 1,
                      isMirrored: true,
                      lead: strings.landingSlide2Lead,
                      highlight: strings.landingSlide2Highlight,
                      tail: strings.landingSlide2Tail,
                      subtitle: strings.landingSlide2Subtitle,
                      pictureLabel: strings.landingSlide2PictureLabel,
                      topAsset: VanRozgarTokens.landingSlide2Top,
                      bottomAsset: VanRozgarTokens.landingSlide2Bottom,
                      tokens: tokens,
                    ),

                    // Slide 3: pictures on LEFT, text on RIGHT
                    _LandingSlide(
                      slideIndex: 2,
                      isMirrored: false,
                      lead: strings.landingSlide3Lead,
                      highlight: strings.landingSlide3Highlight,
                      tail: strings.landingSlide3Tail,
                      subtitle: strings.landingSlide3Subtitle,
                      pictureLabel: strings.landingSlide3PictureLabel,
                      topAsset: VanRozgarTokens.landingSlide3Top,
                      bottomAsset: VanRozgarTokens.landingSlide3Bottom,
                      tokens: tokens,
                    ),
                  ],
                ),
              ),

              // 3. Bottom Bar: Page Indicator Dots (Left) & Next/Get Started Button (Right)
              _buildBottomBar(context, strings, tokens),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildTopBar(
    BuildContext context,
    AppLanguage currentLanguage,
    AppStrings strings,
    VanRozgarColorTokens tokens,
  ) {
    return Padding(
      padding: const EdgeInsets.symmetric(
        horizontal: VanRozgarTokens.space16,
        vertical: VanRozgarTokens.space4,
      ),
      child: SizedBox(
        height: VanRozgarTokens.minTouchTarget,
        child: Row(
          children: [
            // Left: Language Selector Chips
            Expanded(
              child: Align(
                alignment: Alignment.centerLeft,
                child: FittedBox(
                  fit: BoxFit.scaleDown,
                  alignment: Alignment.centerLeft,
                  child: Row(
                    mainAxisSize: MainAxisSize.min,
                    children: AppLanguage.values.map((lang) {
                      final isSelected = lang == currentLanguage;
                      return Padding(
                        padding: const EdgeInsets.only(right: 6.0),
                        child: Semantics(
                          button: true,
                          selected: isSelected,
                          label: lang.nativeLabel,
                          child: InkWell(
                            onTap: () {
                              ref.read(uiV2LanguageProvider.notifier).state = lang;
                            },
                            borderRadius: VanRozgarTokens.borderPill,
                            child: Container(
                              constraints: const BoxConstraints(
                                minHeight: VanRozgarTokens.minTouchTarget,
                                minWidth: 48.0,
                              ),
                              alignment: Alignment.center,
                              padding: const EdgeInsets.symmetric(
                                horizontal: 10.0,
                                vertical: 6.0,
                              ),
                              decoration: BoxDecoration(
                                color: isSelected ? tokens.primaryGreen : tokens.chipBg,
                                borderRadius: VanRozgarTokens.borderPill,
                                border: Border.all(
                                  color: isSelected ? tokens.primaryGreen : tokens.borders,
                                  width: 1.0,
                                ),
                              ),
                              child: Text(
                                lang.nativeLabel,
                                style: TextStyle(
                                  fontSize: 12.0,
                                  fontWeight: isSelected ? FontWeight.w700 : FontWeight.w600,
                                  color: isSelected ? tokens.onPrimaryGreen : tokens.heading,
                                ),
                              ),
                            ),
                          ),
                        ),
                      );
                    }).toList(),
                  ),
                ),
              ),
            ),

            // Right: Skip Text Button
            Semantics(
              button: true,
              label: strings.landingSkip,
              child: TextButton(
                onPressed: _finishLanding,
                style: TextButton.styleFrom(
                  foregroundColor: tokens.mutedText,
                  minimumSize: const Size(48.0, VanRozgarTokens.minTouchTarget),
                  padding: const EdgeInsets.symmetric(horizontal: VanRozgarTokens.space12),
                ),
                child: Text(
                  strings.landingSkip,
                  style: const TextStyle(
                    fontWeight: FontWeight.w600,
                    fontSize: 14.0,
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildBottomBar(
    BuildContext context,
    AppStrings strings,
    VanRozgarColorTokens tokens,
  ) {
    final isLastSlide = _currentPage == 2;
    final buttonLabel = isLastSlide ? strings.landingGetStarted : strings.landingNext;

    return Padding(
      padding: const EdgeInsets.symmetric(
        horizontal: VanRozgarTokens.space20,
        vertical: VanRozgarTokens.space12,
      ),
      child: SizedBox(
        height: VanRozgarTokens.minTouchTarget,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            // Left: 3 Page Indicator Dots
            Row(
              mainAxisSize: MainAxisSize.min,
              children: List.generate(3, (index) {
                final isActive = index == _currentPage;
                return Semantics(
                  label: strings.landingSlideDotLabel(index + 1, 3),
                  child: AnimatedContainer(
                    duration: const Duration(milliseconds: 250),
                    curve: Curves.easeInOut,
                    margin: const EdgeInsets.only(right: 6.0),
                    width: isActive ? 24.0 : 8.0,
                    height: 8.0,
                    decoration: BoxDecoration(
                      color: isActive ? tokens.primaryGreen : tokens.chipBg,
                      borderRadius: BorderRadius.circular(4.0),
                    ),
                  ),
                );
              }),
            ),

            // Right: Next / Get Started Pill Button
            ConstrainedBox(
              constraints: const BoxConstraints(minHeight: VanRozgarTokens.minTouchTarget),
              child: FilledButton(
                onPressed: _handleNext,
                style: FilledButton.styleFrom(
                  backgroundColor: tokens.primaryGreen,
                  foregroundColor: tokens.onPrimaryGreen,
                  shape: const RoundedRectangleBorder(
                    borderRadius: VanRozgarTokens.borderPill,
                  ),
                  padding: const EdgeInsets.symmetric(
                    horizontal: VanRozgarTokens.space20,
                    vertical: 12.0,
                  ),
                  minimumSize: const Size(0, VanRozgarTokens.minTouchTarget),
                ),
                child: Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Text(
                      buttonLabel,
                      style: const TextStyle(
                        fontWeight: FontWeight.w700,
                        fontSize: 15.0,
                      ),
                    ),
                    const SizedBox(width: VanRozgarTokens.space8),
                    const Icon(Icons.arrow_forward_rounded, size: 18.0),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

/// A single slide inside the Landing Page PageView.
class _LandingSlide extends StatelessWidget {
  final int slideIndex;
  final bool isMirrored;
  final String lead;
  final String highlight;
  final String tail;
  final String subtitle;
  final String pictureLabel;
  final String topAsset;
  final String bottomAsset;
  final VanRozgarColorTokens tokens;

  const _LandingSlide({
    required this.slideIndex,
    required this.isMirrored,
    required this.lead,
    required this.highlight,
    required this.tail,
    required this.subtitle,
    required this.pictureLabel,
    required this.topAsset,
    required this.bottomAsset,
    required this.tokens,
  });

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (context, constraints) {
        final availableWidth = constraints.maxWidth;
        final availableHeight = constraints.maxHeight;

        final pictureWidth = availableWidth * 0.46;
        final textWidth = availableWidth * 0.50;
        final gapWidth = availableWidth * 0.04;

        final pictureWidget = SizedBox(
          width: pictureWidth,
          height: availableHeight,
          child: _buildPictureSide(context, pictureWidth, availableHeight),
        );

        final textWidget = SizedBox(
          width: textWidth,
          height: availableHeight,
          child: _buildTextSide(context, textWidth, availableHeight),
        );

        return Padding(
          padding: const EdgeInsets.symmetric(horizontal: VanRozgarTokens.space16),
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: isMirrored
                ? [textWidget, SizedBox(width: gapWidth), pictureWidget]
                : [pictureWidget, SizedBox(width: gapWidth), textWidget],
          ),
        );
      },
    );
  }

  Widget _buildTextSide(
    BuildContext context,
    double width,
    double height,
  ) {
    final theme = Theme.of(context);
    final screenWidth = MediaQuery.sizeOf(context).width;
    final headlineFontSize = (screenWidth * 0.085).clamp(22.0, 34.0);

    return Center(
      child: SingleChildScrollView(
        physics: const BouncingScrollPhysics(),
        padding: const EdgeInsets.symmetric(vertical: VanRozgarTokens.space8),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisSize: MainAxisSize.min,
          children: [
            // Headline with highlight phrase
            Text.rich(
              TextSpan(
                style: theme.textTheme.headlineMedium?.copyWith(
                  fontSize: headlineFontSize,
                  fontWeight: FontWeight.w800,
                  color: tokens.heading,
                  height: 1.2,
                  letterSpacing: -0.2,
                ),
                children: [
                  TextSpan(text: lead),
                  TextSpan(
                    text: highlight,
                    style: TextStyle(
                      color: tokens.primaryGreen,
                      fontWeight: FontWeight.w800,
                    ),
                  ),
                  if (tail.isNotEmpty) TextSpan(text: tail),
                ],
              ),
              textAlign: TextAlign.start,
            ),

            const SizedBox(height: VanRozgarTokens.space12),

            // Subtitle
            Text(
              subtitle,
              textAlign: TextAlign.start,
              style: theme.textTheme.bodyMedium?.copyWith(
                color: tokens.bodyText,
                fontSize: 14.0,
                height: 1.45,
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildPictureSide(
    BuildContext context,
    double availableWidth,
    double availableHeight,
  ) {
    final double initialCardWidth = (availableWidth - 8.0) / 1.14;
    final double cardHeight = math.min(
      initialCardWidth * 1.5,
      math.min(availableHeight * 0.56, availableHeight * 0.50),
    );
    final double cardWidth = cardHeight / 1.5;

    final double totalStackHeight = cardHeight + (cardHeight * 0.88);
    final double topOffset = math.max(0.0, (availableHeight - totalStackHeight) / 2.0);

    // Shifts and rotations
    // Mirror slide 2: first card +3 deg, second -3 deg; shift toward text side (left)
    final double card1Angle = isMirrored ? (3.0 * math.pi / 180.0) : (-3.0 * math.pi / 180.0);
    final double card2Angle = isMirrored ? (-3.0 * math.pi / 180.0) : (3.0 * math.pi / 180.0);

    final double card1Left = isMirrored ? (cardWidth * 0.14) : 0.0;
    final double card2Left = isMirrored ? 0.0 : (cardWidth * 0.14);

    return Semantics(
      label: pictureLabel,
      child: Center(
        child: SizedBox(
          width: cardWidth * 1.15 + 8.0,
          height: availableHeight,
          child: Stack(
            alignment: Alignment.center,
            children: [
              // Pale-green rounded background shape behind cards
              Positioned(
                top: topOffset,
                child: Container(
                  width: cardWidth * 1.16,
                  height: totalStackHeight,
                  decoration: BoxDecoration(
                    color: tokens.chipBg.withValues(alpha: 0.7),
                    borderRadius: BorderRadius.circular(28.0),
                  ),
                ),
              ),

              // Card 1 (Top)
              Positioned(
                top: topOffset,
                left: card1Left,
                child: Transform.rotate(
                  angle: card1Angle,
                  child: _PictureCard(
                    assetPath: topAsset,
                    width: cardWidth,
                    height: cardHeight,
                    tokens: tokens,
                  ),
                ),
              ),

              // Card 2 (Bottom - overlaps Card 1 by ~12% height and shifts 14% toward text side)
              Positioned(
                top: topOffset + (cardHeight * 0.88),
                left: card2Left,
                child: Transform.rotate(
                  angle: card2Angle,
                  child: _PictureCard(
                    assetPath: bottomAsset,
                    width: cardWidth,
                    height: cardHeight,
                    tokens: tokens,
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

/// Single decorated picture card with aspect ratio 2:3 and graceful fallback panel.
class _PictureCard extends StatelessWidget {
  final String assetPath;
  final double width;
  final double height;
  final VanRozgarColorTokens tokens;

  const _PictureCard({
    required this.assetPath,
    required this.width,
    required this.height,
    required this.tokens,
  });

  @override
  Widget build(BuildContext context) {
    final dpr = MediaQuery.devicePixelRatioOf(context);
    final cacheWidth = (width * dpr).round();

    return Container(
      width: width,
      height: height,
      decoration: BoxDecoration(
        color: tokens.card,
        borderRadius: BorderRadius.circular(24.0),
        border: Border.all(color: tokens.borders, width: 1.0),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withValues(alpha: 0.12),
            blurRadius: 12.0,
            offset: const Offset(0, 4),
          ),
        ],
      ),
      child: ClipRRect(
        borderRadius: BorderRadius.circular(23.0),
        child: ExcludeSemantics(
          child: Image.asset(
            assetPath,
            fit: BoxFit.cover,
            cacheWidth: cacheWidth,
            errorBuilder: (context, error, stackTrace) {
              return Container(
                color: VanRozgarTokens.picturePanel,
                alignment: Alignment.center,
                child: Icon(
                  Icons.eco_outlined,
                  size: 28.0,
                  color: VanRozgarTokens.lightHeadingGreen.withValues(alpha: 0.6),
                ),
              );
            },
          ),
        ),
      ),
    );
  }
}
