import 'package:FlickrApp/widgets/image_container.dart';
import 'package:flutter/material.dart';

class ImageDialog extends StatefulWidget {
  const ImageDialog({
    Key? key,
    required this.index,
  }) : super(key: key);
  final int index;

  @override
  State<ImageDialog> createState() => _ImageDialogState();
}

class _ImageDialogState extends State<ImageDialog> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      appBar: AppBar(
        backgroundColor: Colors.transparent,
      ),
      body: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            ImageContainer(
              index: widget.index,
            )
          ]),
    );
  }
}
