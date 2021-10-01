import 'dart:io';

class FileUtil {
  final String filePath;
  FileUtil(this.filePath);

  Future<List<String>?> readFileData() async {
    try {
      final file = File(filePath);
      return await file.readAsLines();
    } catch (err) {
      print(err);
    }
  }

  Future<void> appendListToFile(List<String> fileContent) async {
    try {
      final file = File(filePath);
      for (var content in fileContent) {
        await file.writeAsString(content + '\n', mode: FileMode.append);
      }
    } catch (err) {
      print(err);
    }
  }

  Future<void> writeStringToFile(String fileContent) async {
    try {
      final file = File(filePath);
      await file.writeAsString(fileContent, mode: FileMode.write);
    } catch (err) {
      print(err);
    }
  }

  Future<void> deleteFile() async {
    try {
      final file = File(filePath);
      await file.delete();
    } catch (err) {
      print(err);
    }
  }

  Future<bool> get isExists async {
    final file = File(filePath);
    return await file.exists();
  }

  String get getParentDirectory => splitPath(filePath, '/')
      .sublist(0, splitPath(filePath, '/').length - 1)
      .join('/');

  List<String> get getFileNameAndType =>
      splitPath(splitPath(filePath, '/').last, '.');

  List<String> splitPath(String _path, String _pattern) {
    return _path.split(_pattern);
  }
}
