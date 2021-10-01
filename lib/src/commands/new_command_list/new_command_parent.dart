import 'package:args/command_runner.dart';
import 'package:generatly_cli/src/bundles/bundles.dart';
import 'package:generatly_cli/src/utils/utils.dart';
import 'package:io/io.dart';
import 'package:mason/mason.dart';
import 'package:recase/recase.dart';

class NewCommandParent extends Command<int> {
  Logger logger;
  String get outPath => '';
  NewCommandParent({required this.logger});

  @override
  String get description => throw UnimplementedError();

  @override
  String get name => throw UnimplementedError();

  @override
  Future<int> run() async {
    return ExitCode.success.code;
  }

  Future<void> createNew(String name, MasonBundle bundle) async {
    final _name = ReCase(name).snakeCase;
    final _temp = FileUtil('./lib/$outPath' + _name + '.dart');
    if (await _temp.isExists) {
      logger.err('File already Exists!!!');
      return;
    }
    await generateTemplate(bundle, _name);
    await addExtraData(_name);
    logger.success('$_name created successfully.');
  }

  Future<void> addExtraData(String _name) async {}

  void addListToList(
    List<String> _inList,
    List<String> _outList,
    int _idx,
  ) {
    for (String content in _inList) {
      _outList.insert(_idx, content);
      _idx++;
    }
  }

  Future<void> generateTemplate(MasonBundle bundle, String _name) async {
    final Map<String, dynamic> vars = {
      "name": _name,
    };
    try {
      await MasonUtil.generateFile(
        './lib/$outPath',
        bundle,
        vars,
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

  int getValueIdx(List<String> content, String conditionString) {
    return content.indexWhere((element) => element.contains(conditionString));
  }
}
