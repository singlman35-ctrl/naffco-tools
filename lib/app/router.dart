import 'dart:async';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import '../features/auth/login_screen.dart';
import '../features/dashboard/dashboard_screen.dart';
import '../features/projects/projects_screen.dart';
import '../features/equipment/equipment_screen.dart';
import '../features/materials/materials_screen.dart';
import '../features/engineer_requests/engineer_requests_screen.dart';
import '../features/equipment_movements/equipment_movements_screen.dart';
import '../features/reports/reports_screen.dart';
import '../features/import_center/import_center_screen.dart';
import '../features/pdf_links/pdf_links_screen.dart';
import '../providers/auth_providers.dart';

GoRouter appRouter(WidgetRef ref) {
  final authState = ref.watch(authStateProvider);
  return GoRouter(
    initialLocation: '/login',
    routes: [
      GoRoute(path: '/login', builder: (context, state) => const LoginScreen()),
      GoRoute(
        path: '/dashboard',
        builder: (context, state) => const DashboardScreen(),
      ),
      GoRoute(
        path: '/projects',
        builder: (context, state) => const ProjectsScreen(),
      ),
      GoRoute(
        path: '/equipment',
        builder: (context, state) => const EquipmentScreen(),
      ),
      GoRoute(
        path: '/materials',
        builder: (context, state) => const MaterialsScreen(),
      ),
      GoRoute(
        path: '/engineer-requests',
        builder: (context, state) => const EngineerRequestsScreen(),
      ),
      GoRoute(
        path: '/equipment-movements',
        builder: (context, state) => const EquipmentMovementsScreen(),
      ),
      GoRoute(
        path: '/reports',
        builder: (context, state) => const ReportsScreen(),
      ),
      GoRoute(
        path: '/import-center',
        builder: (context, state) => const ImportCenterScreen(),
      ),
      GoRoute(
        path: '/pdf-links',
        builder: (context, state) => const PdfLinksScreen(),
      ),
    ],
    redirect: (context, state) {
      final isLoggedIn = authState.value != null;
      final isLogin = state.uri.toString() == '/login';
      if (!isLoggedIn && !isLogin) {
        return '/login';
      }
      if (isLoggedIn && isLogin) {
        return '/dashboard';
      }
      return null;
    },
    refreshListenable: GoRouterRefreshStream(
      authState is AsyncLoading
          ? const Stream.empty()
          : authState is AsyncData
          ? Stream.value(authState.value)
          : const Stream.empty(),
    ),
  );
}

class GoRouterRefreshStream extends ChangeNotifier {
  GoRouterRefreshStream(Stream<dynamic> stream) {
    notifyListeners();
    _subscription = stream.listen((_) => notifyListeners());
  }
  late final StreamSubscription<dynamic> _subscription;
  @override
  void dispose() {
    _subscription.cancel();
    super.dispose();
  }
}
