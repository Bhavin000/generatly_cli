import 'package:recase/recase.dart';

List<String> tempPageImport(String _appName, String _name) => [
      "import 'package:$_appName/src/presentation/pages/${ReCase(_name).snakeCase}.dart';",
    ];

List<String> tempAppRoute(String _name) => [
      '      case Routes.${ReCase(_name).camelCase}:',
      '        return MaterialPageRoute(',
      '          builder: (context) => const ${ReCase(_name).pascalCase}(),',
      '        );',
    ];

List<String> tempRouteDefination(String _name) => [
      "  static const String ${ReCase(_name).camelCase} = '/${ReCase(_name).camelCase}';",
    ];
