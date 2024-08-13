import 'package:flutter_modular/flutter_modular.dart';
import 'features/assets/assets_module.dart';
import 'features/shared/shared_module.dart';

import 'features/menu/companies_module.dart';

class AppModule extends Module {
  @override
  void binds(i) {}

  @override
  void routes(r) {
    r.module('/', module: SharedModule());
    r.module('/', module: CompaniesModule());
    r.module('/', module: AssetsModule());
  }
}
