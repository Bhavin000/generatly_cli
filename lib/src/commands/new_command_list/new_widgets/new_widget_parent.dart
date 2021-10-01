import 'package:args/command_runner.dart';
import 'package:generatly_cli/src/bundles/bundles.dart';
import 'package:generatly_cli/src/utils/utils.dart';
import 'package:io/io.dart';
import 'package:mason/mason.dart';

class NewWidgetParent extends Command<int> {
  Logger logger;
  String get outPath => 'src/presentation/widgets/';
  NewWidgetParent({required this.logger});

  @override
  String get description => throw UnimplementedError();

  @override
  String get name => throw UnimplementedError();

  @override
  Future<int> run() async {
    return ExitCode.success.code;
  }

  Future<void> createNewWidget(String name, MasonBundle bundle) async {
    final _temp = FileUtil('./lib/$outPath' + name + '.dart');
    if (await _temp.isExists) {
      logger.err('File already Exists!!!');
      return;
    }
    await generateWidgetTemplate(bundle, name);
    logger.success('$name created successfully.');
  }

  Future<void> generateWidgetTemplate(MasonBundle bundle, String _name) async {
    final Map<String, dynamic> vars = {
      "name": _name,
    };
    try {
      await MasonUtil.generateFile(
        './lib/$outPath',
        bundle,
        {},
      );
      await MasonUtil.generateFile(
        './test/$outPath',
        testBundle,
        vars,
      );
    } catch (err) {
      logger.err(err.toString());
    }
  }
}
