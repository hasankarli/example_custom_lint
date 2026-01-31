import 'package:analyzer/dart/ast/ast.dart';
import 'package:analyzer/dart/element/element.dart';
import 'package:analyzer/error/error.dart' hide LintCode;
import 'package:analyzer/error/listener.dart';
import 'package:custom_lint_builder/custom_lint_builder.dart';

class NoScaffoldMessengerRule extends DartLintRule {
  const NoScaffoldMessengerRule()
    : super(
        code: const LintCode(
          name: 'no_scaffold_messenger',
          problemMessage:
              'ScaffoldMessenger is banned. Use a different approach for snacks/navigation (e.g. a dedicated service or RouteSettings).',
          correctionMessage: 'Remove ScaffoldMessenger usage.',
          errorSeverity: DiagnosticSeverity.ERROR,
        ),
      );

  static bool _isScaffoldMessenger(Element? element) {
    if (element == null) return false;
    final enclosing = element.enclosingElement;
    if (enclosing is! ClassElement) return false;
    if (enclosing.name != 'ScaffoldMessenger') return false;
    final uri = enclosing.library.uri.toString();
    return uri.contains('flutter') && uri.contains('material');
  }

  @override
  void run(
    CustomLintResolver resolver,
    DiagnosticReporter reporter,
    CustomLintContext context,
  ) {
    context.registry.addMethodInvocation((MethodInvocation node) {
      final element = node.methodName.element;
      if (_isScaffoldMessenger(element)) {
        reporter.atNode(node, code);
      }
    });
  }
}
