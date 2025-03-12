import 'package:flutter_dotenv/flutter_dotenv.dart';

class Environments {
  static const String PRODUCTION = 'prod';
  static const String QAS = 'QAS';
  static const String DEV = 'dev';
  // static const String LOCAL = 'local';
}

class ConfigEnvironments {
  static const String _currentEnvironments = Environments.PRODUCTION;
  static final List<Map<String, String>> _availableEnvironments = [
    {'env': Environments.DEV, 'strapi': dotenv.env['STRAPI_BE_PROD']!},
    {'env': Environments.QAS, 'strapi': dotenv.env['STRAPI_BE_PROD']!},
    {'env': Environments.PRODUCTION, 'strapi': dotenv.env['STRAPI_BE_PROD']!},
  ];

  static Map<String, String> getEnvironments() {
    return _availableEnvironments.firstWhere((d) => d['env'] == _currentEnvironments);
  }
}
