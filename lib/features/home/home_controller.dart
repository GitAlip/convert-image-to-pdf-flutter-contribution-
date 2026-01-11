import 'dart:io';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:image_to_pdf/data/services/media_service.dart';

class HomeController extends ChangeNotifier {
  final MediaService _mediaService = MediaService();

  final List<File> _selectedImages = [];
  List<File> get selectedImages => _selectedImages;

  bool get hasImages => _selectedImages.isNotEmpty;

  Future<void> pickImages() async {
    final List<XFile> images = await _mediaService.pickImages();
    if (images.isNotEmpty) {
      _selectedImages.addAll(images.map((x) => File(x.path)));
      notifyListeners();
    }
  }

  void clearImages() {
    _selectedImages.clear();
    notifyListeners();
  }

  void removeImage(int index) {
    if (index >= 0 && index < _selectedImages.length) {
      _selectedImages.removeAt(index);
      notifyListeners();
    }
  }
}
