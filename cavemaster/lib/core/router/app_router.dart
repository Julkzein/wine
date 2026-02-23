import 'package:go_router/go_router.dart';
import '../../presentation/screens/collection/collection_screen.dart';
import '../../presentation/screens/collection/wine_detail_screen.dart';
import '../../presentation/screens/collection/wine_form_screen.dart';
import '../../presentation/screens/cellar/cellar_screen.dart';
import '../../presentation/screens/cellar/cellar_config_screen.dart';
import '../../presentation/screens/discover/discover_screen.dart';
import '../../presentation/screens/discover/wishlist_screen.dart';
import '../../presentation/screens/stats/stats_screen.dart';
import '../../presentation/screens/settings/settings_screen.dart';
import '../../presentation/widgets/common/app_scaffold.dart';

final appRouter = GoRouter(
  initialLocation: '/collection',
  debugLogDiagnostics: false,
  routes: [
    StatefulShellRoute.indexedStack(
      builder: (context, state, navigationShell) =>
          AppScaffold(navigationShell: navigationShell),
      branches: [
        // ── Tab 0: Collection ────────────────────────────────────────────────
        StatefulShellBranch(
          routes: [
            GoRoute(
              path: '/collection',
              builder: (context, state) => const CollectionScreen(),
              routes: [
                GoRoute(
                  path: 'wine/:id',
                  builder: (context, state) => WineDetailScreen(
                    wineId: state.pathParameters['id']!,
                  ),
                  routes: [
                    GoRoute(
                      path: 'edit',
                      builder: (context, state) => WineFormScreen(
                        editWineId: state.pathParameters['id']!,
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ],
        ),

        // ── Tab 1: Cellar ────────────────────────────────────────────────────
        StatefulShellBranch(
          routes: [
            GoRoute(
              path: '/cellar',
              builder: (context, state) => const CellarScreen(),
              routes: [
                GoRoute(
                  path: 'config',
                  builder: (context, state) => const CellarConfigScreen(),
                ),
              ],
            ),
          ],
        ),

        // ── Tab 2: Discover ──────────────────────────────────────────────────
        StatefulShellBranch(
          routes: [
            GoRoute(
              path: '/discover',
              builder: (context, state) => const DiscoverScreen(),
              routes: [
                GoRoute(
                  path: 'wishlist',
                  builder: (context, state) => const WishlistScreen(),
                ),
              ],
            ),
          ],
        ),

        // ── Tab 3: Stats ─────────────────────────────────────────────────────
        StatefulShellBranch(
          routes: [
            GoRoute(
              path: '/stats',
              builder: (context, state) => const StatsScreen(),
            ),
          ],
        ),
      ],
    ),

    // ── Add wine (global, accessible from FAB anywhere) ─────────────────────
    GoRoute(
      path: '/wine/add',
      builder: (context, state) => const WineFormScreen(),
    ),

    // ── Settings (outside tab shell) ─────────────────────────────────────────
    GoRoute(
      path: '/settings',
      builder: (context, state) => const SettingsScreen(),
    ),
  ],
);
