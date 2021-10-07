import 'package:args/command_runner.dart';
import 'package:generatly_cli/src/bundles/bundles.dart';
import 'package:generatly_cli/src/utils/utils.dart';
import 'package:io/io.dart';
import 'package:mason/mason.dart';
import 'package:recase/recase.dart';
import 'package:universal_io/io.dart';

class StarterCommand extends Command<int> {
  final Logger logger;
  StarterCommand({required this.logger});

  @override
  String get description => 'create starter template';

  @override
  String get name => 'starter';

  @override
  Future<int> run() async {
    final String _appName = ReCase(argResults!.arguments[0]).snakeCase;
    logger.progress('creating flutter app');
    await runFlutterCreate(_appName);
    logger.progress('creating flutter app').call();
    logger.progress('creating template');
    await generateStarterTemplate(_appName);
    logger.progress('creating template').call();
    logger.success('$_appName created successfully!!!');
    await openVsCode(_appName);
    return ExitCode.success.code;
  }

  Future<void> runFlutterCreate(String _appName) async {
    try {
      await Process.run(
        'flutter',
        ['create', _appName],
        runInShell: true,
      );
      final file1 = FileUtil('./$_appName/test/widget_test.dart');
      if (await file1.isExists) {
        await file1.deleteFile();
      }
    } catch (err) {
      logger.err(err.toString());
    }
  }

  Future<void> generateStarterTemplate(String _appName) async {
    final Map<String, dynamic> starterVars = {
      "app_name": _appName,
    };
    try {
      await MasonUtil.generateFile(
        './$_appName',
        starterBundle,
        starterVars,
      );
    } catch (err) {
      logger.err(err.toString());
    }
  }

  Future<void> openVsCode(String _appName) async {
    try {
      await Process.run(
        'code',
        [_appName],
        runInShell: true,
      );
    } catch (err) {
      logger.err(err.toString());
    }
  }
}
