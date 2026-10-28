/// Supported languages in VanRozgar Phase 1.
enum AppLanguage {
  en('English'),
  hi('हिंदी'),
  mr('मराठी');

  final String nativeLabel;
  const AppLanguage(this.nativeLabel);
}

/// Centralized strings collection for VanRozgar Phase 1.
///
/// Contains genuine English, Hindi, and Marathi translations.
/// No widget contains hard-coded text.
class AppStrings {
  final AppLanguage language;

  const AppStrings(this.language);

  static const en = AppStrings(AppLanguage.en);
  static const hi = AppStrings(AppLanguage.hi);
  static const mr = AppStrings(AppLanguage.mr);

  static AppStrings of(AppLanguage lang) {
    switch (lang) {
      case AppLanguage.en:
        return en;
      case AppLanguage.hi:
        return hi;
      case AppLanguage.mr:
        return mr;
    }
  }

  // Branding
  String get appName => 'VanRozgar';
  String get appNameNative {
    switch (language) {
      case AppLanguage.en:
        return 'VanRozgar';
      case AppLanguage.hi:
      case AppLanguage.mr:
        return 'वनरोजगार';
    }
  }

  String get tagline {
    switch (language) {
      case AppLanguage.en:
        return 'Sell direct. Earn local.';
      case AppLanguage.hi:
        return 'सीधा बेचें। स्थानीय कमाएं।';
      case AppLanguage.mr:
        return 'थेट विक्री. स्थानिक रोजगार.';
    }
  }

  // Header & Controls
  String get villagePickerLabel {
    switch (language) {
      case AppLanguage.en:
        return 'Select village';
      case AppLanguage.hi:
        return 'गाँव चुनें';
      case AppLanguage.mr:
        return 'गाव निवडा';
    }
  }

  String get sampleVillageValue {
    switch (language) {
      case AppLanguage.en:
        return 'Sample village';
      case AppLanguage.hi:
        return 'नमूना गाँव';
      case AppLanguage.mr:
        return 'नमुना गाव';
    }
  }

  String get searchHint {
    switch (language) {
      case AppLanguage.en:
        return 'Search forest produce, herbs, bamboo...';
      case AppLanguage.hi:
        return 'वनोपज, जड़ी-बूटियाँ, बाँस खोजें...';
      case AppLanguage.mr:
        return 'वनोपज, औषधी वनस्पती, बांबू शोधा...';
    }
  }

  String get searchSemanticLabel {
    switch (language) {
      case AppLanguage.en:
        return 'Search catalog products';
      case AppLanguage.hi:
        return 'कैटलॉग उत्पाद खोजें';
      case AppLanguage.mr:
        return 'कॅटलॉग उत्पादने शोधा';
    }
  }

  // Navigation Destination Labels
  String get navHome {
    switch (language) {
      case AppLanguage.en:
        return 'Home';
      case AppLanguage.hi:
        return 'होम';
      case AppLanguage.mr:
        return 'मुख्यपृष्ठ';
    }
  }

  String get navCategories {
    switch (language) {
      case AppLanguage.en:
        return 'Categories';
      case AppLanguage.hi:
        return 'श्रेणियाँ';
      case AppLanguage.mr:
        return 'वर्गवारी';
    }
  }

  String get navCart {
    switch (language) {
      case AppLanguage.en:
        return 'Cart';
      case AppLanguage.hi:
        return 'कार्ट';
      case AppLanguage.mr:
        return 'कार्ट';
    }
  }

  String get navOrders {
    switch (language) {
      case AppLanguage.en:
        return 'Orders';
      case AppLanguage.hi:
        return 'ऑर्डर';
      case AppLanguage.mr:
        return 'ऑर्डर्स';
    }
  }

  String get navProfile {
    switch (language) {
      case AppLanguage.en:
        return 'Profile';
      case AppLanguage.hi:
        return 'प्रोफाइल';
      case AppLanguage.mr:
        return 'प्रोफाइल';
    }
  }

