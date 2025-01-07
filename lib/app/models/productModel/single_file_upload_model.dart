// To parse this JSON data, do
//
//     final singleFileUploadModel = singleFileUploadModelFromJson(jsonString);

import 'dart:convert';

SingleFileUploadModel singleFileUploadModelFromJson(String str) => SingleFileUploadModel.fromJson(json.decode(str));

String singleFileUploadModelToJson(SingleFileUploadModel data) => json.encode(data.toJson());

class SingleFileUploadModel {
  String? assetId;
  String? publicId;
  int? version;
  String? versionId;
  String? signature;
  int? width;
  int? height;
  String? format;
  String? resourceType;
  DateTime? createdAt;
  List<dynamic>? tags;
  int? bytes;
  String? type;
  String? etag;
  bool? placeholder;
  String? url;
  String? secureUrl;
  String? assetFolder;
  String? displayName;
  String? accessMode;
  String? originalFilename;

  SingleFileUploadModel({
    this.assetId,
    this.publicId,
    this.version,
    this.versionId,
    this.signature,
    this.width,
    this.height,
    this.format,
    this.resourceType,
    this.createdAt,
    this.tags,
    this.bytes,
    this.type,
    this.etag,
    this.placeholder,
    this.url,
    this.secureUrl,
    this.assetFolder,
    this.displayName,
    this.accessMode,
    this.originalFilename,
  });

  factory SingleFileUploadModel.fromJson(Map<String, dynamic> json) => SingleFileUploadModel(
    assetId: json["asset_id"],
    publicId: json["public_id"],
    version: json["version"],
    versionId: json["version_id"],
    signature: json["signature"],
    width: json["width"],
    height: json["height"],
    format: json["format"],
    resourceType: json["resource_type"],
    createdAt: json["created_at"] == null ? null : DateTime.parse(json["created_at"]),
    tags: json["tags"] == null ? [] : List<dynamic>.from(json["tags"]!.map((x) => x)),
    bytes: json["bytes"],
    type: json["type"],
    etag: json["etag"],
    placeholder: json["placeholder"],
    url: json["url"],
    secureUrl: json["secure_url"],
    assetFolder: json["asset_folder"],
    displayName: json["display_name"],
    accessMode: json["access_mode"],
    originalFilename: json["original_filename"],
  );

  Map<String, dynamic> toJson() => {
    "asset_id": assetId,
    "public_id": publicId,
    "version": version,
    "version_id": versionId,
    "signature": signature,
    "width": width,
    "height": height,
    "format": format,
    "resource_type": resourceType,
    "created_at": createdAt?.toIso8601String(),
    "tags": tags == null ? [] : List<dynamic>.from(tags!.map((x) => x)),
    "bytes": bytes,
    "type": type,
    "etag": etag,
    "placeholder": placeholder,
    "url": url,
    "secure_url": secureUrl,
    "asset_folder": assetFolder,
    "display_name": displayName,
    "access_mode": accessMode,
    "original_filename": originalFilename,
  };
}
