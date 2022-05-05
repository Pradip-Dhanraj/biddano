import 'package:biddano/services/http-services.dart';
import 'package:biddano/utils/navigation.dart';
import 'package:get_it/get_it.dart';

GetIt locator = GetIt.instance;
void setupLocator() {
  locator.registerLazySingleton(() => NavigationService());
  locator.registerLazySingleton(() => HttpServices());
}
