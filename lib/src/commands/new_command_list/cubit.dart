import 'package:generatly_cli/src/bundles/bundles.dart';
import 'package:generatly_cli/src/commands/new_command_list/new_command_parent.dart';
import 'package:generatly_cli/src/utils/utils.dart';
import 'package:io/io.dart';
import 'package:mason/mason.dart';
import 'package:recase/recase.dart';

class Cubit extends NewCommandParent {
  final Logger logr;
  final String appName;
  @override
  String get outPath => 'src/logic/cubits/';
  final appPath = FileUtil('lib/src/app.dart');

  Cubit(this.logr, this.appName) : super(logger: logr);
  @override
  String get description => 'create cubit add add path to app';

  @override
  String get name => 'cubit';

  @override
  Future<int> run() async {
    final _args = argResults!.rest;

    if (_args.length == 1) {
      createNew(_args.first, cubitBundle);
    } else {
      logger.err('Enter valid arguments!!!');
    }
    return ExitCode.success.code;
  }

  @override
  Future<void> createNew(String name, MasonBundle bundle) async {
    final _name = ReCase(name).snakeCase;
    final _temp = FileUtil('./lib/$outPath${_name}_cubit/${_name}_cubit.dart');
    if (await _temp.isExists) {
      logger.err('File already Exists!!!');
      return;
    }
    await generateTemplate(bundle, _name);
    await addExtraData(_name);
    logger.success('$_name created successfully.');
  }

  @override
  Future<void> addExtraData(String _name) async {
    final appData = await appPath.readFileData();

    // add import data on first line
    appData!.insert(1, tempCubitImport(appName, _name)[0]);

    // add route data before default case
    int _idx = getValueIdx(appData, 'child:') - 1;
    for (String content in tempCubitProvider(_name)) {
      appData.insert(_idx, content);
      _idx++;
    }

    await appPath.deleteFile();
    await appPath.appendListToFile(appData);
  }
}
