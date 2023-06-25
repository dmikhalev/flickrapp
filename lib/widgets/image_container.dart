import 'package:FlickrApp/photos/actions/photos_action.dart';
import 'package:FlickrApp/stores/app_state.dart';
import 'package:FlickrApp/stores/store.dart';
import 'package:flutter/material.dart';
import 'package:flutter_redux/flutter_redux.dart';

class ImageContainer extends StatefulWidget {
  const ImageContainer({
    Key? key,
    required this.index,
  }) : super(key: key);
  final int index;

  @override
  State<ImageContainer> createState() => _ImageContainerState();
}

class _ImageContainerState extends State<ImageContainer> {
  @override
  Widget build(BuildContext context) {
    return StoreConnector<AppState, AppState>(
        converter: (store) => store.state,
        builder: (context, appState) {
          return Container(
            margin: const EdgeInsets.only(bottom: 16),
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(10),
              color: Colors.black12,
            ),
            child: Column(
              children: [
                ClipRRect(
                  borderRadius: BorderRadius.circular(10),
                  child: store.state.photoImages[widget.index].image,
                ),
                Container(
                    padding: const EdgeInsets.only(top: 4),
                    alignment: Alignment.bottomCenter,
                    child: store.state.photoImages[widget.index].isLiked
                        ? getIconButton(Icons.favorite)
                        : getIconButton(Icons.favorite_border))
              ],
            ),
          );
        });
  }

  IconButton getIconButton(IconData icon) {
    return IconButton(
        onPressed: () => {
              store.state.photoImages[widget.index].isLiked =
                  !store.state.photoImages[widget.index].isLiked,
              store.dispatch(
                  PhotoImagesAction(photoImages: store.state.photoImages))
            },
        icon: Icon(
          icon,
          size: 30,
          color: Colors.white,
          shadows: const <Shadow>[
            Shadow(color: Colors.black, blurRadius: 20.0)
          ],
        ));
  }
}
