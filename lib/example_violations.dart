// INCORRECT EXAMPLES — usage that violates custom_lint rules.
// Each example in this file is flagged by the corresponding rule.

import 'package:flutter/material.dart';

// no_scaffold_messenger: ScaffoldMessenger is banned
void showSnackBarViolation(BuildContext context) {
  ScaffoldMessenger.of(
    context,
  ).showSnackBar(const SnackBar(content: Text('Banned usage')));
}

// require_route_settings: missing routeSettings
void showDialogViolation(BuildContext context) {
  showDialog(
    context: context,
    builder: (context) => const AlertDialog(title: Text('Dialog')),
  );
}

// require_route_settings: missing routeSettings
void showSheetViolation(BuildContext context) {
  showModalBottomSheet(
    context: context,
    builder: (context) => const SizedBox(height: 200),
  );
}

// require_route_settings: MaterialPageRoute without settings
void pushViolation(BuildContext context) {
  Navigator.push(
    context,
    MaterialPageRoute(builder: (context) => const Scaffold(body: Text('Page'))),
  );
}

// pushNamed has no routeSettings in Flutter API — no lint for it.
void pushNamedExample(BuildContext context) {
  Navigator.pushNamed(context, '/detail');
}
