import 'package:recase/recase.dart';

List<String> tempTab(String _name) => [
      "        const Tab(text: '${ReCase(_name).camelCase}'),",
    ];

List<String> tempScreenImport(String _appName, String _name) => [
      "import 'package:$_appName/src/presentation/navigator/screens/${ReCase(_name).snakeCase}.dart';",
    ];

List<String> tempScreenBody(String _name) => [
      "        const ${ReCase(_name).pascalCase}(),",
    ];

List<String> tempScreenAppBar(String _name) => [
      "        AppBar(title: const Text('${ReCase(_name).pascalCase}')),",
    ];

List<String> tempNavigatorItem(String _name) => [
      "        const BottomNavigationBarItem(icon: Icon(Icons.ac_unit), label: '${ReCase(_name).pascalCase}'),",
    ];
