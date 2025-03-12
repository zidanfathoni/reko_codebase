class ZidanfathProjectsModels {
  ZidanfathProjectsModels({required this.data, required this.meta});

  final List<Datum> data;
  final Meta? meta;

  factory ZidanfathProjectsModels.fromJson(Map<String, dynamic> json) {
    return ZidanfathProjectsModels(
      data:
          json["data"] == null ? [] : List<Datum>.from(json["data"]!.map((x) => Datum.fromJson(x))),
      meta: json["meta"] == null ? null : Meta.fromJson(json["meta"]),
    );
  }

  Map<String, dynamic> toJson() => {
    "data": data.map((x) => x?.toJson()).toList(),
    "meta": meta?.toJson(),
  };
}

class Datum {
  Datum({required this.id, required this.attributes});

  final int id;
  final DatumAttributes? attributes;

  factory Datum.fromJson(Map<String, dynamic> json) {
    return Datum(
      id: json["id"] ?? 0,
      attributes: json["attributes"] == null ? null : DatumAttributes.fromJson(json["attributes"]),
    );
  }

  Map<String, dynamic> toJson() => {"id": id, "attributes": attributes?.toJson()};
}

class DatumAttributes {
  DatumAttributes({
    required this.title,
    required this.description,
    required this.link,
    required this.createdAt,
    required this.updatedAt,
    required this.publishedAt,
    required this.startDate,
    required this.endDate,
    required this.active,
    required this.tech,
    required this.image,
  });

  final String title;
  final String description;
  final String link;
  final DateTime? createdAt;
  final DateTime? updatedAt;
  final DateTime? publishedAt;
  final DateTime? startDate;
  final DateTime? endDate;
  final bool active;
  final String tech;
  final Image? image;

  factory DatumAttributes.fromJson(Map<String, dynamic> json) {
    return DatumAttributes(
      title: json["title"] ?? "",
      description: json["description"] ?? "",
      link: json["link"] ?? "",
      createdAt: DateTime.tryParse(json["createdAt"] ?? ""),
      updatedAt: DateTime.tryParse(json["updatedAt"] ?? ""),
      publishedAt: DateTime.tryParse(json["publishedAt"] ?? ""),
      startDate: DateTime.tryParse(json["start_date"] ?? ""),
      endDate: DateTime.tryParse(json["end_date"] ?? ""),
      active: json["active"] ?? false,
      tech: json["tech"] ?? "",
      image: json["image"] == null ? null : Image.fromJson(json["image"]),
    );
  }

  Map<String, dynamic> toJson() => {
    "title": title,
    "description": description,
    "link": link,
    "createdAt": createdAt?.toIso8601String(),
    "updatedAt": updatedAt?.toIso8601String(),
    "publishedAt": publishedAt?.toIso8601String(),
    "start_date": "${startDate?.year.toString()}",
    "end_date": "${endDate?.year.toString()}",
    "active": active,
    "tech": tech,
    "image": image?.toJson(),
  };
}

class Image {
  Image({required this.data});

  final Data? data;

  factory Image.fromJson(Map<String, dynamic> json) {
    return Image(data: json["data"] == null ? null : Data.fromJson(json["data"]));
  }

  Map<String, dynamic> toJson() => {"data": data?.toJson()};
}

class Data {
  Data({required this.id, required this.attributes});

  final int id;
  final DataAttributes? attributes;

  factory Data.fromJson(Map<String, dynamic> json) {
    return Data(
      id: json["id"] ?? 0,
      attributes: json["attributes"] == null ? null : DataAttributes.fromJson(json["attributes"]),
    );
  }

  Map<String, dynamic> toJson() => {"id": id, "attributes": attributes?.toJson()};
}

class DataAttributes {
  DataAttributes({
    required this.name,
    required this.alternativeText,
    required this.caption,
    required this.width,
    required this.height,
    required this.formats,
    required this.hash,
    required this.ext,
    required this.mime,
    required this.size,
    required this.url,
    required this.previewUrl,
    required this.provider,
    required this.providerMetadata,
    required this.createdAt,
    required this.updatedAt,
  });

