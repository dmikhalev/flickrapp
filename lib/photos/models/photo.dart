import 'dart:convert';

import 'package:flutter/material.dart';

class Photo {
  final String id;
  final String owner;
  final String secret;
  final String server;
  final int farm;
  final String title;
  final bool isPublic;
  final bool isPrimary;
  final bool hasComment;

  Photo(
      {required this.id,
      required this.owner,
      required this.secret,
      required this.server,
      required this.farm,
      required this.title,
      required this.isPublic,
      required this.isPrimary,
      required this.hasComment});

  factory Photo.fromJson(Map<String, dynamic> json) {
    final id = json["id"] as String;
    final owner = json["owner"] as String;
    final secret = json["secret"] as String;
    final server = json["server"] as String;
    final farm = json["farm"] as int;
    final title = json["title"] as String;
    final isPublic = json["ispublic"] == 1 ? true : false;
    final isPrimary = json["is_primary"] == 1 ? true : false;
    final hasComment = json["has_comment"] == 1 ? true : false;
    return Photo(
        id: id,
        owner: owner,
        secret: secret,
        server: server,
        farm: farm,
        title: title,
        isPublic: isPublic,
        isPrimary: isPrimary,
        hasComment: hasComment);
  }
}

class PhotoData {
  final PhotoPage photoPage;
  final String stat;

  PhotoData({required this.photoPage, required this.stat});

  factory PhotoData.fromJson(String body) {
    final parsedPhotos = jsonDecode(body);
    final photoPage = PhotoPage.fromJson(parsedPhotos["photos"]);
    final stat = parsedPhotos["stat"] as String;
    return PhotoData(photoPage: photoPage, stat: stat);
  }
}

class PhotoPage {
  final int page;
  final int pages;
  final int perpage;
  final int total;
  final List<Photo> photos;

  PhotoPage(
      {required this.page,
      required this.pages,
      required this.perpage,
      required this.total,
      required this.photos});

  factory PhotoPage.fromJson(Map<String, dynamic> json) {
    final page = json["page"] as int;
    final pages = json["pages"] as int;
    final perpage = json["perpage"] as int;
    final total = json["total"] as int;
    final photosData = json["photo"] as List<dynamic>?;
    final photos = photosData != null
        ? photosData.map((photoData) => Photo.fromJson(photoData)).toList()
        : <Photo>[];
    return PhotoPage(
        page: page,
        pages: pages,
        perpage: perpage,
        total: total,
        photos: photos);
  }
}

class PhotoImage {
  final Image image;
  bool isLiked = false;

  PhotoImage({required this.image});
}