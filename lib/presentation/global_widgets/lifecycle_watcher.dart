import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class LifecycleWatcher extends StatefulWidget {
  final Widget child;

  const LifecycleWatcher({Key? key, required this.child}) : super(key: key);

  @override
  State<LifecycleWatcher> createState() => _LifecycleWatcherState();
}

class _LifecycleWatcherState extends State<LifecycleWatcher>
    with WidgetsBindingObserver {
  static const lastRouteKey = 'last_route';

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addObserver(this);
  }

  @override
  void dispose() {
    WidgetsBinding.instance.removeObserver(this);
    super.dispose();
  }

  @override
  void didChangeAppLifecycleState(AppLifecycleState state) async {
    final prefs = await SharedPreferences.getInstance();
    if (state == AppLifecycleState.paused) {
      final route = ModalRoute.of(context)?.settings.name;
      if (route != null) {
        await prefs.setString(lastRouteKey, route);
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return widget.child;
  }
}
