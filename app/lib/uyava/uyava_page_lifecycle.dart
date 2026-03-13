import 'package:flutter/widgets.dart';
import 'package:localsend_app/uyava/localsend_uyava.dart';
import 'package:uyava/uyava.dart';

class UyavaPageLifecycle extends StatefulWidget {
  const UyavaPageLifecycle({
    required this.nodeId,
    required this.child,
    this.activeMessage = 'Page shown',
    this.inactiveMessage = 'Page hidden',
    super.key,
  });

  final String nodeId;
  final Widget child;
  final String activeMessage;
  final String inactiveMessage;

  @override
  State<UyavaPageLifecycle> createState() => _UyavaPageLifecycleState();
}

class _UyavaPageLifecycleState extends State<UyavaPageLifecycle> {
  @override
  void initState() {
    super.initState();
    LocalSendUyava.activateUiNode(
      nodeId: widget.nodeId,
      sourceRef: Uyava.caller(),
      message: widget.activeMessage,
    );
  }

  @override
  void dispose() {
    LocalSendUyava.deactivateUiNode(
      nodeId: widget.nodeId,
      sourceRef: Uyava.caller(),
      message: widget.inactiveMessage,
    );
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return widget.child;
  }
}
