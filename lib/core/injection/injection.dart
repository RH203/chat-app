import 'package:chat_app/core/router/router.dart';
import 'package:chat_app/core/utils/helper_validator.dart';

import 'package:get_it/get_it.dart';

final getIt = GetIt.instance;

void setup() {
  getIt.registerSingleton<AppRouter>(AppRouter());
  getIt.registerSingleton<HelperValidator>(HelperValidator());
}
