import 'package:args/command_runner.dart';
import 'package:generatly_cli/src/bundles/bundles.dart';
import 'package:generatly_cli/src/utils/utils.dart';
import 'package:io/io.dart';
import 'package:mason/mason.dart';
import 'package:watcher/watcher.dart';

class RunServerCommand extends Command<int> {
  final Logger logger;
  RunServerCommand({required this.logger});

  @override
  String get description => 'run background server for flutter project';

  @override
  String get name => 'run_server';

  @override
  Future<int> run() async {
    watchDirectory('./');
    return ExitCode.success.code;
  }

  watchDirectory(String dirPath) {
    DirectoryWatcher(dirPath).events.listen((event) async {
      final fileUtil = FileUtil(event.path);
      switch (event.type) {
        case ChangeType.ADD:
          await addFileEvent(fileUtil);
          break;
        case ChangeType.MODIFY:
          break;
        case ChangeType.REMOVE:
          break;
        default:
          break;
      }
    });
  }

  Future<void> addFileEvent(FileUtil fileUtil) async {
    switch (fileUtil.getFileNameAndType[1]) {
      case 'stl':
        await fileUtil.deleteFile();
        await MasonUtil.generateFile(
          fileUtil.getParentDirectory,
          stlBundle,
          {"name": fileUtil.getFileNameAndType[0]},
        );
        break;
      case 'stf':
        await fileUtil.deleteFile();
        await MasonUtil.generateFile(
          fileUtil.getParentDirectory,
          stfBundle,
          {"name": fileUtil.getFileNameAndType[0]},
        );
        break;
      default:
        break;
    }
  }
}
