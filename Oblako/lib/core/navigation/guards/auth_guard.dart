import 'package:auto_route/auto_route.dart';
import 'package:cullinarium/core/navigation/app_router.dart';
import 'package:cullinarium/features/authentication/data/datasources/remote/auth_service.dart';

class AuthGuard extends AutoRouteGuard {
  final AuthService _authService;

  AuthGuard(this._authService);

  @override
  void onNavigation(NavigationResolver resolver, StackRouter router) {
    if (_authService.currentUser != null) {
      resolver.next(true);
    } else {
      router.push(const LoginRoute());
    }
  }
}
