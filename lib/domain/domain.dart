import 'package:flutter_dotenv/flutter_dotenv.dart';

class Environments {
  static const String PRODUCTION = 'prod';
  static const String QAS = 'QAS';
  static const String DEV = 'dev';
  // static const String LOCAL = 'local';
}

class ConfigEnvironments {
  static const String _currentEnvironments = Environments.DEV;
  static final List<Map<String, String>> _availableEnvironments = [
    {
      'env': Environments.DEV,
      'jwt': dotenv.env['JWT_SECRET']!,
      'whmcs': dotenv.env['URL_DEV_WHMCS']!,
      'admin': dotenv.env['URL_DEV_ADMIN']!,
      'content': dotenv.env['URL_DEV_CONTENT']!,
      'content_images': dotenv.env['URL_DEV_CONTENT_IMAGES']!,
      'ticket': dotenv.env['URL_DEV_TICKET']!,
    },
    {
      'env': Environments.QAS,
      'jwt': dotenv.env['JWT_SECRET']!,
      'whmcs': dotenv.env['URL_QAS_WHMCS']!,
      'admin': dotenv.env['URL_QAS_ADMIN']!,
      'content': dotenv.env['URL_QAS_CONTENT']!,
      'content_images': dotenv.env['URL_QAS_CONTENT_IMAGES']!,
      'ticket': dotenv.env['URL_QAS_TICKET']!,
    },
    {
      'env': Environments.PRODUCTION,
      'jwt': dotenv.env['JWT_SECRET']!,
      'whmcs': dotenv.env['URL_PROD_WHMCS']!,
      'admin': dotenv.env['URL_PROD_ADMIN']!,
      'content': dotenv.env['URL_PROD_CONTENT']!,
      'content_images': dotenv.env['URL_PROD_CONTENT_IMAGES']!,
      'ticket': dotenv.env['URL_PROD_TICKET']!,
    },
  ];

  static Map<String, String> getEnvironments() {
    return _availableEnvironments.firstWhere((d) => d['env'] == _currentEnvironments);
  }
}
