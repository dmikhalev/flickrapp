import 'package:FlickrApp/photos/actions/get_photos_thunk_action.dart';
import 'package:FlickrApp/stores/store.dart';
import 'package:FlickrApp/widgets/home_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_redux/flutter_redux.dart';

void main() async {
  runApp(initScreen());
  store.dispatch(getPhotoThunkAction(1));
}

Widget initScreen() {
  return StoreProvider(
      store: store,
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        title: 'Flickr App',
        theme: ThemeData(
          primarySwatch: Colors.blue,
        ),
        home: const HomeScreen(title: 'Flickr Images'),
      ));
}
