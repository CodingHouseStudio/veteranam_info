import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:path_drawing/path_drawing.dart';
import 'package:xml/xml.dart';

// coverage:ignore-file
class SvgImageWidget extends StatelessWidget {
  const SvgImageWidget({
    required this.path,
    super.key, // Optional key
  });

  final String path;

  @override
  Widget build(BuildContext context) {
    return FutureBuilder<VectorImage>(
      future: _loadSvgAsset(path),
      builder: (context, snapshot) {
        if (snapshot.hasData) {
          return CustomPaint(
            painter: VectorImagePainter(snapshot.data!),
          );
        }
        return const SizedBox.shrink();
      },
    );
  }
}

class VectorImagePainter extends CustomPainter {
  VectorImagePainter(this.vectorImage);
  final VectorImage vectorImage;

  @override
  void paint(Canvas canvas, Size size) {
    final svgSize = vectorImage.size ?? Size(size.width, size.height);
    if (size.height > 60) {
      // Calculate the scaling factor
      final scaleX = size.width / svgSize.width;
      final scaleY = size.height / svgSize.height;
      final scale = scaleX < scaleY ? scaleX : scaleY;

      // Calculate the translation to center the SVG
      final offsetX = (size.width - svgSize.width * scale) / 2;
      final offsetY = (size.height - svgSize.height * scale) / 2;

      // Save the current canvas state
      canvas
        ..save()

        // Apply scaling and translation
        ..translate(offsetX, offsetY)
        ..scale(scale);

      // Draw each path in the vector image
      for (final item in vectorImage.items) {
        final paint = Paint()
          ..color = item.fill ?? Colors.black
          ..style = PaintingStyle.fill;
        canvas.drawPath(item.path, paint);
      }

      // Restore the canvas state
      canvas.restore();
    } else {
      final offsetX = (size.width - svgSize.width) / 2;
      final offsetY = (size.height - svgSize.height) / 2;

      // Draw each path in the vector image without scaling
      for (final item in vectorImage.items) {
        if (item.fill != null) {
          final paint = Paint()
            ..color = item.fill!
            ..style = PaintingStyle.fill;

          canvas.drawPath(item.path.shift(Offset(offsetX, offsetY)), paint);
        } else {
          _drawPathWithThinLines(canvas, item.path, offsetX, offsetY);
        }
      }
    }
  }

  void _drawPathWithThinLines(
    Canvas canvas,
    Path path,
    double offsetX,
    double offsetY,
  ) {
    final paint = Paint()
      ..color = Colors.black
      ..style = PaintingStyle.stroke
      ..strokeWidth = 1.0; // Adjust as needed for line thickness

    canvas.drawPath(path.shift(Offset(offsetX, offsetY)), paint);
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) => false;
}

class VectorImage {
  const VectorImage({
    required this.items,
    this.size,
  });

  final List<PathSvgItem> items;
  final Size? size;
}

class PathSvgItem {
  const PathSvgItem({
    required this.path,
    this.fill,
  });

  final Path path;
  final Color? fill;
}

Future<VectorImage> _loadSvgAsset(String assetName) async {
  final svgData = await rootBundle.loadString(assetName);
  return getVectorImageFromStringXml(svgData);
}

VectorImage getVectorImageFromStringXml(String svgData) {
  final items = <PathSvgItem>[];

  // step 1: parse the xml
  final document = XmlDocument.parse(svgData);

  // step 2: get the size of the svg
  Size? size;
  var width = document.findAllElements('svg').first.getAttribute('width');
  var height = document.findAllElements('svg').first.getAttribute('height');
  final viewBox = document.findAllElements('svg').first.getAttribute('viewBox');
  if (width != null && height != null) {
    width = width.replaceAll(RegExp('[^0-9.]'), '');
    height = height.replaceAll(RegExp('[^0-9.]'), '');
    size = Size(double.parse(width), double.parse(height));
  } else if (viewBox != null) {
    final viewBoxList = viewBox.split(' ');
    size = Size(double.parse(viewBoxList[2]), double.parse(viewBoxList[3]));
  }

  // step 3: get the paths
  final paths = document.findAllElements('path').toList();
  for (var i = 0; i < paths.length; i++) {
    final element = paths[i];

    // get the path
    final pathString = element.getAttribute('d');
    if (pathString == null) {
      continue;
    }
    final path = parseSvgPathData(pathString);

    // get the fill color
    var fill = element.getAttribute('fill');
    if (fill == null) {
      final style = element.getAttribute('style');
      if (style != null) {
        fill = _getFillColor(style);
      }
    }

    items.add(
      PathSvgItem(
        fill: _getColorFromString(fill),
        path: path,
      ),
    );
  }

  return VectorImage(items: items, size: size);
}

String? _getFillColor(String data) {
  final regExp = RegExp(r'fill:\s*(#[a-fA-F0-9]{6})');
  final match = regExp.firstMatch(data);
  return match?.group(1);
}

Color _hexToColor(String hex) {
  final buffer = StringBuffer();
  if (hex.length == 6 || hex.length == 7) buffer.write('ff');
  buffer.write(hex.replaceFirst('#', ''));
  return Color(int.parse(buffer.toString(), radix: 16));
}

Color? _getColorFromString(String? colorString) {
  if (colorString == null) return null;
  if (colorString.startsWith('#')) {
    return _hexToColor(colorString);
  } else {
    switch (colorString) {
      // case 'red':
      //   return Colors.red;
      // case 'green':
      //   return Colors.green;
      // case 'blue':
      //   return Colors.blue;
      // case 'yellow':
      //   return Colors.yellow;
      case 'white':
        return Colors.white;
      case 'black':
        return Colors.black;
      default:
        return Colors.transparent;
    }
  }
}
