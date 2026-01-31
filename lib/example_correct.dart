// CORRECT EXAMPLES — usage compliant with custom_lint rules.
// no_scaffold_messenger: ScaffoldMessenger is not used.
// require_route_settings: showDialog/showModalBottomSheet have routeSettings; push uses settings.

import 'package:flutter/material.dart';

void showDialogCorrect(BuildContext context) {
  showDialog(
    context: context,
    routeSettings: const RouteSettings(name: '/dialog/confirm'),
    builder: (context) => const AlertDialog(title: Text('Dialog')),
  );
}

void showSheetCorrect(BuildContext context) {
  showModalBottomSheet(
    context: context,
    routeSettings: const RouteSettings(name: '/sheet/options'),
    builder: (context) => const SizedBox(height: 200),
  );
}

void pushCorrect(BuildContext context) {
  Navigator.push(
    context,
    MaterialPageRoute(
      settings: const RouteSettings(name: '/detail'),
      builder: (context) => const Scaffold(body: Text('Page')),
    ),
  );
}

void pushNamedCorrect(BuildContext context) {
  // pushNamed has no routeSettings param; route name is the identifier.
  Navigator.pushNamed(context, '/detail');
}
