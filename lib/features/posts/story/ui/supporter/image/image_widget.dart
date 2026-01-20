import 'package:akalpit/core/constants/app_colors.dart';
import 'package:akalpit/features/posts/story/ui/supporter/image/models/image_model_widget.dart';
import 'package:flutter/material.dart';
 

class ImageBlockWidget extends StatelessWidget {
  final ImageBlockModel model;

  const ImageBlockWidget({required this.model, Key? key}) : super(key: key);

  static const double _thumbnailHeight = 350; // small preview height

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        GestureDetector(
          onTap: () => _openFullScreenViewer(context),
          child: Align(
            alignment: model.alignment,
            child: Hero(
              tag: model.url,
              child: ClipRRect(
                borderRadius: BorderRadius.circular(12),
                child: Container(
                  width: double.infinity,
                  height: _thumbnailHeight,
                  color: AppColors.cardBackground,
                  child: Image.network(
                    model.url,
                    fit: BoxFit.contain, // ✅ show full image without cropping
                    alignment: Alignment.center,
                    errorBuilder: (_, __, ___) => _errorBox(),
                  ),
                ),
              ),
            ),
          ),
        ),

        if (model.caption != null)
          Padding(
            padding: const EdgeInsets.only(top: 6),
            child: Text(
              model.caption!,
              textAlign: TextAlign.center,
              style: TextStyle(
                color: Colors.grey.shade400,
                fontSize: 13,
                fontStyle: FontStyle.italic,
              ),
            ),
          ),
      ],
    );
  }

  Widget _errorBox() {
    return Container(
      width: double.infinity,
      height: _thumbnailHeight,
      color: Colors.grey.shade300,
      alignment: Alignment.center,
      child: Text(model.alt ?? "Image not available"),
    );
  }

  void _openFullScreenViewer(BuildContext context) {
    Navigator.of(context).push(
      MaterialPageRoute(
        builder: (_) => _FullScreenImageViewer(imageUrl: model.url),
      ),
    );
  }
}

class _FullScreenImageViewer extends StatelessWidget {
  final String imageUrl;

  const _FullScreenImageViewer({required this.imageUrl});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      body: GestureDetector(
        onTap: () => Navigator.pop(context),
        child: Stack(
          children: [
            Positioned.fill(
              child: Hero(
                tag: imageUrl,
                child: InteractiveViewer(
                  panEnabled: true,
                  scaleEnabled: true,
                  minScale: 1,
                  maxScale: 6,
                  child: Image.network(
                    imageUrl,
                    fit: BoxFit.contain, // preserves aspect ratio
                    width: double.infinity,
                    height: double.infinity,
                  ),
                ),
              ),
            ),
            Positioned(
              top: 40,
              right: 20,
              child: IconButton(
                icon: const Icon(Icons.close, color: Colors.white, size: 30),
                onPressed: () => Navigator.pop(context),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
