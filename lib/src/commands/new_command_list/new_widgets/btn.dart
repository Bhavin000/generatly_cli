import 'package:generatly_cli/src/bundles/bundles.dart';
import 'package:generatly_cli/src/commands/new_command_list/new_widgets/new_widget_parent.dart';
import 'package:io/io.dart';
import 'package:mason/mason.dart';

class Btn extends NewWidgetParent {
  final Logger logr;
  Btn(this.logr) : super(logger: logr);

  @override
  String get description => 'button widget';

  @override
  String get name => 'btn';

  @override
  Future<int> run() async {
    createNewWidget('btn', btnBundle);
    return ExitCode.success.code;
  }
}