  // Categories (exact slugs and labels)
  String categoryLabel(String slug) {
    switch (slug) {
      case 'all':
        switch (language) {
          case AppLanguage.en:
            return 'All';
          case AppLanguage.hi:
            return 'सभी';
          case AppLanguage.mr:
            return 'सर्व';
        }
      case 'handicrafts-bamboo':
        switch (language) {
          case AppLanguage.en:
            return 'Bamboo';
          case AppLanguage.hi:
            return 'बाँस';
          case AppLanguage.mr:
            return 'बांबू';
        }
      case 'fruit':
        switch (language) {
          case AppLanguage.en:
            return 'Fruit';
          case AppLanguage.hi:
            return 'फल';
          case AppLanguage.mr:
            return 'फळे';
        }
      case 'nuts-and-seeds':
        switch (language) {
          case AppLanguage.en:
            return 'Nuts and oil seeds';
          case AppLanguage.hi:
            return 'मेवे और तेल बीज';
          case AppLanguage.mr:
            return 'सुकामेवा आणि तेलबिया';
        }
      case 'flowers':
        switch (language) {
          case AppLanguage.en:
            return 'Flowers';
          case AppLanguage.hi:
            return 'फूल';
          case AppLanguage.mr:
            return 'फुले';
        }
      case 'medicinal-plants':
        switch (language) {
          case AppLanguage.en:
            return 'Medicine and herbs';
          case AppLanguage.hi:
            return 'औषधि और जड़ी-बूटियाँ';
          case AppLanguage.mr:
            return 'औषधी वनस्पती';
        }
      case 'forest-produce':
        switch (language) {
          case AppLanguage.en:
            return 'Forest produce';
          case AppLanguage.hi:
            return 'वनोपज';
          case AppLanguage.mr:
            return 'वनोपज';
        }
      case 'timber-trees':
        switch (language) {
          case AppLanguage.en:
            return 'Timber trees';
          case AppLanguage.hi:
            return 'इमारती लकड़ी के पेड़';
          case AppLanguage.mr:
            return 'इमारती लाकूड झाडे';
        }
      case 'shade-trees':
        switch (language) {
          case AppLanguage.en:
            return 'Shade and sacred trees';
          case AppLanguage.hi:
            return 'छायादार और पवित्र पेड़';
          case AppLanguage.mr:
            return 'सावली आणि पवित्र झाडे';
        }
      default:
        return slug;
    }
  }

  // Badge & General Sample Labels
  String get sampleBadge {
    switch (language) {
      case AppLanguage.en:
        return 'Sample';
      case AppLanguage.hi:
        return 'नमूना';
      case AppLanguage.mr:
        return 'नमुना';
    }
  }

  String get sampleImagePlaceholder {
    switch (language) {
      case AppLanguage.en:
        return 'Sample Image';
      case AppLanguage.hi:
        return 'नमूना चित्र';
      case AppLanguage.mr:
        return 'नमुना चित्र';
    }
  }

  String get browseSubtitle {
    switch (language) {
      case AppLanguage.en:
        return 'CFR Forest Produce';
      case AppLanguage.hi:
        return 'सी.एफ़.आर. वनोपज';
      case AppLanguage.mr:
        return 'सी.एफ़.आर. वनोपज';
    }
  }

  String get perUnitPrefix {
    switch (language) {
      case AppLanguage.en:
        return 'per';
      case AppLanguage.hi:
        return 'प्रति';
      case AppLanguage.mr:
        return 'प्रति';
    }
  }

  // State messages
  String get loading {
    switch (language) {
      case AppLanguage.en:
        return 'Loading catalog...';
      case AppLanguage.hi:
        return 'कैटलॉग लोड हो रहा है...';
      case AppLanguage.mr:
        return 'कॅटलॉग लोड होत आहे...';
    }
  }

  String get emptyProducts {
    switch (language) {
      case AppLanguage.en:
        return 'No sample products found in this category.';
      case AppLanguage.hi:
        return 'इस श्रेणी में कोई नमूना उत्पाद नहीं मिला।';
      case AppLanguage.mr:
        return 'या वर्गवारीत कोणतेही नमुना उत्पादन आढळले नाही.';
    }
  }

