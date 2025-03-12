import 'domain.dart';

class UrlDomain {
  UrlDomain._();
  static String admin = ConfigEnvironments.getEnvironments()['admin']!;
  static String jwt = ConfigEnvironments.getEnvironments()['jwt']!;
  static String whmcs = ConfigEnvironments.getEnvironments()['whmcs']!;
  //
  static String content = ConfigEnvironments.getEnvironments()['content']!;
  static String contentImages = ConfigEnvironments.getEnvironments()['content_images']!;
  static String ticket = ConfigEnvironments.getEnvironments()['ticket']!;
}

class Domain {
  Domain._();

  static String whmcs = UrlDomain.whmcs + PathDomain.api + PathDomain.v2;
  // static String backendV1 = "${UrlDomain.admin}${PathDomain.api}${PathDomain.v1}";
  static String backendV2 = UrlDomain.admin + PathDomain.api + PathDomain.v2;
  static String content = UrlDomain.content + PathDomain.v1 + PathDomain.public + PathDomain.api;
  static String ticket = UrlDomain.ticket + PathDomain.v1 + PathDomain.api;
  static String latlong = UrlDomain.admin + PathDomain.v1;
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
  static String register = "${Domain.whmcs}/auth/register";
  static String login = "${Domain.whmcs}/auth/login";
  static String resetpassword = "${Domain.whmcs}/auth/resetpassword";
  static String resetpasswordresponse = "${Domain.whmcs}/auth/resetpasswordhook";
  static String users = "${Domain.whmcs}/clients";
  static String productCategory = "${Domain.whmcs}/products/productgroups";
  static String product = "${Domain.whmcs}/products";
  static String productOrder = "${Domain.whmcs}/orders";
  static String addons = "${Domain.whmcs}/products/addons";
  static String checkout = "${Domain.whmcs}/checkout";
  static String generatePayment = "${Domain.whmcs}/generatepaymentlink";
  static String riwayatInternet = "${Domain.whmcs}/invoices";
  static String activeInternet = "${Domain.whmcs}/userproducts";

  //Backend
  static String locationLatLong = "${Domain.backendV2}/geolocation/location/check-location-radius";
  static String locationServer = "${Domain.backendV2}/geolocation/points";
  static String banner = "${Domain.backendV2}/all-banners";
  static String clientExist = "${Domain.backendV2}/client-exists";
  static String latLongDetail = "${Domain.backendV2}/detail-client-relation";
  static String latLongEdit = "${Domain.backendV2}/update-client-relation";
  static String locationMaps = "${Domain.backendV2}/location";
  static String npwp = "${Domain.backendV2}/npwp";
  static String order = "${Domain.backendV2}/order";

  // Latlong
  static String latLong = "${Domain.latlong}/create-client-relation";

  //Content
  static String paketProductCategory = "${Domain.content}/categories-product";
  static String paketProduct = "${Domain.content}/products";
  static String blogs = "${Domain.content}/blogs";
  static String blogsLabel = "${Domain.content}/blog-labels";
  static String blogsBookmark = "${Domain.content}/bookmark";
  static String blogsBookmarks = "${Domain.content}/bookmarks";

  //Ticket
  static String ticket = "${Domain.ticket}/ticket";
  static String tickets = "${Domain.ticket}/tickets";
}
