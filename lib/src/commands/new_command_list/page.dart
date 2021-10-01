import 'package:generatly_cli/src/bundles/bundles.dart';
import 'package:generatly_cli/src/commands/new_command_list/new_command_parent.dart';
import 'package:generatly_cli/src/utils/utils.dart';
import 'package:io/io.dart';
import 'package:mason/mason.dart';

class Page extends NewCommandParent {
  final Logger logr;
  final String appName;
  @override
  String get outPath => 'src/presentation/pages/';
  final appRoutePath = FileUtil('lib/src/presentation/routes/app_routes.dart');
  final appRouteDefPath =
      FileUtil('lib/src/presentation/routes/route_definations.dart');

  Page(this.logr, this.appName) : super(logger: logr) {
    argParser
      ..addOption('stl', help: 'stateless')
      ..addOption('stf', help: 'stateful');
  }

  @override
  String get description => 'create page add add path to route';

  @override
  String get name => 'page';

  @override
  Future<int> run() async {
    final stlVal = argResults!['stl'] as String?;
    final stfVal = argResults!['stf'] as String?;

    if (stlVal != null) {
      await createNew(stlVal, stlAppbarBundle);
    } else if (stfVal != null) {
      await createNew(stfVal, stfAppbarBundle);
    } else {
      logger.err('Enter valid arguments!!!');
    }
    return ExitCode.success.code;
  }

  @override
  Future<void> addExtraData(String _name) async {
    final appRouteData = await appRoutePath.readFileData();
    final appRouteDefData = await appRouteDefPath.readFileData();

    // add import data on first line
    appRouteData!.insert(1, tempPageImport(appName, _name)[0]);

    // add route data before default case
    int _idx = getValueIdx(appRouteData, 'default:');
    addListToList(tempAppRoute(_name), appRouteData, _idx);

    // add route defination before class closing
    _idx = getValueIdx(appRouteDefData!, '}');
    appRouteDefData.insert(_idx, tempRouteDefination(_name)[0]);

    // delete file in reference
    await appRoutePath.deleteFile();
    await appRouteDefPath.deleteFile();

    // append file in reference
    await appRoutePath.appendListToFile(appRouteData);
    await appRouteDefPath.appendListToFile(appRouteDefData);
  }
}
