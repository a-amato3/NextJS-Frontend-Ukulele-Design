import 'package:get_it/get_it.dart';
import 'core/services/providers/new_provider.dart';
GetIt locator = GetIt.instance;

void setupLocator() {
  locator
      .registerLazySingleton(() => UkeProvider());

}
