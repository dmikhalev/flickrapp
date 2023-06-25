import 'package:FlickrApp/photos/models/photo.dart';
import 'package:FlickrApp/stores/store.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:redux/redux.dart';
import 'package:redux_thunk/redux_thunk.dart';
import 'photos_action.dart';

ThunkAction getPhotoThunkAction(int page) {
  return (Store store) async {
    Uri uri = Uri.parse(
        "https://www.flickr.com/services/rest/?method=flickr.photos.getPopular&api_key=baad74872a87835b1b407a608d86058f&format=json&user_id=151794345@N05&page=$page&per_page=10");
    var response = await http.get(uri);
    if (response.statusCode != 200) {
      Exception('Request failed with status: ${response.statusCode}.');
    }
    var body = "";
    if (response.body.startsWith("jsonFlickrApi(")) {
      body = response.body.substring(14, response.body.length - 1);
    }
    PhotoData photoData = PhotoData.fromJson(body);
    for (Photo photo in photoData.photoPage.photos) {
      store.dispatch(
          getPhotoImageThunkAction(photo.server, photo.id, photo.secret));
    }
  };
}

ThunkAction<Image> getPhotoImageThunkAction(
    String serverId, String photoId, String secret) {
  return (Store localStore) async {
    String url =
        'https://live.staticflickr.com/$serverId/${photoId}_$secret.jpg';
    Uri uri = Uri.parse(url);
    var response = await http.get(uri);
    if (response.statusCode != 200) {
      Exception('Request failed with status: ${response.statusCode}.');
    }
    List<PhotoImage> photoImages = store.state.photoImages;
    photoImages.add(PhotoImage(image: Image.network(url)));
    localStore.dispatch(PhotoImagesAction(photoImages: photoImages));
  };
}
