import 'dart:io';

import 'package:mason/mason.dart';

class MasonUtil {
  static Future<int> generateFile(
    String filePath,
    MasonBundle bundle,
    Map<String, dynamic> vars,
  ) async {
    final generator = await MasonGenerator.fromBundle(bundle);

    return await generator.generate(
      DirectoryGeneratorTarget(
        Directory(filePath),
        Logger(),
        FileConflictResolution.overwrite,
      ),
      vars: vars,
    );
  }
}
