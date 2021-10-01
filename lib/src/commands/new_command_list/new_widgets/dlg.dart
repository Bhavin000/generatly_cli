import 'package:generatly_cli/src/bundles/bundles.dart';
import 'package:generatly_cli/src/commands/new_command_list/new_widgets/new_widget_parent.dart';
import 'package:io/io.dart';
import 'package:mason/mason.dart';

class Dlg extends NewWidgetParent {
  final Logger logr;
  Dlg(this.logr) : super(logger: logr);

  @override
  String get description => 'dialog widget';

  @override
  String get name => 'dlg';

  @override
  Future<int> run() async {
    createNewWidget('dlg', dlgBundle);
    return ExitCode.success.code;
  }
}
