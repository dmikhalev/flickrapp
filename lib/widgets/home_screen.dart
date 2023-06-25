import 'package:FlickrApp/stores/store.dart';

import '../photos/actions/get_photos_thunk_action.dart';
import '../stores/app_state.dart';
import '../widgets/image_container.dart';
import '../widgets/image_dialog.dart';
import 'package:flutter/material.dart';
import 'package:flutter_redux/flutter_redux.dart';

class HomeScreen extends StatefulWidget {
  final String title;

  const HomeScreen({Key? key, required this.title}) : super(key: key);

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  int page = 1;
  late ScrollController _controller;

  @override
  void initState() {
    _controller = ScrollController();
    _controller.addListener(_scrollListener);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Colors.black87,
        appBar: AppBar(
          title: Text(widget.title),
          backgroundColor: Colors.black,
          centerTitle: true,
        ),
        body: StoreConnector<AppState, AppState>(
          converter: (store) => store.state,
          builder: (context, appState) {
            return Align(
              alignment: Alignment.center,
              child: SizedBox(
                height: 700,
                width: 360,
                child: ListView.builder(
                    controller: _controller,
                    itemCount: store.state.photoImages.isNotEmpty
                        ? store.state.photoImages.length
                        : 1,
                    itemBuilder: (BuildContext context, int index) {
                      return store.state.photoImages.isNotEmpty
                          ? OutlinedButton(
                              onPressed: () {
                                showDialog(
                                  context: context,
                                  builder: (context) => ImageDialog(
                                    index: index,
                                  ),
                                );
                              },
                              child: ImageContainer(
                                index: index,
                              ))
                          : const Center(
                              child: Text(
                                'Ожидание...',
                                style: TextStyle(
                                    color: Colors.white, fontSize: 20),
                              ),
                            );
                    }),
              ),
            );
          },
        ));
  }

  _scrollListener() {
    if (_controller.offset >= _controller.position.maxScrollExtent &&
        !_controller.position.outOfRange) {
      store.dispatch(getPhotoThunkAction(++page));
    }
  }
}