  String get errorLoading {
    switch (language) {
      case AppLanguage.en:
        return 'Could not load products.';
      case AppLanguage.hi:
        return 'उत्पाद लोड नहीं हो सके।';
      case AppLanguage.mr:
        return 'उत्पादने लोड करणे शक्य झाले नाही.';
    }
  }

  String get retry {
    switch (language) {
      case AppLanguage.en:
        return 'Retry';
      case AppLanguage.hi:
        return 'पुनः प्रयास करें';
      case AppLanguage.mr:
        return 'पुन्हा प्रयत्न करा';
    }
  }

  // Placeholder Screens
  String get placeholderCategoriesTitle {
    switch (language) {
      case AppLanguage.en:
        return 'Categories';
      case AppLanguage.hi:
        return 'श्रेणियाँ';
      case AppLanguage.mr:
        return 'वर्गवारी';
    }
  }

  String get placeholderCategoriesDesc {
    switch (language) {
      case AppLanguage.en:
        return 'Browse all 8 Minor Forest Produce (MFP) and CFR categories.';
      case AppLanguage.hi:
        return 'सभी 8 लघु वनोपज (एम.एफ़.पी.) और सी.एफ़.आर. श्रेणियाँ देखें।';
      case AppLanguage.mr:
        return 'सर्व 8 दुय्यम वनोपज (एम.एफ़.पी.) आणि सी.एफ़.आर. वर्गवारी पहा.';
    }
  }

  String get placeholderCartTitle {
    switch (language) {
      case AppLanguage.en:
        return 'Cart';
      case AppLanguage.hi:
        return 'कार्ट';
      case AppLanguage.mr:
        return 'कार्ट';
    }
  }

  String get placeholderCartDesc {
    switch (language) {
      case AppLanguage.en:
        return 'Items added to your cart will appear here.';
      case AppLanguage.hi:
        return 'आपके कार्ट में जोड़ी गई वस्तुएँ यहाँ दिखाई देंगी।';
      case AppLanguage.mr:
        return 'तुमच्या कार्टमध्ये जोडलेल्या वस्तू येथे दिसतील.';
    }
  }

  String get placeholderOrdersTitle {
    switch (language) {
      case AppLanguage.en:
        return 'Orders';
      case AppLanguage.hi:
        return 'ऑर्डर';
      case AppLanguage.mr:
        return 'ऑर्डर्स';
    }
  }

  String get placeholderOrdersDesc {
    switch (language) {
      case AppLanguage.en:
        return 'Your requests and orders will appear here.';
      case AppLanguage.hi:
        return 'आपके अनुरोध और ऑर्डर यहाँ दिखाई देंगे।';
      case AppLanguage.mr:
        return 'तुमच्या मागण्या आणि ऑर्डर्स येथे दिसतील.';
    }
  }

  String get placeholderProfileTitle {
    switch (language) {
      case AppLanguage.en:
        return 'Profile & Settings';
      case AppLanguage.hi:
        return 'प्रोफाइल और सेटिंग्स';
      case AppLanguage.mr:
        return 'प्रोफाइल आणि सेटिंग्ज';
    }
  }

  String get placeholderProfileDesc {
    switch (language) {
      case AppLanguage.en:
        return 'You are currently browsing VanRozgar as a Guest. Adjust theme and language settings below.';
      case AppLanguage.hi:
        return 'आप वर्तमान में अतिथि के रूप में वनरोजगार देख रहे हैं। नीचे थीम और भाषा सेटिंग्स बदलें।';
      case AppLanguage.mr:
        return 'आपण सध्या अतिथी म्हणून वनरोजगार पाहत आहात. खाली थीम आणि भाषा सेटिंग्ज बदला.';
    }
  }