  final String name;
  final String alternativeText;
  final String caption;
  final int width;
  final int height;
  final Formats? formats;
  final String hash;
  final String ext;
  final String mime;
  final double size;
  final String url;
  final String previewUrl;
  final String provider;
  final String providerMetadata;
  final DateTime? createdAt;
  final DateTime? updatedAt;

  factory DataAttributes.fromJson(Map<String, dynamic> json) {
    return DataAttributes(
      name: json["name"] ?? "",
      alternativeText: json["alternativeText"] ?? "",
      caption: json["caption"] ?? "",
      width: json["width"] ?? 0,
      height: json["height"] ?? 0,
      formats: json["formats"] == null ? null : Formats.fromJson(json["formats"]),
      hash: json["hash"] ?? "",
      ext: json["ext"] ?? "",
      mime: json["mime"] ?? "",
      size: json["size"] ?? 0.0,
      url: json["url"] ?? "",
      previewUrl: json["previewUrl"] ?? "",
      provider: json["provider"] ?? "",
      providerMetadata: json["provider_metadata"] ?? "",
      createdAt: DateTime.tryParse(json["createdAt"] ?? ""),
      updatedAt: DateTime.tryParse(json["updatedAt"] ?? ""),
    );
  }

  Map<String, dynamic> toJson() => {
    "name": name,
    "alternativeText": alternativeText,
    "caption": caption,
    "width": width,
    "height": height,
    "formats": formats?.toJson(),
    "hash": hash,
    "ext": ext,
    "mime": mime,
    "size": size,
    "url": url,
    "previewUrl": previewUrl,
    "provider": provider,
    "provider_metadata": providerMetadata,
    "createdAt": createdAt?.toIso8601String(),
    "updatedAt": updatedAt?.toIso8601String(),
  };
}

class Formats {
  Formats({required this.thumbnail});

  final Thumbnail? thumbnail;

  factory Formats.fromJson(Map<String, dynamic> json) {
    return Formats(
      thumbnail: json["thumbnail"] == null ? null : Thumbnail.fromJson(json["thumbnail"]),
    );
  }

  Map<String, dynamic> toJson() => {"thumbnail": thumbnail?.toJson()};
}

class Thumbnail {
  Thumbnail({
    required this.ext,
    required this.url,
    required this.hash,
    required this.mime,
    required this.name,
    required this.path,
    required this.size,
    required this.width,
    required this.height,
    required this.sizeInBytes,
  });

  final String ext;
  final String url;
  final String hash;
  final String mime;
  final String name;
  final String path;
  final double size;
  final int width;
  final int height;
  final int sizeInBytes;

  factory Thumbnail.fromJson(Map<String, dynamic> json) {
    return Thumbnail(
      ext: json["ext"] ?? "",
      url: json["url"] ?? "",
      hash: json["hash"] ?? "",
      mime: json["mime"] ?? "",
      name: json["name"] ?? "",
      path: json["path"] ?? "",
      size: json["size"] ?? 0.0,
      width: json["width"] ?? 0,
      height: json["height"] ?? 0,
      sizeInBytes: json["sizeInBytes"] ?? 0,
    );
  }

  Map<String, dynamic> toJson() => {
    "ext": ext,
    "url": url,
    "hash": hash,
    "mime": mime,
    "name": name,
    "path": path,
    "size": size,
    "width": width,
    "height": height,
    "sizeInBytes": sizeInBytes,
  };
}

class Meta {
  Meta({required this.pagination});

  final Pagination? pagination;

  factory Meta.fromJson(Map<String, dynamic> json) {
    return Meta(
      pagination: json["pagination"] == null ? null : Pagination.fromJson(json["pagination"]),
    );
  }

  Map<String, dynamic> toJson() => {"pagination": pagination?.toJson()};
}

class Pagination {
  Pagination({
    required this.page,
    required this.pageSize,
    required this.pageCount,
    required this.total,
  });

  final int page;
  final int pageSize;
  final int pageCount;
  final int total;

  factory Pagination.fromJson(Map<String, dynamic> json) {
    return Pagination(
      page: json["page"] ?? 0,
      pageSize: json["pageSize"] ?? 0,
      pageCount: json["pageCount"] ?? 0,
      total: json["total"] ?? 0,
    );
  }

  Map<String, dynamic> toJson() => {
    "page": page,
    "pageSize": pageSize,
    "pageCount": pageCount,
    "total": total,
  };
}
