import 'package:generatly_cli/src/bundles/bundles.dart';
import 'package:generatly_cli/src/commands/new_command_list/new_command_parent.dart';
import 'package:generatly_cli/src/utils/utils.dart';
import 'package:io/io.dart';
import 'package:mason/mason.dart';
import 'package:recase/recase.dart';

class Navigator extends NewCommandParent {
  final Logger logr;
  final String appName;
  @override
  String get outPath => 'src/presentation/navigator/';
  final topNavPath =
      FileUtil('lib/src/presentation/navigator/top_navigator.dart');
  final botNavPath =
      FileUtil('lib/src/presentation/navigator/bottom_navigator.dart');

  Navigator(this.logr, this.appName) : super(logger: logr) {
    argParser
      ..addFlag('top', help: 'top navigator', negatable: false)
      ..addFlag('bottom', help: 'bottom navigator', negatable: false);
  }

  @override
  String get description => 'create navigator';

  @override
  String get name => 'navigator';

  @override
  Future<int> run() async {
    if (argResults!['top'] == true) {
      await createNewNavigator(
        'top_navigator',
        topNavigatorBundle,
        argResults!.rest,
      );
    } else if (argResults!['bottom'] == true) {
      await createNewNavigator(
        'bottom_navigator',
        bottomNavigatorBundle,
        argResults!.rest,
      );
    } else {
      logger.err('Enter valid arguments!!!');
    }
    return ExitCode.success.code;
  }

  Future<void> createNewNavigator(
    String name,
    MasonBundle bundle,
    List<String> _args,
  ) async {
    final _name = ReCase(name).snakeCase;
    final _temp = FileUtil('./lib/$outPath' + _name + '.dart');
    if (await _temp.isExists) {
      logger.err('File already Exists!!!');
      return;
    }
    await generateNavigatorTemplate(bundle);
    // await addExtraData(_name);
    logger.success('$_name created successfully.');

    for (var _name in _args) {
      await createNew(_name, stlBodyBundle);
      await addExtraData(_name);
    }
  }

  @override
  Future<void> createNew(String name, MasonBundle bundle) async {
    final _name = ReCase(name).snakeCase;
    final _temp = FileUtil('./lib/$outPath/screens/' + _name + '.dart');
    if (await _temp.isExists) {
      logger.err('File already Exists!!!');
      return;
    }
    await generateTemplate(bundle, _name);

    logger.success('$_name created successfully.');
  }

  Future<void> generateNavigatorTemplate(MasonBundle bundle) async {
    try {
      await MasonUtil.generateFile(
        './lib/$outPath',
        bundle,
        {},
      );
      await MasonUtil.generateFile(
        './test/$outPath',
        testBundle,
        {"name": "navigator_test.dart"},
      );
    } catch (err) {
      logger.err(err.toString());
    }
  }

  @override
  Future<void> generateTemplate(MasonBundle bundle, String _name) async {
    final Map<String, dynamic> vars = {
      "name": _name,
    };
    try {
      await MasonUtil.generateFile(
        './lib/$outPath/screens/',
        bundle,
        vars,
      );
      await MasonUtil.generateFile(
        './test/$outPath/screens/',
        testBundle,
        vars,
      );
    } catch (err) {
      logger.err(err.toString());
    }
  }

  @override
  Future<void> addExtraData(String _name) async {
    if (argResults!['top'] == true) {
      final topNavData = await topNavPath.readFileData();

      topNavData!.insert(1, tempScreenImport(appName, _name)[0]);

      int _idx = getValueIdx(topNavData, 'getScreenBody()') - 2;
      topNavData.insert(_idx, tempTab(_name)[0]);

      _idx = getValueIdx(topNavData, '@override') - 2;
      topNavData.insert(_idx, tempScreenBody(_name)[0]);

      await topNavPath.deleteFile();
      await topNavPath.appendListToFile(topNavData);
    } else if (argResults!['bottom'] == true) {
      final botNavData = await botNavPath.readFileData();

      botNavData!.insert(1, tempScreenImport(appName, _name)[0]);

      int _idx = getValueIdx(botNavData, 'getScreenBody()') - 2;
      botNavData.insert(_idx, tempScreenAppBar(_name)[0]);

      _idx = getValueIdx(botNavData, 'getNavigatorItem()') - 2;
      botNavData.insert(_idx, tempScreenBody(_name)[0]);

      _idx = getValueIdx(botNavData, '@override') - 2;
      botNavData.insert(_idx, tempNavigatorItem(_name)[0]);

      await botNavPath.deleteFile();
      await botNavPath.appendListToFile(botNavData);
    }
  }
}
