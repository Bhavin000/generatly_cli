import 'package:generatly_cli/src/command_runner.dart';
import 'package:mason/mason.dart';

main(List<String> args) async {
  await GeneratlyCommandRunner(logger: Logger()).run(args);
}
