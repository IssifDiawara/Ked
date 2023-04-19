import 'package:get_it/get_it.dart';
import 'package:injectable/injectable.dart';

import 'global_dependencies.config.dart';

final getIt = GetIt.instance;

@InjectableInit(preferRelativeImports: false)
void configureDependencies() => getIt.init();
