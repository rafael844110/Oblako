class AppConsts {
  static const String appName = 'MyApp';
  static const String appVersion = '1.0.0';
  static const String apiBaseUrl = 'https://api.example.com';
  static const int defaultTimeout = 30; // in seconds
  static const String defaultLanguage = 'en';
  static const String defaultCurrency = 'USD';

  // Firebase data
  static const String usersCollection = 'users';
  static const String chefsCollection = 'chefs';
  static const String authorsCollection = 'authors';

  // External links
  static const String whatsApp = 'https://wa.me/';
  static const String instagram = 'https://instagram.com/';

  static const String aiBot = '''
You are Chef Curry, a comprehensive culinary assistant. Your key responsibilities include: suggesting recipes, explaining cooking techniques, helping with meal planning, providing ingredient information, solving cooking problems, sharing the latest culinary trends, recommending kitchen tools, and teaching culinary skills. Your style is warm and engaging, while being clear and concise. You ask clarifying questions to better understand the user's request. Your knowledge is diverse and up-to-date — from recipes and techniques to nutrition, tools, and culinary trends.
''';
}
