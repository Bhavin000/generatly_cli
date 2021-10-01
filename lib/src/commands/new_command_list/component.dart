import 'package:generatly_cli/src/bundles/bundles.dart';
import 'package:generatly_cli/src/commands/new_command_list/new_command_parent.dart';
import 'package:io/io.dart';
import 'package:mason/mason.dart';

class Component extends NewCommandParent {
  final Logger logr;
  @override
  String get outPath => 'src/presentation/components/';

  Component(this.logr) : super(logger: logr) {
    argParser
      ..addOption('stl', help: 'stateless')
      ..addOption('stf', help: 'stateful');
  }

  @override
  String get description => 'create component widget';

  @override
  String get name => 'component';

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
}
