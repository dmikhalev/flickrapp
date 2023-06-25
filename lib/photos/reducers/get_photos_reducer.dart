import 'package:FlickrApp/photos/actions/photos_action.dart';
import 'package:FlickrApp/photos/models/photo.dart';

List<PhotoImage> getPhotoImagesReducer(
    List<PhotoImage> photoImages, dynamic action) {
  if (action is PhotoImagesAction) {
    return action.photoImages;
  }
  return photoImages;
}
