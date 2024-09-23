import 'package:dio/dio.dart';

import 'package:sikshya/core/shared_prefences/locator.dart';
import 'package:sikshya/core/shared_prefences/shared_prefences_service.dart';

class RedirectInterceptor extends Interceptor {
  @override
  void onError(DioException err, ErrorInterceptorHandler handler) {
    if (err.response?.statusCode == 401) {
      locator.get<SharedPreferencesService>().clear();
      // AppRouter.router.goNamed(LoginScreen.routeName);
    }
    super.onError(err, handler);
  }
}
