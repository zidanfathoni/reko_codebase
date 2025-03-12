import 'domain.dart';

class UrlDomain {
  UrlDomain._();
  static String strapi = ConfigEnvironments.getEnvironments()['strapi']!;
}

class Domain {
  Domain._();

  static String backendStrapi = "${UrlDomain.strapi}/api";
}

class PathDomain {
  PathDomain._();

  static String banner = '/assets/banner/';
  static String v1 = '/v1';
  static String v2 = '/v2';
  static String public = '/public';
  static String api = '/api';
  static String images = '/images';
}

class URL {
  URL._();

  //WHMCS
  static String zidanfathProjects = "${Domain.backendStrapi}/zidanfath-projects";
}
