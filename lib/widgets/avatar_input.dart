import 'dart:io';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';

class ImageInput extends StatefulWidget {
  final void selectImage;
  final String networkImage;
  const ImageInput(this.selectImage, this.networkImage, {super.key});

  @override
  State<ImageInput> createState() => _ImageInputState();
}

class _ImageInputState extends State<ImageInput> {
  File? _pickedImage;
  final _picker = ImagePicker();

  Future<void> _takeImage(source, context) async {
    final image = await _picker.pickImage(source: source, maxWidth: 300);

    if (image == null) {
      return;
    }
    setState(() {
      _pickedImage = File(image.path);
    });
  }

  Future<void> _dialogBuilder(BuildContext context) {
    return showDialog<void>(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text('Choose source'),
          content: const Text(
              'You can choose  a source of your avatar from camera or device gallery.'),
          actions: <Widget>[
            TextButton.icon(
              icon: Icon(Icons.image),
              label: Text('Gallery'),
              onPressed: () {
                _takeImage(ImageSource.gallery, context);
                Navigator.of(context).pop();
              },
            ),
            TextButton.icon(
              icon: Icon(Icons.camera),
              label: Text('Camera'),
              onPressed: () {
                _takeImage(ImageSource.camera, context);
                Navigator.of(context).pop();
              },
            ),
            SizedBox(
              width: 16,
            ),
            TextButton(
                onPressed: () {
                  Navigator.of(context).pop();
                },
                child: Text(
                  'Cancel',
                  style: TextStyle(color: Theme.of(context).colorScheme.error),
                )),
          ],
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    final color = Theme.of(context).colorScheme;
    return Stack(
      clipBehavior: Clip.none,
      children: [
        GestureDetector(
          onTap: () {
            _dialogBuilder(context);
          },
          child: CircleAvatar(
            radius: 65,
            backgroundColor: color.tertiary,
            child: CircleAvatar(
              radius: 60,
              backgroundImage: NetworkImage(widget.networkImage),
              foregroundImage:
                  _pickedImage != null ? FileImage(_pickedImage!) : null,
            ),
          ),
        ),
        Positioned(
          bottom: 0,
          right: -5,
          child: Container(
            alignment: Alignment.center,
            width: 30,
            height: 30,
            decoration: BoxDecoration(
                color: color.tertiary,
                borderRadius: BorderRadius.all(Radius.circular(25))),
            child: Icon(Icons.add, size: 30, color: color.onSecondary),
          ),
        )
      ],
    );
  }
}
