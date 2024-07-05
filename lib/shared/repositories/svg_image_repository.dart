import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:path_drawing/path_drawing.dart';
import 'package:veteranam/shared/shared.dart';
import 'package:xml/xml.dart';

abstract class SvgImageRepository {
  static Future<VectorImage?> loadSvgAsset(String assetName) async {
    try {
      final svgData = await rootBundle.loadString(assetName);
      return _getVectorImageFromStringXml(svgData);
    } catch (e) {
      return null;
    }
  }

  static VectorImage _getVectorImageFromStringXml(String svgData) {
    final items = <PathSvgItem>[];

    // step 1: parse the xml
    final document = XmlDocument.parse(svgData);

    // step 2: get the size of the svg
    Size? size;
    var width = document.findAllElements('svg').first.getAttribute('width');
    var height = document.findAllElements('svg').first.getAttribute('height');
    final viewBox =
        document.findAllElements('svg').first.getAttribute('viewBox');
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

  static String? _getFillColor(String data) {
    final regExp = RegExp(r'fill:\s*(#[a-fA-F0-9]{6})');
    final match = regExp.firstMatch(data);
    return match?.group(1);
  }

  static Color _hexToColor(String hex) {
    final buffer = StringBuffer();
    if (hex.length == 6 || hex.length == 7) buffer.write('ff');
    buffer.write(hex.replaceFirst('#', ''));
    return Color(int.parse(buffer.toString(), radix: 16));
  }

  static Color? _getColorFromString(String? colorString) {
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
}
