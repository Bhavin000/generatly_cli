import 'package:generatly_cli/src/bundles/bundles.dart';
import 'package:generatly_cli/src/commands/new_command_list/new_widgets/new_widget_parent.dart';
import 'package:io/io.dart';
import 'package:mason/mason.dart';

class Bnr extends NewWidgetParent {
  final Logger logr;
  Bnr(this.logr) : super(logger: logr);

  @override
  String get description => 'material banner widget';

  @override
  String get name => 'bnr';

  @override
  Future<int> run() async {
    createNewWidget('bnr', bnrBundle);
    return ExitCode.success.code;
  }
}
