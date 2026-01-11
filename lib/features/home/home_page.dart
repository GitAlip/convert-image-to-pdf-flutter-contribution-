import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:image_to_pdf/core/theme/app_theme.dart';
import 'package:image_to_pdf/features/home/home_controller.dart';
import 'package:image_to_pdf/features/pdf/pdf_preview_page.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final HomeController _controller = HomeController();

  @override
  void initState() {
    super.initState();
    // Simple listener to rebuild UI on change
    _controller.addListener(() {
      if (mounted) setState(() {});
    });
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Convert Images to PDF"),
      ),
      body: Column(
        children: [
          // Action Buttons Area
          Padding(
            padding: const EdgeInsets.all(16.0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                _buildActionButton(
                  context,
                  label: 'Gallery',
                  iconPath: 'lib/assets/image-file.svg',
                  onTap: () async {
                    try {
                      await _controller.pickImages();
                    } catch (e) {
                      if (context.mounted) {
                        ScaffoldMessenger.of(context).showSnackBar(
                          SnackBar(content: Text('Failed to pick images: $e')),
                        );
                      }
                    }
                  },
                ),
                _buildActionButton(
                  context,
                  label: 'Create PDF',
                  iconPath: 'lib/assets/pdf2.svg',
                  // Only enable if images exist
                  onTap: _controller.hasImages 
                    ? () {
                        Navigator.push(
                          context, 
                          MaterialPageRoute(
                            builder: (_) => PdfPreviewPage(images: _controller.selectedImages)
                          )
                        );
                      }
                    : null,
                ),
                _buildActionButton(
                  context,
                  label: 'Clear',
                  iconPath: 'lib/assets/remove.svg',
                  onTap: _controller.clearImages,
                ),
              ],
            ),
          ),
          
          // Counter
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16.0),
            child: Text(
              "Selected Images: ${_controller.selectedImages.length}",
              style: Theme.of(context).textTheme.headlineMedium,
            ),
          ),
          
          const SizedBox(height: 10),

          // Grid View
          Expanded(
            child: _controller.hasImages
                ? GridView.builder(
                    padding: const EdgeInsets.all(8),
                    gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                      crossAxisCount: 3,
                      crossAxisSpacing: 8,
                      mainAxisSpacing: 8,
                    ),
                    itemCount: _controller.selectedImages.length,
                    itemBuilder: (context, index) {
                      return Stack(
                        fit: StackFit.expand,
                        children: [
                          ClipRRect(
                            borderRadius: BorderRadius.circular(8),
                            child: Image.file(
                              _controller.selectedImages[index],
                              fit: BoxFit.cover,
                            ),
                          ),
                          Positioned(
                            top: 4,
                            right: 4,
                            child: Tooltip(
                              message: "Remove image",
                              child: Semantics(
                                label: "Remove image",
                                button: true,
                                child: GestureDetector(
                                  onTap: () => _controller.removeImage(index),
                                  child: const CircleAvatar(
                                    radius: 12,
                                    backgroundColor: Colors.red,
                                    child: Icon(Icons.close, size: 16, color: Colors.white),
                                  ),
                                ),
                              ),
                            ),
                          )
                        ],
                      );
                    },
                  )
                : Center(
                    child: Text(
                      "No images selected",
                      style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                        color: Colors.grey,
                      ),
                    ),
                  ),
          ),
        ],
      ),
    );
  }

  Widget _buildActionButton(BuildContext context, {
    required String label, 
    required String iconPath, 
    VoidCallback? onTap
  }) {
    final bool isEnabled = onTap != null;
    return GestureDetector(
      onTap: onTap,
      child: Opacity(
        opacity: isEnabled ? 1.0 : 0.5,
        child: Container(
          width: MediaQuery.of(context).size.width * 0.28,
          height: 120,
          decoration: BoxDecoration(
            color: AppColors.primary,
            borderRadius: BorderRadius.circular(16),
            boxShadow: isEnabled ? [
              BoxShadow(
                color: Colors.black.withOpacity(0.2),
                blurRadius: 8,
                offset: const Offset(2, 4),
              )
            ] : [],
          ),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              SvgPicture.asset(
                iconPath,
                width: 40,
                colorFilter: const ColorFilter.mode(Colors.white, BlendMode.srcIn),
              ),
              const SizedBox(height: 8),
              Text(
                label,
                style: GoogleFonts.pangolin(
                  color: Colors.white,
                  fontSize: 16,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
