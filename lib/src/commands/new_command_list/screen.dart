import 'package:generatly_cli/src/bundles/bundles.dart';
import 'package:generatly_cli/src/commands/new_command_list/new_command_parent.dart';
import 'package:io/io.dart';
import 'package:mason/mason.dart';

class Screen extends NewCommandParent {
  final Logger logr;
  final String appName;
  @override
  String get outPath => 'src/presentation/navigator/screens/';

  Screen(this.logr, this.appName) : super(logger: logr) {
    argParser
      ..addOption('stl', help: 'stateless')
      ..addOption('stf', help: 'stateful');
  }

  @override
  String get description => 'create screen add add path to navigator';

  @override
  String get name => 'screen';

  @override
  Future<int> run() async {
    final stlVal = argResults!['stl'] as String?;
    final stfVal = argResults!['stf'] as String?;

    if (stlVal != null) {
      await createNew(stlVal, stlBodyBundle);
    } else if (stfVal != null) {
      await createNew(stfVal, stfBodyBundle);
    } else {
      logger.err('Enter valid arguments!!!');
    }
    return ExitCode.success.code;
  }
}
