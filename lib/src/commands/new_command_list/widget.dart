import 'package:generatly_cli/src/bundles/bundles.dart';
import 'package:generatly_cli/src/commands/new_command_list/new_command_parent.dart';
import 'package:generatly_cli/src/commands/new_command_list/new_widgets/new_widgets.dart';
import 'package:generatly_cli/src/utils/utils.dart';
import 'package:io/io.dart';
import 'package:mason/mason.dart';

class Widget extends NewCommandParent {
  final Logger logr;
  @override
  String get outPath => 'src/presentation/widgets/';

  Widget(this.logr) : super(logger: logr) {
    argParser
      ..addOption('stl', help: 'stateless widget')
      ..addOption('stf', help: 'stateful widget');

    addSubcommand(Dlg(logr));
    addSubcommand(Btn(logr));
    addSubcommand(Snack(logr));
    addSubcommand(Bnr(logr));
  }

  @override
  String get description => 'create simple widget';

  @override
  String get name => 'widget';

  @override
  Future<int> run() async {
    final stlVal = argResults!['stl'] as String?;
    final stfVal = argResults!['stf'] as String?;

    if (stlVal != null) {
      await createNew(stlVal, stlBundle);
    } else if (stfVal != null) {
      await createNew(stfVal, stfBundle);
    } else {
      logger.err('Enter valid arguments!!!');
    }

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
