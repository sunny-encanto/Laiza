import 'package:file_picker/file_picker.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:image_cropper/image_cropper.dart';
import 'package:image_picker/image_picker.dart';
import 'package:path/path.dart' as p;

import '../../core/app_export.dart';

class MediaServices {
  static Future<String?> pickImageFromGallery() async {
    final pickedImage =
        await ImagePicker().pickImage(source: ImageSource.gallery);
    if (pickedImage != null) {
      return pickedImage.path;
    }
    return null;
  }

  static Future<Media?> pickFilePathAndExtension() async {
    try {
      const int maxSizeBytes = 100 * 1024 * 1024; // 10 MB
      FilePickerResult? result = await FilePicker.platform
          .pickFiles(allowCompression: true, compressionQuality: maxSizeBytes);
      if (result != null) {
        String? filePath = result.files.single.path;
        String? fileName = result.files.single.name;
        String? fileExtension = p.extension(filePath ?? "");
        if (result.files.single.size > maxSizeBytes) {
          Fluttertoast.showToast(msg: 'Size more Then 100 Mb Cant be Selected');
        } else {
          return Media.fromJson(
              {'path': filePath, 'extension': fileExtension, 'name': fileName});
        }
        return null;
      } else {
        return null;
      }
    } catch (e) {
      return null;
    }
  }

  static Future<Media?> pickVideoPathAndExtension() async {
    try {
      const int maxSizeBytes = 20 * 1024 * 1024; // 10 MB
      FilePickerResult? result = await FilePicker.platform.pickFiles(
        allowCompression: true,
        compressionQuality: maxSizeBytes,
        type: FileType.video, // Restrict to video files
      );
      if (result != null) {
        String? filePath = result.files.single.path;
        String? fileName = result.files.single.name;
        String? fileExtension = p.extension(filePath ?? "");
        if (result.files.single.size > maxSizeBytes) {
          Fluttertoast.showToast(msg: 'Size more Then 20 Mb Cant be Selected');
        } else {
          return Media.fromJson(
              {'path': filePath, 'extension': fileExtension, 'name': fileName});
        }
        return null;
      } else {
        return null;
      }
    } catch (e) {
      return null;
    }
  }

  static Future<String> recordVideo() async {
    final pickVideo = await ImagePicker().pickVideo(
        source: ImageSource.camera, maxDuration: const Duration(seconds: 30));
    if (pickVideo != null) {
      return pickVideo.path;
    }
    return '';
  }

  static Future<String?> cropImage(String imageFile) async {
    final CroppedFile? croppedFile = await ImageCropper().cropImage(
      sourcePath: imageFile,
      aspectRatioPresets: [
        // CropAspectRatioPreset.square,
        // CropAspectRatioPreset.ratio3x2,
        // CropAspectRatioPreset.original,
        CropAspectRatioPreset.ratio4x3,
        // CropAspectRatioPreset.ratio16x9
      ],
      uiSettings: [
        AndroidUiSettings(
          toolbarTitle: 'Crop Image',
          toolbarColor: AppColor.primary,
          toolbarWidgetColor: Colors.white,
          initAspectRatio: CropAspectRatioPreset.original,
          lockAspectRatio: true,
        ),
        IOSUiSettings(
          title: 'Crop Image',
          minimumAspectRatio: 1.0,
        ),
      ],
    );
    return croppedFile?.path;
  }
}

class Media {
  final String path;
  final String name;

  final String fileExtension;

  Media({required this.path, required this.name, required this.fileExtension});

  factory Media.fromJson(Map<String, dynamic> json) => Media(
      path: json['path'], name: json['name'], fileExtension: json['extension']);
}
