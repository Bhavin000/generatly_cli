import 'package:generatly_cli/src/bundles/bundles.dart';
import 'package:generatly_cli/src/commands/new_command_list/new_widgets/new_widget_parent.dart';
import 'package:io/io.dart';
import 'package:mason/mason.dart';

class Snack extends NewWidgetParent {
  final Logger logr;
  Snack(this.logr) : super(logger: logr);

  @override
  String get description => 'snackbar widget';

  @override
  String get name => 'snack';

  @override
  Future<int> run() async {
    createNewWidget('snack', snackBundle);
    return ExitCode.success.code;
  }
}
