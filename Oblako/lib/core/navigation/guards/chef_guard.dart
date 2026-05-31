import 'package:auto_route/auto_route.dart';
import 'package:cullinarium/core/navigation/app_router.dart';
import 'package:cullinarium/features/authentication/data/datasources/remote/auth_service.dart';

class ChefGuard extends AutoRouteGuard {
  final AuthService _authService;

  ChefGuard(this._authService);

  @override
  void onNavigation(NavigationResolver resolver, StackRouter router) async {
    final currentUser = await _authService.getCurrentUserData();

    if (currentUser?.role == 'chef') {
      resolver.next(true);
    } else {
      router.push(const LoginRoute());
    }
  }
}
