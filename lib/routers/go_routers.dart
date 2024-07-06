import 'package:flutter/widgets.dart';
import 'package:go_router/go_router.dart';
import 'package:yapi_model/presentation/home/home_screen.dart';
import 'package:yapi_model/presentation/interface/interface_screen.dart';
import 'package:yapi_model/presentation/project/project_screen.dart';

part 'go_routers.g.dart';

@TypedGoRoute<HomeScreenRoute>(path: '/', routes: [
  TypedGoRoute<ProjectScreenRoute>(
    path: 'project/:id',
  )
])
@immutable
class HomeScreenRoute extends GoRouteData {
  @override
  Widget build(BuildContext context, GoRouterState state) {
    return const HomeScreen();
  }
}

@TypedGoRoute<ProjectScreenRoute>(path: '/project/:id')
@immutable
class ProjectScreenRoute extends GoRouteData {
  final int id;

  const ProjectScreenRoute({required this.id});

  @override
  Widget build(BuildContext context, GoRouterState state) {
    return ProjectScreen(projectId: id);
  }
}

@TypedGoRoute<InterfaceScreenRoute>(path: '/interface/:id')
@immutable
class InterfaceScreenRoute extends GoRouteData {
  final int id;

  const InterfaceScreenRoute({required this.id});

  @override
  Widget build(BuildContext context, GoRouterState state) {
    return InterfaceScreen(id: id);
  }
}
