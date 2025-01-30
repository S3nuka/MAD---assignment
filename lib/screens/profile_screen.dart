import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:go_router/go_router.dart';
import 'package:provider/provider.dart';
import '../providers/theme_provider.dart';
import '../widgets/app_scaffold.dart';

class ProfileScreen extends StatelessWidget {
  const ProfileScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final themeProvider = context.watch<ThemeProvider>();

    return AppScaffold(
      title: 'Profile',
      actions: [
        TextButton.icon(
          onPressed: () => context.go('/login'),
          icon: const Icon(Icons.logout),
          label: const Text('Logout'),
        ),
      ],
      child: ListView(
        padding: const EdgeInsets.all(16),
        children: [
          Card(
            child: Padding(
              padding: const EdgeInsets.all(16),
              child: Column(
                children: [
                  const CircleAvatar(
                    radius: 50,
                    child: Icon(Icons.person_outline, size: 50),
                  ).animate().fadeIn().scale(),
                  const SizedBox(height: 16),
                  Text(
                    'John Doe',
                    style: Theme.of(context).textTheme.titleLarge?.copyWith(
                          fontWeight: FontWeight.bold,
                        ),
                  ).animate().fadeIn().slideY(),
                  const SizedBox(height: 4),
                  Text(
                    'john.doe@example.com',
                    style: Theme.of(context).textTheme.bodyLarge?.copyWith(
                          color: Theme.of(context).colorScheme.onSurfaceVariant,
                        ),
                  ).animate().fadeIn().slideY(),
                ],
              ),
            ),
          ).animate().fadeIn().slideY(),
          const SizedBox(height: 16),
          Card(
            child: Column(
              children: [
                ListTile(
                  leading: const Icon(Icons.palette_outlined),
                  title: const Text('Use System Theme'),
                  subtitle: const Text('Automatically match device theme'),
                  trailing: Switch(
                    value: themeProvider.useSystemTheme,
                    onChanged: (value) => themeProvider.toggleSystemTheme(),
                  ),
                ),
                if (!themeProvider.useSystemTheme) ...[
                  const Divider(),
                  ListTile(
                    leading: Icon(
                      themeProvider.isDarkMode
                          ? Icons.dark_mode_outlined
                          : Icons.light_mode_outlined,
                    ),
                    title: Text('${themeProvider.isDarkMode ? 'Dark' : 'Light'} Mode'),
                    trailing: Switch(
                      value: themeProvider.isDarkMode,
                      onChanged: (_) => themeProvider.toggleTheme(),
                    ),
                  ),
                ],
              ],
            ),
          ).animate().fadeIn().slideY(),
        ],
      ),
    );
  }
}
