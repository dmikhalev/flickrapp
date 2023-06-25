import '../photos/reducers/get_photos_reducer.dart';
import 'package:FlickrApp/stores/app_state.dart';

AppState reducer(AppState state, dynamic action) =>
    AppState(photoImages: getPhotoImagesReducer(state.photoImages, action));
