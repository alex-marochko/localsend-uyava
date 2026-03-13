import 'dart:io';

import 'package:localsend_app/uyava/localsend_uyava_graph.dart';
import 'package:test/test.dart';

void main() {
  test('Uyava graph covers every local *_page.dart screen', () {
    final Set<String> modeledPages = localSendUyavaGraph.nodeSpecs
        .map((spec) => _sourceRefPath(spec.sourceRef))
        .whereType<String>()
        .where((path) => path.startsWith('pages/') && path.endsWith('_page.dart'))
        .toSet();

    final Set<String> actualPages = Directory('lib/pages')
        .listSync(recursive: true)
        .whereType<File>()
        .map((file) => file.path.replaceAll('\\', '/'))
        .where((path) => path.endsWith('_page.dart'))
        .map((path) => path.replaceFirst('lib/', ''))
        .toSet();

    expect(modeledPages, containsAll(actualPages));
  });

  test('Every local *_page.dart screen is instrumented for Uyava lifecycle updates', () {
    final List<File> pageFiles = Directory(
      'lib/pages',
    ).listSync(recursive: true).whereType<File>().where((file) => file.path.replaceAll('\\', '/').endsWith('_page.dart')).toList();

    for (final file in pageFiles) {
      final String contents = file.readAsStringSync();
      expect(
        contents.contains('UyavaPageLifecycle(') || contents.contains('LocalSendUyava.activateUiNode('),
        isTrue,
        reason: 'Missing Uyava lifecycle instrumentation for ${file.path}',
      );
    }
  });

  test('Uyava graph edges point only to declared nodes and avoids synthetic app root', () {
    final Set<String> nodeIds = localSendUyavaGraph.nodeSpecs.map((spec) => spec.id).toSet();

    expect(nodeIds, isNot(contains('localsend.app')));
    for (final edge in localSendUyavaGraph.edges) {
      expect(nodeIds, contains(edge.from), reason: 'Missing edge.from node for ${edge.id}');
      expect(nodeIds, contains(edge.to), reason: 'Missing edge.to node for ${edge.id}');
    }
  });
}

String? _sourceRefPath(String sourceRef) {
  const String prefix = 'package:localsend_app/';
  if (!sourceRef.startsWith(prefix)) {
    return null;
  }
  return sourceRef.substring(prefix.length).split(':').first;
}
