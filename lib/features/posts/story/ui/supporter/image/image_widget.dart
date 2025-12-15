import 'package:akalpit/features/posts/story/ui/supporter/image/models/image_model_widget.dart';
import 'package:flutter/material.dart';
 
class ImageBlockWidget extends StatelessWidget {
  final ImageBlockModel model;

  const ImageBlockWidget({required this.model, Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        GestureDetector(
          onTap: () => _openImageViewer(context),
          child: Align(
            alignment: model.alignment,
            child: Hero(
              tag: model.url, // Smooth animation when opening
              child: Image.network(
                model.url,
                width: model.width,
                height: model.height,
                fit: BoxFit.cover,
                errorBuilder: (context, error, stackTrace) => 
                    Container(
                      width: model.width ?? 100,
                      height: model.height ?? 100,
                      color: Colors.grey.shade300,
                      alignment: Alignment.center,
                      child: Text(model.alt ?? "Image not available"),
                    ),
              ),
            ),
          ),
        ),

        if (model.caption != null)
          Padding(
            padding: const EdgeInsets.only(top: 4.0),
            child: Text(
              model.caption!,
              textAlign: TextAlign.center,
              style: TextStyle(color: Colors.grey.shade400),
            ),
          ),
      ],
    );
  }

  void _openImageViewer(BuildContext context) {
    showDialog(
      context: context,
      barrierColor: Colors.black.withValues(alpha: 0.7), 
      builder: (_) => GestureDetector(
        onTap: () => Navigator.pop(context),
        child: Stack(
          children: [
            Center(
              child: Hero(
                tag: model.url,
                child: InteractiveViewer(
                  maxScale: 6.0,
                  minScale: 1.0,
                  child: Image.network(model.url),
                ),
              ),
            ),
            Positioned(
              right: 16,
              top: 30,
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
