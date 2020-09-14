import 'package:bodytime/configurations.dart';
import 'package:bodytime/models/file_info.dart';

const qualities = {
  'XSmall': 1,
  'Small': 2,
  'Medium': 3,
  'Large': 4,
  'XLarge': 5
};

const qualityStrings = ['_xsmall', '_small', '_medium', '_large', '_xlarge'];

class ImageUtils {
  static getImageSource(FileInfo file, int quality) {
    var serverUrl = getWebserviceUrl().replaceAll('api/', '');

    if (file == null) {
      return null;
    }

    if (file.quality == null) {
      return serverUrl + file.source;
    }

    if (quality > file.quality) {
      quality = file.quality;
    }

    var dotIndex = file.source.lastIndexOf('.');

    return serverUrl +
        file.source.substring(0, dotIndex) +
        qualityStrings[quality - 1] +
        file.source.substring(dotIndex, file.source.length);
  }
}
