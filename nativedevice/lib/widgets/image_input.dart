import 'dart:io';

import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:path/path.dart' as path;
import 'package:path_provider/path_provider.dart' as syspaths;

class ImageInput extends StatefulWidget {
  Function _setImage;
  ImageInput(this._setImage);
  @override
  _ImageInputState createState() => _ImageInputState();
}

class _ImageInputState extends State<ImageInput> {
  File _storedImage;

  /**File is the storage type in Android Phone */

  Future<void> _takePicture() async {
    /**As the camera will take picture and one will be back after the 
     * button is clicked hence the results would be in Future hence the function 
     * should be async and return type Future<void> */
    final ImagePicker _picker = ImagePicker();
    /** Get instance of ImagePicker */
    final imageFile = await _picker.pickImage(
      source: ImageSource.camera,
      /** Here Source Argument can be camera or gallery */
      maxWidth: 600, /** set maximum width of Image */
    );
    if (imageFile == null) {
      return;
    }

    /** In newer version the file returned by Image_picker 
       * is of type XFile and not the File.  Here we use imageFile.path which return 
       * a String containing the path of the file where the Image is stored. 
       * Hence we wrap this path into File constructor to get the File Object, which later
       * on used in Image.file(<File Object>), to render the image file on screen*/

    final appDir = await syspaths.getApplicationDocumentsDirectory();
/**syspaths is a path provider, this help to get he future of type directory. In Short it provides
 * the path where OS allowed to store the data of that application in device storage
*/
    final fileName = path.basename(imageFile.path);
    /**Gets the part of [path] after the last separator.
    p.basename('path/to/foo.dart'); // -> 'foo.dart'
    p.basename('path/to');          // -> 'to'
    Trailing separators are ignored.
    p.basename('path/to/'); // -> 'to'
    */
    final savedImage =
        await File(imageFile.path).copy('${appDir.path}/$fileName');
    /**It will Copy the Image from the path where android phone temporary stores data to the path 
     * which is allocated to the application by the Phone OS*/
    setState(() {
      _storedImage = savedImage;
    });
    widget._setImage(savedImage);
  }

  @override
  Widget build(BuildContext context) {
    return Row(
      children: <Widget>[
        Container(
          width: 150,
          height: 100,
          decoration: BoxDecoration(
            border: Border.all(width: 1, color: Colors.grey),
          ),
          child: _storedImage != null
              ? Image.file(
                  /**Image.file is used when we need to render real file. 
                   * It means Image is received from file and neither from
                   * network or assets folder. Other variants are Image.Networ()
                   * /NetworkImage()/image.assets()/AssetImage() */
                  _storedImage,
                  fit: BoxFit.cover,
                  width: double.infinity,
                )
              : Text(
                  'No Image Taken',
                  textAlign: TextAlign.center,
                ),
          alignment: Alignment.center,
        ),
        SizedBox(
          width: 10,
        ),
        Expanded(
          child: FlatButton.icon(
            icon: Icon(Icons.camera),
            label: Text('Take Picture'),
            textColor: Theme.of(context).primaryColor,
            onPressed: _takePicture,
          ),
        ),
      ],
    );
  }
}
