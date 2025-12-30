import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

class MainLayout extends StatelessWidget {
  final Widget child;
  const MainLayout({super.key, required this.child});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Row(
        children: [
          // Sidebar
          Container(
            width: 240,
            color: const Color(0xFF185ABC),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                const SizedBox(height: 16),
                const Text(
                  'القائمة',
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    color: Colors.white,
                    fontWeight: FontWeight.bold,
                    fontSize: 20,
                  ),
                ),
                const SizedBox(height: 24),
                SidebarItem(label: 'Dashboard', route: '/dashboard'),
                SidebarItem(label: 'Projects', route: '/projects'),
                SidebarItem(label: 'Equipment', route: '/equipment'),
                SidebarItem(label: 'Materials', route: '/materials'),
                SidebarItem(
                  label: 'Engineer Requests',
                  route: '/engineer-requests',
                ),
                SidebarItem(
                  label: 'Equipment Movements',
                  route: '/equipment-movements',
                ),
                SidebarItem(label: 'Reports', route: '/reports'),
                SidebarItem(label: 'Import Center', route: '/import-center'),
                SidebarItem(label: 'PDF Links', route: '/pdf-links'),
                const Spacer(),
              ],
            ),
          ),
          // Main Content
          Expanded(
            child: Column(
              children: [
                // AppBar
                Container(
                  height: 56,
                  color: const Color(0xFF1A73E8),
                  alignment: Alignment.centerLeft,
                  padding: const EdgeInsets.symmetric(horizontal: 24),
                  child: const Text(
                    'Naffco Tools',
                    style: TextStyle(
                      color: Colors.white,
                      fontWeight: FontWeight.bold,
                      fontSize: 22,
                    ),
                  ),
                ),
                // Content Area
                Expanded(
                  child: Container(
                    color: const Color(0xFFF5F5F5),
                    child: child,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

class SidebarItem extends StatelessWidget {
  final String label;
  final String route;
  const SidebarItem({super.key, required this.label, required this.route});

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () => context.go(route),
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 10),
        child: Text(
          label,
          style: const TextStyle(color: Colors.white, fontSize: 16),
        ),
      ),
    );
  }
}