  // Settings
  String get settingsThemeTitle {
    switch (language) {
      case AppLanguage.en:
        return 'Appearance / Theme';
      case AppLanguage.hi:
        return 'रंगरूप / थीम';
      case AppLanguage.mr:
        return 'देखावा / थीम';
    }
  }

  String get themeSystem {
    switch (language) {
      case AppLanguage.en:
        return 'System';
      case AppLanguage.hi:
        return 'सिस्टम';
      case AppLanguage.mr:
        return 'प्रणाली';
    }
  }

  String get themeLight {
    switch (language) {
      case AppLanguage.en:
        return 'Light';
      case AppLanguage.hi:
        return 'लाइट';
      case AppLanguage.mr:
        return 'लाइट';
    }
  }

  String get themeDark {
    switch (language) {
      case AppLanguage.en:
        return 'Dark';
      case AppLanguage.hi:
        return 'डार्क';
      case AppLanguage.mr:
        return 'डार्क';
    }
  }

  String get settingsLanguageTitle {
    switch (language) {
      case AppLanguage.en:
        return 'Language Selection';
      case AppLanguage.hi:
        return 'भाषा चयन';
      case AppLanguage.mr:
        return 'भाषा निवड';
    }
  }

  String get guestModeNotice {
    switch (language) {
      case AppLanguage.en:
        return 'Phase 1 Guest Preview — All data shown is sample CFR produce.';
      case AppLanguage.hi:
        return 'चरण 1 अतिथि पूर्वावलोकन — दिखाया गया सभी डेटा नमूना सी.एफ़.आर. वनोपज है।';
      case AppLanguage.mr:
        return 'टप्पा 1 अतिथी पूर्वदृश्य — दाखवलेला सर्व डेटा नमुना सी.एफ़.आर. वनोपज आहे.';
    }
  }

  // Landing Slide 1
  String get landingSlide1Lead {
    switch (language) {
      case AppLanguage.en:
        return 'Forest produce, straight from ';
      case AppLanguage.hi:
        return 'वनोपज, सीधे ';
      case AppLanguage.mr:
        return 'वनउपज, थेट ';
    }
  }

  String get landingSlide1Highlight {
    switch (language) {
      case AppLanguage.en:
        return 'CFR villages';
      case AppLanguage.hi:
        return 'सीएफआर गाँवों';
      case AppLanguage.mr:
        return 'सीएफआर गावांतून';
    }
  }

  String get landingSlide1Tail {
    switch (language) {
      case AppLanguage.en:
        return '';
      case AppLanguage.hi:
        return ' से';
      case AppLanguage.mr:
        return '';
    }
  }

  String get landingSlide1Subtitle {
    switch (language) {
      case AppLanguage.en:
        return 'Bamboo, mangoes and more, sold directly by Gram Sabhas and CFR holders in Nashik.';
      case AppLanguage.hi:
        return 'बाँस, आम और बहुत कुछ, नासिक की ग्राम सभाओं और सीएफआर धारकों द्वारा सीधे बेचा जाता है।';
      case AppLanguage.mr:
        return 'बांबू, आंबे आणि बरेच काही, नाशिकमधील ग्रामसभा आणि सीएफआर धारक थेट विकतात.';
    }
  }

  String get landingSlide1PictureLabel {
    switch (language) {
      case AppLanguage.en:
        return 'Bamboo and mangoes';
      case AppLanguage.hi:
        return 'बाँस और आम';
      case AppLanguage.mr:
        return 'बांबू आणि आंबे';
    }
  }

  // Landing Slide 2
  String get landingSlide2Lead {
    switch (language) {
      case AppLanguage.en:
        return 'Traditional forest ';
      case AppLanguage.hi:
        return 'पारंपरिक वन ';
      case AppLanguage.mr:
        return 'पारंपरिक ';
    }
  }

  String get landingSlide2Highlight {
    switch (language) {
      case AppLanguage.en:
        return 'herbs and fruits';
      case AppLanguage.hi:
        return 'जड़ी-बूटियाँ और फल';
      case AppLanguage.mr:
        return 'वनौषधी आणि फळे';
    }
  }

