import 'package:analyzer/dart/ast/ast.dart';
import 'package:analyzer/dart/element/element.dart';
import 'package:analyzer/error/error.dart' hide LintCode;
import 'package:analyzer/error/listener.dart';
import 'package:custom_lint_builder/custom_lint_builder.dart';

class RequireRouteSettingsRule extends DartLintRule {
  const RequireRouteSettingsRule()
    : super(
        code: const LintCode(
          name: 'require_route_settings',
          problemMessage:
              'Sheets, dialogs, and navigation must pass RouteSettings (or settings) for observability and testing.',
          correctionMessage:
              'Add routeSettings: RouteSettings(name: \'...\') or settings: RouteSettings(name: \'...\').',
          errorSeverity: DiagnosticSeverity.ERROR,
        ),
      );

  static bool _isFromMaterial(Element? element) {
    if (element == null) return false;
    final uri = element.library?.uri.toString() ?? '';
    return uri.contains('flutter') && uri.contains('material');
  }

  static bool _isNavigatorMethod(Element? element) {
    if (element == null) return false;
    final uri = element.library?.uri.toString() ?? '';
    if (!uri.contains('navigator') && !uri.contains('widgets')) return false;
    final enclosing = element.enclosingElement;
    if (enclosing is! ClassElement) return false;
    return enclosing.name == 'Navigator';
  }

  static bool _hasNamedArgument(ArgumentList list, String name) {
    for (final arg in list.arguments) {
      if (arg is NamedExpression && arg.name.label.name == name) return true;
    }
    return false;
  }

  @override
  void run(
    CustomLintResolver resolver,
    DiagnosticReporter reporter,
    CustomLintContext context,
  ) {
    context.registry.addMethodInvocation((MethodInvocation node) {
      final element = node.methodName.element;
      if (element is! ExecutableElement) return;

      final name = element.name;
      if (name == null || name.isEmpty) return;
      final args = node.argumentList;

      if (name == 'showModalBottomSheet' || name == 'showDialog') {
        if (!_isFromMaterial(element)) return;
        if (!_hasNamedArgument(args, 'routeSettings')) {
          reporter.atNode(node, code);
        }
        return;
      }

      if (!_isNavigatorMethod(element)) return;
      // pushNamed/pushReplacementNamed have no routeSettings in Flutter API — skip.
      if (name == 'pushNamed' || name == 'pushReplacementNamed') return;

      if (name == 'push' && args.arguments.length >= 2) {
        final routeArg = args.arguments[1];
        if (routeArg is InstanceCreationExpression) {
          final typeName =
              routeArg.constructorName.type.type?.element?.name ?? '';
          if (typeName == 'MaterialPageRoute' ||
              typeName == 'CupertinoPageRoute') {
            if (!_hasNamedArgument(routeArg.argumentList, 'settings')) {
              reporter.atNode(node, code);
            }
          }
        }
      }
    });
  }
}
