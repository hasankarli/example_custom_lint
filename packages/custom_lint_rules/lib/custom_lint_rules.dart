import 'package:custom_lint_builder/custom_lint_builder.dart';
import 'package:custom_lint_rules/src/no_scaffold_messenger.dart';
import 'package:custom_lint_rules/src/require_route_settings.dart';

PluginBase createPlugin() => _ExampleCustomLintPlugin();

class _ExampleCustomLintPlugin extends PluginBase {
  @override
  List<LintRule> getLintRules(CustomLintConfigs configs) => [
        const NoScaffoldMessengerRule(),
        const RequireRouteSettingsRule(),
      ];
}