  String get landingSlide2Tail {
    switch (language) {
      case AppLanguage.en:
        return '';
      case AppLanguage.hi:
        return '';
      case AppLanguage.mr:
        return '';
    }
  }

  String get landingSlide2Subtitle {
    switch (language) {
      case AppLanguage.en:
        return 'Amla, bael, harad, baheda and more, gathered in village forests.';
      case AppLanguage.hi:
        return 'आँवला, बेल, हरड़, बहेड़ा और बहुत कुछ, गाँव के जंगलों से इकट्ठा किया गया।';
      case AppLanguage.mr:
        return 'आवळा, बेल, हिरडा, बेहडा आणि बरेच काही, गावच्या जंगलातून गोळा केलेले.';
    }
  }

  String get landingSlide2PictureLabel {
    switch (language) {
      case AppLanguage.en:
        return 'Amla, bael and dried forest fruits';
      case AppLanguage.hi:
        return 'आँवला, बेल और सूखे वन फल';
      case AppLanguage.mr:
        return 'आवळा, बेल आणि वाळलेली वन फळे';
    }
  }

  // Landing Slide 3
  String get landingSlide3Lead {
    switch (language) {
      case AppLanguage.en:
        return 'Work that stays ';
      case AppLanguage.hi:
        return 'रोज़गार जो ';
      case AppLanguage.mr:
        return 'रोजगार जो ';
    }
  }

  String get landingSlide3Highlight {
    switch (language) {
      case AppLanguage.en:
        return 'in the village';
      case AppLanguage.hi:
        return 'गाँव में ही रहे';
      case AppLanguage.mr:
        return 'गावातच राहतो';
    }
  }

  String get landingSlide3Tail {
    switch (language) {
      case AppLanguage.en:
        return '';
      case AppLanguage.hi:
        return '';
      case AppLanguage.mr:
        return '';
    }
  }

  String get landingSlide3Subtitle {
    switch (language) {
      case AppLanguage.en:
        return 'Gram Sabhas and CFR holders sell their produce and crafts directly to buyers.';
      case AppLanguage.hi:
        return 'ग्राम सभाएँ और सीएफआर धारक अपनी उपज और शिल्प सीधे खरीदारों को बेचते हैं।';
      case AppLanguage.mr:
        return 'ग्रामसभा आणि सीएफआर धारक त्यांची उपज आणि हस्तकला थेट खरेदीदारांना विकतात.';
    }
  }

  String get landingSlide3PictureLabel {
    switch (language) {
      case AppLanguage.en:
        return 'Hands weaving a bamboo basket and villagers sorting produce';
      case AppLanguage.hi:
        return 'बाँस की टोकरी बुनते हाथ और उपज छाँटते ग्रामीण';
      case AppLanguage.mr:
        return 'बांबूची टोपली विणणारे हात आणि उपज निवडणारे गावकरी';
    }
  }

  // Landing Buttons
  String get landingSkip {
    switch (language) {
      case AppLanguage.en:
        return 'Skip';
      case AppLanguage.hi:
        return 'छोड़ें';
      case AppLanguage.mr:
        return 'वगळा';
    }
  }

  String get landingNext {
    switch (language) {
      case AppLanguage.en:
        return 'Next';
      case AppLanguage.hi:
        return 'आगे';
      case AppLanguage.mr:
        return 'पुढे';
    }
  }

  String get landingGetStarted {
    switch (language) {
      case AppLanguage.en:
        return 'Get Started';
      case AppLanguage.hi:
        return 'शुरू करें';
      case AppLanguage.mr:
        return 'सुरू करा';
    }
  }

  // Semantic dot label
  String landingSlideDotLabel(int current, int total) {
    switch (language) {
      case AppLanguage.en:
        return 'Slide $current of $total';
      case AppLanguage.hi:
        return '$total में से स्लाइड $current';
      case AppLanguage.mr:
        return '$total पैकी स्लाइड $current';
    }
  }
}
