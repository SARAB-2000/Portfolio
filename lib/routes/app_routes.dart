import 'package:flutter/material.dart';

import '../data/portfolio_data.dart';
import '../screens/home_screen.dart';
import '../screens/project_detail_screen.dart';

class AppRoutes {
  static const home = '/';
  static const project = '/project';

  static Route<dynamic> onGenerateRoute(RouteSettings settings) {
    switch (settings.name) {
      case home:
        return MaterialPageRoute(builder: (_) => const HomeScreen());
      case project:
        final id = settings.arguments as String?;
        final project = id != null ? PortfolioData.projectById(id) : null;
        if (project == null) {
          return MaterialPageRoute(builder: (_) => const HomeScreen());
        }
        return MaterialPageRoute(
          builder: (_) => ProjectDetailScreen(project: project),
          settings: settings,
        );
      default:
        return MaterialPageRoute(builder: (_) => const HomeScreen());
    }
  }

  static void openProject(BuildContext context, ProjectItem project) {
    Navigator.of(context).pushNamed(AppRoutes.project, arguments: project.id);
  }
}
