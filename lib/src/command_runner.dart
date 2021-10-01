import 'package:args/args.dart';
import 'package:args/command_runner.dart';
import 'package:generatly_cli/src/commands/commands.dart';
import 'package:generatly_cli/src/version.dart';
import 'package:io/io.dart';
import 'package:mason/mason.dart';

class GeneratlyCommandRunner extends CommandRunner<int> {
  final Logger logger;
  GeneratlyCommandRunner({required this.logger})
      : super('generatly', 'runtime bloc template generator.') {
    argParser.addFlag(
      'version',
      negatable: false,
      help: 'print the current version',
      abbr: 'v',
    );
    addCommand(RunServerCommand(logger: logger));
    addCommand(StarterCommand(logger: logger));
    addCommand(NewCommand(logger: logger));
  }
  @override
  Future<int> run(Iterable<String> args) async {
    try {
      // logger.prompt('<- Welcome to Generatly CLI ->');
      final _argParse = parse(args);

      return await runCommand(_argParse) ?? ExitCode.success.code;
    } catch (e) {
      print(e);
      return ExitCode.usage.code;
    }
  }

  @override
  Future<int?> runCommand(ArgResults topLevelResults) async {
    if (topLevelResults['version'] == true) {
      logger.info('generatly: $packageVersion');
      return ExitCode.success.code;
    }

    return super.runCommand(topLevelResults);
  }
}
