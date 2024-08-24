import 'package:chat_app/src/auth_page/presentation/sign_in_page.dart';
import 'package:chat_app/src/auth_page/presentation/sign_up_page.dart';
import 'package:chat_app/src/homepage/presentation/homepage.dart';
import 'package:go_router/go_router.dart';

class AppRouter {
  AppRouter();

  final router = GoRouter(
    initialLocation: '/sign-up',
    routes: [
      GoRoute(
        path: '/',
        builder: (context, state) => const Homepage(),
      ),
      GoRoute(
        path: '/sign-in',
        builder: (context, state) => const SignInPage(),
      ),
      GoRoute(
        path: '/sign-up',
        builder: (context, state) => const SignUpPage(),
      )
    ],
  );
}
