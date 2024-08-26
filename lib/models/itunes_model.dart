// To parse this JSON data, do
//
//     final iTunesModel = iTunesModelFromJson(jsonString);

import 'dart:convert';

ITunesModel iTunesModelFromJson(String str) =>
    ITunesModel.fromJson(json.decode(str));

String iTunesModelToJson(ITunesModel data) => json.encode(data.toJson());

class ITunesModel {
  int? resultCount;
  List<ITunesResultsList>? results;

  ITunesModel({
    this.resultCount,
    this.results,
  });

  factory ITunesModel.fromJson(Map<String, dynamic> json) => ITunesModel(
        resultCount: json["resultCount"],
        results: json["results"] == null
            ? []
            : List<ITunesResultsList>.from(
                json["results"]!.map((x) => ITunesResultsList.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "resultCount": resultCount,
        "results": results == null
            ? []
            : List<dynamic>.from(results!.map((x) => x.toJson())),
      };
}

class ITunesResultsList {
  String? artistViewUrl;
  String? artistLinkUrl;
  String? artworkUrl60;
  String? artworkUrl100;
  List<String>? features;
  List<String>? supportedDevices;
  bool? isGameCenterEnabled;
  List<String>? screenshotUrls;
  List<String>? ipadScreenshotUrls;
  List<dynamic>? appletvScreenshotUrls;
  String? artworkUrl512;
  List<String>? advisories;
  String? kind;
  String? currency;
  String? trackCensoredName;
  String? trackViewUrl;
  String? contentAdvisoryRating;
  double? averageUserRating;
  DateTime? currentVersionReleaseDate;
  String? releaseNotes;
  String? description;
  String? longDescription;
  int? artistId;
  String? artistName;
  String? artistType;
  List<String>? genres;
  double? price;
  String? bundleId;
  List<String>? genreIds;
  DateTime? releaseDate;
  int? trackId;
  String? trackName;
  String? primaryGenreName;
  int? primaryGenreId;
  String? sellerName;
  bool? isVppDeviceBasedLicensingEnabled;
  double? averageUserRatingForCurrentVersion;
  List<String>? languageCodesIso2A;
  int? fileSizeBytes;
  String? sellerUrl;
  String? formattedPrice;
  int? userRatingCountForCurrentVersion;
  String? trackContentRating;
  String? minimumOsVersion;
  String? version;
  String? wrapperType;
  int? userRatingCount;
  String? collectionType;
  int? collectionId;
  int? amgArtistId;
  String? collectionName;
  String? collectionCensoredName;
  String? collectionViewUrl;
  double? collectionPrice;
  String? collectionExplicitness;
  int? trackCount;
  String? copyright;
  String? country;
  String? collectionArtistName;
  String? previewUrl;
  String? artworkUrl30;
  double? trackPrice;
  String? trackExplicitness;
  int? discCount;
  int? discNumber;
  int? trackNumber;
  int? trackTimeMillis;
  bool? isStreamable;

  ITunesResultsList({
    this.artistLinkUrl,
    this.artistViewUrl,
    this.artworkUrl60,
    this.artworkUrl100,
    this.features,
    this.supportedDevices,
    this.isGameCenterEnabled,
    this.screenshotUrls,
    this.ipadScreenshotUrls,
    this.appletvScreenshotUrls,
    this.artworkUrl512,
    this.advisories,
    this.kind,
    this.currency,
    this.trackCensoredName,
    this.trackViewUrl,
    this.contentAdvisoryRating,
    this.averageUserRating,
    this.currentVersionReleaseDate,
    this.releaseNotes,
    this.description,
    this.longDescription,
    this.artistId,
    this.artistName,
    this.artistType,
    this.genres,
    this.price,
    this.bundleId,
    this.genreIds,
    this.releaseDate,
    this.trackId,
    this.trackName,
    this.primaryGenreName,
    this.primaryGenreId,
    this.sellerName,
    this.isVppDeviceBasedLicensingEnabled,
    this.averageUserRatingForCurrentVersion,
    this.languageCodesIso2A,
    this.fileSizeBytes,
    this.sellerUrl,
    this.formattedPrice,
    this.userRatingCountForCurrentVersion,
    this.trackContentRating,
    this.minimumOsVersion,
    this.version,
    this.wrapperType,
    this.userRatingCount,
    this.collectionType,
    this.collectionId,
    this.amgArtistId,
    this.collectionName,
    this.collectionCensoredName,
    this.collectionViewUrl,
    this.collectionPrice,
    this.collectionExplicitness,
    this.trackCount,
    this.copyright,
    this.country,
    this.collectionArtistName,
    this.previewUrl,
    this.artworkUrl30,
    this.trackPrice,
    this.trackExplicitness,
    this.discCount,
    this.discNumber,
    this.trackNumber,
    this.trackTimeMillis,
    this.isStreamable,
  });

  factory ITunesResultsList.fromJson(Map<String, dynamic> json) =>
      ITunesResultsList(
        artistViewUrl: json["artistViewUrl"],
        artistLinkUrl: json["artistLinkUrl"],
        artworkUrl60: json["artworkUrl60"],
        artworkUrl100: json["artworkUrl100"],
        features: json["features"] == null
            ? []
            : List<String>.from(json["features"]!.map((x) => x)),
        supportedDevices: json["supportedDevices"] == null
            ? []
            : List<String>.from(json["supportedDevices"]!.map((x) => x)),
        isGameCenterEnabled: json["isGameCenterEnabled"],
        screenshotUrls: json["screenshotUrls"] == null
            ? []
            : List<String>.from(json["screenshotUrls"]!.map((x) => x)),
        ipadScreenshotUrls: json["ipadScreenshotUrls"] == null
            ? []
            : List<String>.from(json["ipadScreenshotUrls"]!.map((x) => x)),
        appletvScreenshotUrls: json["appletvScreenshotUrls"] == null
            ? []
            : List<dynamic>.from(json["appletvScreenshotUrls"]!.map((x) => x)),
        artworkUrl512: json["artworkUrl512"],
        advisories: json["advisories"] == null
            ? []
            : List<String>.from(json["advisories"]!.map((x) => x)),
        kind: json["kind"] ??
            (json["wrapperType"] == "artist"
                ? json["artistType"]
                : json["wrapperType"] == "collection"
                    ? json["collectionType"]
                    : json["wrapperType"] == "audiobook"
                        ? "audio Book"
                        : ""),
        currency: json["currency"],
        trackCensoredName: json["trackCensoredName"],
        trackViewUrl: json["trackViewUrl"],
        contentAdvisoryRating: json["contentAdvisoryRating"],
        averageUserRating: json["averageUserRating"]?.toDouble(),
        currentVersionReleaseDate: json["currentVersionReleaseDate"] == null
            ? null
            : DateTime.parse(json["currentVersionReleaseDate"]),
        releaseNotes: json["releaseNotes"],
        description: json["description"],
        longDescription: json["longDescription"],
        artistId: json["artistId"],
        artistName: json["artistName"],
        artistType: json["artistType"],
        genres: json["genres"] == null
            ? []
            : List<String>.from(json["genres"]!.map((x) => x)),
        price: json["price"],
        bundleId: json["bundleId"],
        genreIds: json["genreIds"] == null
            ? []
            : List<String>.from(json["genreIds"]!.map((x) => x)),
        releaseDate: json["releaseDate"] == null
            ? null
            : DateTime.parse(json["releaseDate"]),
        trackId: json["trackId"],
        trackName: json["trackName"],
        primaryGenreName: json["primaryGenreName"],
        primaryGenreId: json["primaryGenreId"],
        sellerName: json["sellerName"],
        isVppDeviceBasedLicensingEnabled:
            json["isVppDeviceBasedLicensingEnabled"],
        averageUserRatingForCurrentVersion:
            json["averageUserRatingForCurrentVersion"]?.toDouble(),
        languageCodesIso2A: json["languageCodesISO2A"] == null
            ? []
            : List<String>.from(json["languageCodesISO2A"]!.map((x) => x)),
        fileSizeBytes: json["fileSizeBytes"],
        sellerUrl: json["sellerUrl"],
        formattedPrice: json["formattedPrice"],
        userRatingCountForCurrentVersion:
            json["userRatingCountForCurrentVersion"],
        trackContentRating: json["trackContentRating"],
        minimumOsVersion: json["minimumOsVersion"],
        version: json["version"],
        wrapperType: json["wrapperType"] ?? "ebook",
        userRatingCount: json["userRatingCount"],
        collectionType: json["collectionType"],
        collectionId: json["collectionId"],
        amgArtistId: json["amgArtistId"],
        collectionName: json["collectionName"],
        collectionCensoredName: json["collectionCensoredName"],
        collectionViewUrl: json["collectionViewUrl"],
        collectionPrice: json["collectionPrice"]?.toDouble(),
        collectionExplicitness: json["collectionExplicitness"],
        trackCount: json["trackCount"],
        copyright: json["copyright"],
        country: json["country"],
        collectionArtistName: json["collectionArtistName"],
        previewUrl: json["previewUrl"],
        artworkUrl30: json["artworkUrl30"],
        trackPrice: json["trackPrice"]?.toDouble(),
        trackExplicitness: json["trackExplicitness"],
        discCount: json["discCount"],
        discNumber: json["discNumber"],
        trackNumber: json["trackNumber"],
        trackTimeMillis: json["trackTimeMillis"],
        isStreamable: json["isStreamable"],
      );

  Map<String, dynamic> toJson() => {
        "artistViewUrl": artistViewUrl,
        "artistLinkUrl": artistLinkUrl,
        "artworkUrl60": artworkUrl60,
        "artworkUrl100": artworkUrl100,
        "features":
            features == null ? [] : List<dynamic>.from(features!.map((x) => x)),
        "supportedDevices": supportedDevices == null
            ? []
            : List<dynamic>.from(supportedDevices!.map((x) => x)),
        "isGameCenterEnabled": isGameCenterEnabled,
        "screenshotUrls": screenshotUrls == null
            ? []
            : List<dynamic>.from(screenshotUrls!.map((x) => x)),
        "ipadScreenshotUrls": ipadScreenshotUrls == null
            ? []
            : List<dynamic>.from(ipadScreenshotUrls!.map((x) => x)),
        "appletvScreenshotUrls": appletvScreenshotUrls == null
            ? []
            : List<dynamic>.from(appletvScreenshotUrls!.map((x) => x)),
        "artworkUrl512": artworkUrl512,
        "advisories": advisories == null
            ? []
            : List<dynamic>.from(advisories!.map((x) => x)),
        "kind": kind,
        "currency": currency,
        "trackCensoredName": trackCensoredName,
        "trackViewUrl": trackViewUrl,
        "contentAdvisoryRating": contentAdvisoryRating,
        "averageUserRating": averageUserRating,
        "currentVersionReleaseDate":
            currentVersionReleaseDate?.toIso8601String(),
        "releaseNotes": releaseNotes,
        "description": description,
        "longDescription": longDescription,
        "artistId": artistId,
        "artistName": artistName,
        "artistType": artistType,
        "genres":
            genres == null ? [] : List<dynamic>.from(genres!.map((x) => x)),
        "price": price,
        "bundleId": bundleId,
        "genreIds":
            genreIds == null ? [] : List<dynamic>.from(genreIds!.map((x) => x)),
        "releaseDate": releaseDate?.toIso8601String(),
        "trackId": trackId,
        "trackName": trackName,
        "primaryGenreName": primaryGenreName,
        "primaryGenreId": primaryGenreId,
        "sellerName": sellerName,
        "isVppDeviceBasedLicensingEnabled": isVppDeviceBasedLicensingEnabled,
        "averageUserRatingForCurrentVersion":
            averageUserRatingForCurrentVersion,
        "languageCodesISO2A": languageCodesIso2A == null
            ? []
            : List<dynamic>.from(languageCodesIso2A!.map((x) => x)),
        "fileSizeBytes": fileSizeBytes,
        "sellerUrl": sellerUrl,
        "formattedPrice": formattedPrice,
        "userRatingCountForCurrentVersion": userRatingCountForCurrentVersion,
        "trackContentRating": trackContentRating,
        "minimumOsVersion": minimumOsVersion,
        "version": version,
        "wrapperType": wrapperType,
        "userRatingCount": userRatingCount,
        "collectionType": collectionType,
        "collectionId": collectionId,
        "amgArtistId": amgArtistId,
        "collectionName": collectionName,
        "collectionCensoredName": collectionCensoredName,
        "collectionViewUrl": collectionViewUrl,
        "collectionPrice": collectionPrice,
        "collectionExplicitness": collectionExplicitness,
        "trackCount": trackCount,
        "copyright": copyright,
        "country": country,
        "collectionArtistName": collectionArtistName,
        "previewUrl": previewUrl,
        "artworkUrl30": artworkUrl30,
        "trackPrice": trackPrice,
        "trackExplicitness": trackExplicitness,
        "discCount": discCount,
        "discNumber": discNumber,
        "trackNumber": trackNumber,
        "trackTimeMillis": trackTimeMillis,
        "isStreamable": isStreamable,
      };
}
