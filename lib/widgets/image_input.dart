import 'package:flutter/material.dart';
import 'dart:io';
import 'package:image_picker/image_picker.dart';
import 'package:path/path.dart' as path;
import 'package:path_provider/path_provider.dart' as sysPaths;

class ImageInput extends StatefulWidget {
  // ImageInput({Key key}) : super(key: key);

  final Function onSelectImage;

  ImageInput({this.onSelectImage});

  @override
  _ImageInputState createState() => _ImageInputState();
}

class _ImageInputState extends State<ImageInput> {
  File _storedImage;

  Future<void> _takePicture() async {
    final imageFile = await ImagePicker.pickImage(
      source: ImageSource.camera,
      maxWidth: 600,
    );

    setState(() {
      _storedImage = imageFile;
    });

    /* About our app path for storing data
    Both in android and iOS we have certain
    restrictions about where and how we should
    store files in the host device.

    This because possible security issues.
    
    When we are calling getApplicationDocumentsDirectory()
    method we actually are getting the default 
    path assigned to our application by the 
    host system.

    When we are calling getTemporaryDirectory()
    method we actually are getting the path 
    to a temp directory which will be cleaned
    by the system after an amount of time.
    So this is not very recommended in cases
    where you need to store persistent/relevant
    data locally. 
     */

    final appDirectory = await sysPaths.getApplicationDocumentsDirectory();
    //Getting the default image name
    //assigned by the system, including
    //the extension.
    final fileName = path.basename(imageFile.path);
    //writing file on the device
    final savedImage = await imageFile.copy('${appDirectory.path}/$fileName');

    widget.onSelectImage();
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Row(
      children: <Widget>[
        Container(
          height: 100,
          width: 105,
          alignment: Alignment.center,
          decoration:
              BoxDecoration(border: Border.all(width: 1, color: Colors.grey)),
          child: _storedImage != null
              ? Image.file(
                  _storedImage,
                  fit: BoxFit.cover,
                  width: double.infinity,
                )
              : Text(
                  'No Image Taken',
                  textAlign: TextAlign.center,
                ),
        ),
        SizedBox(
          width: 10,
        ),
        Expanded(
          child: FlatButton.icon(
            icon: Icon(Icons.camera),
            label: Text(
              'Take picture',
            ),
            textColor: Theme.of(context).primaryColor,
            onPressed: _takePicture,
          ),
        )
      ],
    );
  }
}
