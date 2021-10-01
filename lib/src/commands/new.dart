import 'package:args/command_runner.dart';
import 'package:generatly_cli/src/commands/new_command_list/new_command_list.dart';
import 'package:io/io.dart';
import 'package:mason/mason.dart';
import 'package:universal_io/io.dart';

class NewCommand extends Command<int> {
  final Logger logger;
  NewCommand({required this.logger}) {
    addSubcommand(Page(logger, getAppName));
    addSubcommand(Screen(logger, getAppName));
    addSubcommand(Widget(logger));
    addSubcommand(Component(logger));
    addSubcommand(Animation(logger));
    addSubcommand(Navigator(logger, getAppName));
    addSubcommand(Cubit(logger, getAppName));
    addSubcommand(Bloc(logger, getAppName));
  }

  @override
  String get description => 'create new widgets';

  @override
  String get name => 'new';

  @override
  Future<int> run() async {
    return ExitCode.success.code;
  }

  get getAppName => Directory.current.path.split('/').last;
}
