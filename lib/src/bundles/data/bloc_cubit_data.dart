import 'package:recase/recase.dart';

List<String> tempCubitImport(String _appName, String _name) => [
      "import 'package:$_appName/src/logic/cubits/${ReCase(_name).snakeCase}_cubit/${ReCase(_name).snakeCase}_cubit.dart';",
    ];

List<String> tempBlocImport(String _appName, String _name) => [
      "import 'package:$_appName/src/logic/blocs/${ReCase(_name).snakeCase}_bloc/${ReCase(_name).snakeCase}_bloc.dart';",
    ];

List<String> tempCubitProvider(String _name) => [
      '        BlocProvider<${ReCase(_name).pascalCase}Cubit>(',
      '          create: (context) => ${ReCase(_name).pascalCase}Cubit(),',
      '        ),',
    ];

List<String> tempBlocProvider(String _name) => [
      '        BlocProvider<${ReCase(_name).pascalCase}Bloc>(',
      '          create: (context) => ${ReCase(_name).pascalCase}Bloc(),',
      '        ),',
    ];
