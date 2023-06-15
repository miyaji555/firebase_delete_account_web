import 'package:firebase_delete_account_web/presentation/main_page.dart';
import 'package:flutter/cupertino.dart';
import 'package:go_router/go_router.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

const kPagePathMain = '/main';
const kPageNameMain = '退会';

final routerProvider = Provider<GoRouter>(
  (ref) {
    return GoRouter(
      initialLocation: kPagePathMain,
      routes: [
        GoRoute(
          name: kPageNameMain,
          path: kPagePathMain,
          builder: (BuildContext context, GoRouterState state) {
            return const MainPage();
          },
        ),
      ],
    );
  },
);
