import 'dart:io';
import 'dart:ui' as ui;

import 'package:common/model/device.dart';
import 'package:common/model/dto/file_dto.dart';
import 'package:flutter/foundation.dart';
import 'package:logging/logging.dart';
import 'package:path/path.dart' as p;
import 'package:path_provider/path_provider.dart';
import 'package:uyava/uyava.dart';

class LocalSendUyava {
  static final Logger _logger = Logger('Uyava');

  static bool _initialized = false;
  static bool _errorBridgeInstalled = false;
  static final Map<String, Map<String, FileDto>> _activeSendFiles = <String, Map<String, FileDto>>{};
  static final Map<String, Map<String, FileDto>> _activeReceiveFiles = <String, Map<String, FileDto>>{};

  static const String rootNodeId = 'localsend.app';
  static const String errorsNodeId = 'localsend.errors';
  static const String nativeGroupNodeId = 'localsend.native';
  static const String rustBridgeNodeId = 'localsend.native.rust_bridge';
  static const String rustWebrtcNodeId = 'localsend.native.rust_webrtc';
  static const String rustCryptoNodeId = 'localsend.native.rust_crypto';
  static const String rustLoggingNodeId = 'localsend.native.rust_logging';
  static const String uiGroupNodeId = 'localsend.ui';
  static const String uiHomeNodeId = 'localsend.ui.home';
  static const String uiSendNodeId = 'localsend.ui.send';
  static const String uiReceiveNodeId = 'localsend.ui.receive';
  static const String uiSettingsNodeId = 'localsend.ui.settings_tab';
  static const String uiProgressNodeId = 'localsend.ui.progress';

  static const String networkGroupNodeId = 'localsend.network';
  static const String discoveryNodeId = 'localsend.network.discovery';
  static const String securityNodeId = 'localsend.network.security';
  static const String httpClientNodeId = 'localsend.network.http_client';
  static const String httpServerNodeId = 'localsend.network.http_server';
  static const String signalingNodeId = 'localsend.network.signaling';

  static const String transferGroupNodeId = 'localsend.transfer';
  static const String sendManagerNodeId = 'localsend.transfer.send_sessions';
  static const String receiveManagerNodeId = 'localsend.transfer.receive_sessions';
  static const String sendSessionNodeId = 'localsend.transfer.send_session';
  static const String receiveSessionNodeId = 'localsend.transfer.receive_session';

  static const String storageGroupNodeId = 'localsend.storage';
  static const String fileSaverNodeId = 'localsend.storage.file_saver';
  static const String historyNodeId = 'localsend.storage.history';

  static const String settingsNodeId = 'localsend.settings';

  static const String edgeUiToSendId = 'edge.ui.send';
  static const String edgeUiToReceiveId = 'edge.ui.receive';
  static const String edgeDiscoveryToHttpId = 'edge.discovery.http';
  static const String edgeSecurityToRustCryptoId = 'edge.security.rust_crypto';
  static const String edgeSignalingToRustWebrtcId = 'edge.signaling.rust_webrtc';
  static const String edgeRustBridgeToWebrtcId = 'edge.rust_bridge.webrtc';
  static const String edgeRustBridgeToCryptoId = 'edge.rust_bridge.crypto';
  static const String edgeRustBridgeToLoggingId = 'edge.rust_bridge.logging';
  static const String edgeSendToHttpId = 'edge.send.http';
  static const String edgeReceiveToHttpId = 'edge.receive.http';
  static const String edgeReceiveToStorageId = 'edge.receive.storage';
  static const String edgeSendToHistoryId = 'edge.send.history';
  static const String edgeReceiveToHistoryId = 'edge.receive.history';
  static const String edgeSendManagerToSessionId = 'edge.send_manager.session';
  static const String edgeReceiveManagerToSessionId = 'edge.receive_manager.session';

  static const String tagUi = 'ui';
  static const String tagNetwork = 'network';
  static const String tagDiscovery = 'discovery';
  static const String tagNative = 'native';
  static const String tagRust = 'rust';
  static const String tagSecurity = 'security';
  static const String tagWebrtc = 'webrtc';
  static const String tagTransfer = 'transfer';
  static const String tagSend = 'send';
  static const String tagReceive = 'receive';
  static const String tagSession = 'session';
  static const String tagFile = 'file';
  static const String tagStorage = 'storage';
  static const String tagMetrics = 'metrics';
  static const String tagDiagnostics = 'diagnostics';
  static const String tagError = 'error';

  static const String sendChainId = 'localsend.send_flow';
  static const String receiveChainId = 'localsend.receive_flow';
  static const String sendFileChainId = 'localsend.send_file_flow';
  static const String receiveFileChainId = 'localsend.receive_file_flow';

  static const String metricFileSizeMb = 'localsend.transfer.file_size_mb';
  static const String metricFileDurationMs = 'localsend.transfer.file_duration_ms';
  static const String metricSessionDurationMs = 'localsend.transfer.session_duration_ms';
  static const String metricThroughputMbPerSec = 'localsend.transfer.throughput_mb_s';
  static const String metricFilesCount = 'localsend.transfer.files_count';

  static final List<_NodeSpec> _nodeSpecs = <_NodeSpec>[
    _NodeSpec(
      id: rootNodeId,
      label: 'LocalSend App',
      tags: <String>['app'],
      sourceRef: 'package:localsend_app/main.dart:1:1',
      standardType: UyavaStandardType.group,
    ),
    _NodeSpec(
      id: errorsNodeId,
      label: 'Errors',
      description: 'Unhandled errors and diagnostics',
      parentId: rootNodeId,
      tags: <String>[tagDiagnostics, tagError],
      sourceRef: 'package:localsend_app/config/init.dart:1:1',
      standardType: UyavaStandardType.event,
    ),
    _NodeSpec(
      id: nativeGroupNodeId,
      label: 'Native Core',
      parentId: rootNodeId,
      tags: <String>[tagNative],
      sourceRef: 'package:localsend_app/rust/frb_generated.dart:1:1',
      standardType: UyavaStandardType.group,
    ),
    _NodeSpec(
      id: rustBridgeNodeId,
      label: 'Rust Bridge',
      description: 'Flutter Rust Bridge bindings',
      parentId: nativeGroupNodeId,
      tags: <String>[tagNative, tagRust],
      sourceRef: 'package:localsend_app/rust/frb_generated.dart:1:1',
      standardType: UyavaStandardType.api,
    ),
    _NodeSpec(
      id: rustWebrtcNodeId,
      label: 'Rust WebRTC',
      description: 'WebRTC engine and signaling core',
      parentId: nativeGroupNodeId,
      tags: <String>[tagNative, tagRust, tagWebrtc],
      sourceRef: 'package:localsend_app/rust/api/webrtc.dart:1:1',
      standardType: UyavaStandardType.service,
    ),
    _NodeSpec(
      id: rustCryptoNodeId,
      label: 'Rust Crypto',
      description: 'Certificate verification',
      parentId: nativeGroupNodeId,
      tags: <String>[tagNative, tagRust, tagSecurity],
      sourceRef: 'package:localsend_app/rust/api/crypto.dart:1:1',
      standardType: UyavaStandardType.service,
    ),
    _NodeSpec(
      id: rustLoggingNodeId,
      label: 'Rust Logging',
      description: 'Native logging hooks',
      parentId: nativeGroupNodeId,
      tags: <String>[tagNative, tagRust],
      sourceRef: 'package:localsend_app/rust/api/logging.dart:1:1',
      standardType: UyavaStandardType.service,
    ),
    _NodeSpec(
      id: uiGroupNodeId,
      label: 'UI',
      parentId: rootNodeId,
      tags: <String>[tagUi],
      sourceRef: 'package:localsend_app/pages/home_page.dart:1:1',
      standardType: UyavaStandardType.group,
    ),
    _NodeSpec(
      id: uiHomeNodeId,
      label: 'Home',
      description: 'Main application shell',
      parentId: uiGroupNodeId,
      tags: <String>[tagUi],
      sourceRef: 'package:localsend_app/pages/home_page.dart:1:1',
      standardType: UyavaStandardType.screen,
    ),
    _NodeSpec(
      id: uiSendNodeId,
      label: 'Send Tab',
      description: 'Compose outbound transfers',
      parentId: uiGroupNodeId,
      tags: <String>[tagUi, tagSend],
      sourceRef: 'package:localsend_app/pages/tabs/send_tab.dart:1:1',
      standardType: UyavaStandardType.screen,
    ),
    _NodeSpec(
      id: uiReceiveNodeId,
      label: 'Receive Tab',
      description: 'Listen for inbound transfers',
      parentId: uiGroupNodeId,
      tags: <String>[tagUi, tagReceive],
      sourceRef: 'package:localsend_app/pages/tabs/receive_tab.dart:1:1',
      standardType: UyavaStandardType.screen,
    ),
    _NodeSpec(
      id: uiSettingsNodeId,
      label: 'Settings Tab',
      description: 'Tune app preferences',
      parentId: uiGroupNodeId,
      tags: <String>[tagUi, 'settings'],
      sourceRef: 'package:localsend_app/pages/tabs/settings_tab.dart:1:1',
      standardType: UyavaStandardType.screen,
    ),
    _NodeSpec(
      id: uiProgressNodeId,
      label: 'Progress View',
      description: 'Live transfer progress',
      parentId: uiGroupNodeId,
      tags: <String>[tagUi, tagTransfer],
      sourceRef: 'package:localsend_app/pages/progress_page.dart:1:1',
      standardType: UyavaStandardType.screen,
    ),
    _NodeSpec(
      id: networkGroupNodeId,
      label: 'Network',
      parentId: rootNodeId,
      tags: <String>[tagNetwork],
      sourceRef: 'package:localsend_app/provider/network/nearby_devices_provider.dart:1:1',
      standardType: UyavaStandardType.group,
    ),
    _NodeSpec(
      id: discoveryNodeId,
      label: 'Discovery',
      parentId: networkGroupNodeId,
      tags: <String>[tagNetwork, tagDiscovery],
      sourceRef: 'package:localsend_app/provider/network/nearby_devices_provider.dart:1:1',
      standardType: UyavaStandardType.service,
    ),
    _NodeSpec(
      id: securityNodeId,
      label: 'Security',
      description: 'Trust and certificate checks',
      parentId: networkGroupNodeId,
      tags: <String>[tagNetwork, tagSecurity],
      sourceRef: 'package:localsend_app/util/security_helper.dart:1:1',
      standardType: UyavaStandardType.service,
    ),
    _NodeSpec(
      id: httpClientNodeId,
      label: 'HTTP Client',
      parentId: networkGroupNodeId,
      tags: <String>[tagNetwork],
      sourceRef: 'package:localsend_app/provider/http_provider.dart:1:1',
      standardType: UyavaStandardType.api,
    ),
    _NodeSpec(
      id: httpServerNodeId,
      label: 'HTTP Server',
      parentId: networkGroupNodeId,
      tags: <String>[tagNetwork],
      sourceRef: 'package:localsend_app/provider/network/server/server_provider.dart:1:1',
      standardType: UyavaStandardType.api,
    ),
    _NodeSpec(
      id: signalingNodeId,
      label: 'Signaling',
      parentId: networkGroupNodeId,
      tags: <String>[tagNetwork],
      sourceRef: 'package:localsend_app/provider/network/webrtc/signaling_provider.dart:1:1',
      standardType: UyavaStandardType.service,
    ),
    _NodeSpec(
      id: transferGroupNodeId,
      label: 'Transfers',
      parentId: rootNodeId,
      tags: <String>[tagTransfer],
      sourceRef: 'package:localsend_app/provider/network/send_provider.dart:1:1',
      standardType: UyavaStandardType.group,
    ),
    _NodeSpec(
      id: sendManagerNodeId,
      label: 'Send Sessions',
      parentId: transferGroupNodeId,
      tags: <String>[tagTransfer, tagSend],
      sourceRef: 'package:localsend_app/provider/network/send_provider.dart:1:1',
      standardType: UyavaStandardType.manager,
    ),
    _NodeSpec(
      id: receiveManagerNodeId,
      label: 'Receive Sessions',
      parentId: transferGroupNodeId,
      tags: <String>[tagTransfer, tagReceive],
      sourceRef: 'package:localsend_app/provider/network/server/controller/receive_controller.dart:1:1',
      standardType: UyavaStandardType.manager,
    ),
    _NodeSpec(
      id: sendSessionNodeId,
      label: 'Send Session',
      description: 'Active outbound transfer',
      parentId: sendManagerNodeId,
      tags: <String>[tagTransfer, tagSend, tagSession],
      sourceRef: 'package:localsend_app/provider/network/send_provider.dart:1:1',
      standardType: UyavaStandardType.event,
    ),
    _NodeSpec(
      id: receiveSessionNodeId,
      label: 'Receive Session',
      description: 'Active inbound transfer',
      parentId: receiveManagerNodeId,
      tags: <String>[tagTransfer, tagReceive, tagSession],
      sourceRef: 'package:localsend_app/provider/network/server/controller/receive_controller.dart:1:1',
      standardType: UyavaStandardType.event,
    ),
    _NodeSpec(
      id: storageGroupNodeId,
      label: 'Storage',
      parentId: rootNodeId,
      tags: <String>[tagStorage],
      sourceRef: 'package:localsend_app/util/native/file_saver.dart:1:1',
      standardType: UyavaStandardType.group,
    ),
    _NodeSpec(
      id: fileSaverNodeId,
      label: 'File Saver',
      parentId: storageGroupNodeId,
      tags: <String>[tagStorage],
      sourceRef: 'package:localsend_app/util/native/file_saver.dart:1:1',
      standardType: UyavaStandardType.repository,
    ),
    _NodeSpec(
      id: historyNodeId,
      label: 'History',
      parentId: storageGroupNodeId,
      tags: <String>[tagStorage],
      sourceRef: 'package:localsend_app/provider/receive_history_provider.dart:1:1',
      standardType: UyavaStandardType.repository,
    ),
    _NodeSpec(
      id: settingsNodeId,
      label: 'Settings',
      parentId: rootNodeId,
      tags: <String>['settings'],
      sourceRef: 'package:localsend_app/provider/settings_provider.dart:1:1',
      standardType: UyavaStandardType.state,
    ),
  ];

  static Future<void> initialize({required List<String> args}) async {
    if (_initialized) {
      return;
    }
    _initialized = true;

    Uyava.initialize(defaultLifecycleState: UyavaLifecycleState.unknown);
    _registerGraph();
    _defineMetrics();
    _defineEventChains();
    _installErrorBridge();
    Uyava.updateNodesListLifecycle(
      nodeIds: _alwaysOnNodeIds,
      state: UyavaLifecycleState.initialized,
    );
    Uyava.updateNodesListLifecycle(
      nodeIds: _uiNodeIds,
      state: UyavaLifecycleState.disposed,
    );
    Uyava.updateNodesListLifecycle(
      nodeIds: _sessionNodeIds,
      state: UyavaLifecycleState.disposed,
    );

    if (_shouldEnableFileLogging(args)) {
      await _enableFileLogging(args);
    }
  }

  static void activateUiNode({
    required String nodeId,
    String? sourceRef,
    String? message,
  }) {
    final List<String> tags = _tagsForNode(nodeId, fallback: const <String>[tagUi]);
    Uyava.updateNodeLifecycle(
      nodeId: nodeId,
      state: UyavaLifecycleState.initialized,
    );
    Uyava.emitNodeEvent(
      nodeId: nodeId,
      message: message ?? 'UI activated',
      tags: tags,
      sourceRef: sourceRef,
    );
  }

  static void deactivateUiNode({
    required String nodeId,
    String? sourceRef,
    String? message,
  }) {
    final List<String> tags = _tagsForNode(nodeId, fallback: const <String>[tagUi]);
    Uyava.updateNodeLifecycle(
      nodeId: nodeId,
      state: UyavaLifecycleState.disposed,
    );
    Uyava.emitNodeEvent(
      nodeId: nodeId,
      message: message ?? 'UI deactivated',
      tags: tags,
      sourceRef: sourceRef,
    );
  }

  static void onUiTabChanged({
    required String fromNodeId,
    required String toNodeId,
    String? sourceRef,
  }) {
    if (fromNodeId != toNodeId) {
      deactivateUiNode(nodeId: fromNodeId, sourceRef: sourceRef, message: 'Tab hidden');
    }
    activateUiNode(nodeId: toNodeId, sourceRef: sourceRef, message: 'Tab shown');
  }

  static void onDiscoveryDevice({
    required Device device,
    required String transport,
    String? sourceRef,
  }) {
    final String alias = device.alias;
    Uyava.emitNodeEvent(
      nodeId: discoveryNodeId,
      message: 'Discovered $alias via $transport',
      tags: <String>[tagNetwork, tagDiscovery, 'transport:$transport'],
      payload: <String, dynamic>{
        'alias': alias,
        'ip': device.ip,
        'deviceModel': device.deviceModel,
        'deviceType': device.deviceType.name,
      },
      sourceRef: sourceRef,
    );
    Uyava.emitEdgeEvent(
      edge: edgeDiscoveryToHttpId,
      message: 'Discovery hit ($transport)',
      severity: UyavaSeverity.info,
      sourceRef: sourceRef,
    );
  }

  static void onSendSessionCreated({
    required String sessionId,
    required Device target,
    required int fileCount,
    required int totalBytes,
    required bool background,
    String? sourceRef,
  }) {
    Uyava.updateNodeLifecycle(
      nodeId: sendSessionNodeId,
      state: UyavaLifecycleState.initialized,
    );
    Uyava.emitNodeEvent(
      nodeId: sendSessionNodeId,
      message: 'Send session created',
      tags: const <String>[tagTransfer, tagSend, tagSession],
      payload: <String, dynamic>{
        'sessionId': sessionId,
        'targetAlias': target.alias,
        'targetDeviceType': target.deviceType.name,
        'fileCount': fileCount,
        'totalBytes': totalBytes,
        'background': background,
        'metric': _metric(metricFilesCount, fileCount),
      },
      sourceRef: sourceRef,
    );
    _emitChainStep(
      nodeId: sendSessionNodeId,
      chainId: sendChainId,
      stepId: 'session_created',
      attempt: sessionId,
      edgeId: edgeUiToSendId,
      message: 'Send session started',
      tags: <String>[tagSend, tagSession],
      sourceRef: sourceRef,
    );
  }

  static void onSendPrepareAccepted({
    required String sessionId,
    required int acceptedCount,
    String? sourceRef,
  }) {
    _emitChainStep(
      nodeId: httpClientNodeId,
      chainId: sendChainId,
      stepId: 'prepare_upload',
      attempt: sessionId,
      edgeId: edgeSendToHttpId,
      message: 'Prepare upload accepted',
      tags: <String>[tagSend, tagNetwork],
      payload: <String, dynamic>{
        'sessionId': sessionId,
        'acceptedCount': acceptedCount,
      },
      sourceRef: sourceRef,
    );
  }

  static void onSendPrepareRejected({
    required String sessionId,
    required String reason,
    UyavaSeverity severity = UyavaSeverity.warn,
    String? sourceRef,
  }) {
    Uyava.emitNodeEvent(
      nodeId: sendSessionNodeId,
      message: 'Prepare upload rejected',
      severity: severity,
      tags: <String>[tagSend, tagSession],
      payload: <String, dynamic>{
        'sessionId': sessionId,
        'reason': reason,
      },
      sourceRef: sourceRef,
    );
  }

  static void onSendFileStarted({
    required String sessionId,
    required FileDto file,
    required int isolateIndex,
    String? sourceRef,
  }) {
    _trackFile(_activeSendFiles, sessionId, file);
    Uyava.emitNodeEvent(
      nodeId: sendSessionNodeId,
      message: 'Sending ${file.fileName}',
      tags: <String>[tagSend, tagFile],
      payload: <String, dynamic>{
        'sessionId': sessionId,
        'fileId': file.id,
        'fileSize': file.size,
        'isolateIndex': isolateIndex,
        'metric': _metric(metricFileSizeMb, _bytesToMb(file.size)),
      },
      sourceRef: sourceRef,
    );
    Uyava.emitEdgeEvent(
      edge: edgeSendToHttpId,
      message: 'Upload ${file.fileName}',
      severity: UyavaSeverity.info,
      sourceRef: sourceRef,
    );
    _emitChainStep(
      nodeId: httpClientNodeId,
      chainId: sendFileChainId,
      stepId: 'file_upload_start',
      attempt: file.id,
      edgeId: edgeSendToHttpId,
      message: 'Uploading ${file.fileName}',
      tags: <String>[tagSend, tagFile, tagNetwork],
      payload: <String, dynamic>{
        'sessionId': sessionId,
        'fileId': file.id,
        'fileName': file.fileName,
        'fileSize': file.size,
      },
      sourceRef: sourceRef,
    );
  }

  static void onSendFileFinished({
    required String sessionId,
    required FileDto file,
    required bool success,
    required int? durationMs,
    String? errorMessage,
    String? sourceRef,
  }) {
    Uyava.emitNodeEvent(
      nodeId: sendSessionNodeId,
      message: success ? 'Send complete' : 'Send failed',
      severity: success ? UyavaSeverity.info : UyavaSeverity.error,
      tags: <String>[tagSend, tagFile],
      payload: <String, dynamic>{
        'sessionId': sessionId,
        'fileId': file.id,
        'fileName': file.fileName,
        'fileSize': file.size,
        if (durationMs != null) 'durationMs': durationMs,
        if (errorMessage != null) 'error': errorMessage,
        if (durationMs != null)
          'metric': _metric(metricFileDurationMs, durationMs),
      },
      sourceRef: sourceRef,
    );
    if (durationMs != null && durationMs > 0) {
      final double throughput = _bytesToMb(file.size) / (durationMs / 1000);
      Uyava.emitNodeEvent(
        nodeId: sendSessionNodeId,
        message: 'Upload throughput sample',
        tags: <String>[tagSend, tagMetrics],
        payload: <String, dynamic>{
          'sessionId': sessionId,
          'fileId': file.id,
          'metric': _metric(metricThroughputMbPerSec, throughput),
        },
        sourceRef: sourceRef,
      );
    }
    _emitChainStep(
      nodeId: historyNodeId,
      chainId: sendFileChainId,
      stepId: 'file_upload_complete',
      attempt: file.id,
      edgeId: edgeSendToHistoryId,
      message: success ? 'Recorded ${file.fileName}' : 'Upload failed for ${file.fileName}',
      severity: success ? UyavaSeverity.info : UyavaSeverity.error,
      status: success ? null : 'failed',
      tags: <String>[tagSend, tagFile],
      payload: <String, dynamic>{
        'sessionId': sessionId,
        'fileId': file.id,
        'fileName': file.fileName,
        if (errorMessage != null) 'error': errorMessage,
      },
      sourceRef: sourceRef,
    );
    _untrackFile(_activeSendFiles, sessionId, file.id);
  }

  static void onSendSessionFinished({
    required String sessionId,
    required bool success,
    required int? durationMs,
    String? sourceRef,
  }) {
    _emitChainStep(
      nodeId: sendSessionNodeId,
      chainId: sendChainId,
      stepId: 'transfer_complete',
      attempt: sessionId,
      edgeId: edgeSendToHistoryId,
      message: success ? 'Send session finished' : 'Send session failed',
      severity: success ? UyavaSeverity.info : UyavaSeverity.error,
      status: success ? null : 'failed',
      tags: <String>[tagSend, tagSession],
      payload: <String, dynamic>{
        'sessionId': sessionId,
        if (durationMs != null)
          'metric': _metric(metricSessionDurationMs, durationMs),
      },
      sourceRef: sourceRef,
    );
    if (!success) {
      _failPendingFiles(
        fileMap: _activeSendFiles,
        sessionId: sessionId,
        chainId: sendFileChainId,
        stepId: 'file_upload_complete',
        nodeId: historyNodeId,
        edgeId: edgeSendToHistoryId,
        tags: const <String>[tagSend, tagFile],
        reason: 'session_failed',
        sourceRef: sourceRef,
      );
    } else {
      _activeSendFiles.remove(sessionId);
    }
    Uyava.updateNodeLifecycle(
      nodeId: sendSessionNodeId,
      state: UyavaLifecycleState.disposed,
    );
  }

  static void onSendSessionCanceled({
    required String sessionId,
    required String reason,
    String? sourceRef,
  }) {
    _emitChainStep(
      nodeId: sendSessionNodeId,
      chainId: sendChainId,
      stepId: 'transfer_complete',
      attempt: sessionId,
      edgeId: edgeSendToHistoryId,
      message: 'Send session canceled',
      severity: UyavaSeverity.error,
      status: 'failed',
      tags: const <String>[tagSend, tagSession],
      payload: <String, dynamic>{
        'sessionId': sessionId,
        'reason': reason,
      },
      sourceRef: sourceRef,
    );
    Uyava.emitNodeEvent(
      nodeId: sendSessionNodeId,
      message: 'Send session canceled',
      severity: UyavaSeverity.error,
      tags: const <String>[tagSend, tagSession],
      payload: <String, dynamic>{
        'sessionId': sessionId,
        'reason': reason,
      },
      sourceRef: sourceRef,
    );
    _failPendingFiles(
      fileMap: _activeSendFiles,
      sessionId: sessionId,
      chainId: sendFileChainId,
      stepId: 'file_upload_complete',
      nodeId: historyNodeId,
      edgeId: edgeSendToHistoryId,
      tags: const <String>[tagSend, tagFile],
      reason: reason,
      sourceRef: sourceRef,
    );
    Uyava.updateNodeLifecycle(
      nodeId: sendSessionNodeId,
      state: UyavaLifecycleState.disposed,
    );
  }

  static void onReceiveSessionCreated({
    required String sessionId,
    required String senderAlias,
    required int fileCount,
    required bool quickSave,
    String? sourceRef,
  }) {
    Uyava.updateNodeLifecycle(
      nodeId: receiveSessionNodeId,
      state: UyavaLifecycleState.initialized,
    );
    Uyava.emitNodeEvent(
      nodeId: receiveSessionNodeId,
      message: 'Incoming transfer request',
      tags: <String>[tagReceive, tagSession],
      payload: <String, dynamic>{
        'sessionId': sessionId,
        'senderAlias': senderAlias,
        'fileCount': fileCount,
        'quickSave': quickSave,
        'metric': _metric(metricFilesCount, fileCount),
      },
      sourceRef: sourceRef,
    );
    _emitChainStep(
      nodeId: receiveSessionNodeId,
      chainId: receiveChainId,
      stepId: 'incoming_request',
      attempt: sessionId,
      edgeId: edgeReceiveToHttpId,
      message: 'Incoming receive request',
      tags: <String>[tagReceive, tagSession],
      sourceRef: sourceRef,
    );
  }

  static void onReceiveDecision({
    required String sessionId,
    required bool accepted,
    required int selectedCount,
    required bool quickSave,
    String? sourceRef,
  }) {
    if (accepted) {
      _emitChainStep(
        nodeId: uiReceiveNodeId,
        chainId: receiveChainId,
        stepId: 'user_accept',
        attempt: sessionId,
        edgeId: edgeUiToReceiveId,
        message: quickSave ? 'Auto-accepted files' : 'User accepted files',
        tags: <String>[tagReceive, tagSession],
        payload: <String, dynamic>{
          'sessionId': sessionId,
          'selectedCount': selectedCount,
          'quickSave': quickSave,
        },
        sourceRef: sourceRef,
      );
    } else {
      Uyava.emitNodeEvent(
        nodeId: uiReceiveNodeId,
        message: 'User declined transfer',
        severity: UyavaSeverity.warn,
        tags: <String>[tagReceive, tagSession],
        payload: <String, dynamic>{
          'sessionId': sessionId,
          'selectedCount': selectedCount,
        },
        sourceRef: sourceRef,
      );
    }
  }

  static void onReceiveTransferStarted({
    required String sessionId,
    required int selectedCount,
    String? sourceRef,
  }) {
    Uyava.emitNodeEvent(
      nodeId: receiveSessionNodeId,
      message: 'Receiving files',
      tags: <String>[tagReceive, tagSession],
      payload: <String, dynamic>{
        'sessionId': sessionId,
        'selectedCount': selectedCount,
      },
      sourceRef: sourceRef,
    );
    Uyava.emitEdgeEvent(
      edge: edgeReceiveToStorageId,
      message: 'Write incoming files',
      severity: UyavaSeverity.info,
      sourceRef: sourceRef,
    );
  }

  static void onReceiveFileStarted({
    required String sessionId,
    required FileDto file,
    String? sourceRef,
  }) {
    _trackFile(_activeReceiveFiles, sessionId, file);
    Uyava.emitNodeEvent(
      nodeId: receiveSessionNodeId,
      message: 'Receiving ${file.fileName}',
      tags: <String>[tagReceive, tagFile],
      payload: <String, dynamic>{
        'sessionId': sessionId,
        'fileId': file.id,
        'fileSize': file.size,
        'metric': _metric(metricFileSizeMb, _bytesToMb(file.size)),
      },
      sourceRef: sourceRef,
    );
    _emitChainStep(
      nodeId: httpServerNodeId,
      chainId: receiveFileChainId,
      stepId: 'file_download_start',
      attempt: file.id,
      edgeId: edgeReceiveToHttpId,
      message: 'Receiving ${file.fileName}',
      tags: <String>[tagReceive, tagFile, tagNetwork],
      payload: <String, dynamic>{
        'sessionId': sessionId,
        'fileId': file.id,
        'fileName': file.fileName,
        'fileSize': file.size,
      },
      sourceRef: sourceRef,
    );
  }

  static void onReceiveFileFinished({
    required String sessionId,
    required FileDto file,
    required bool success,
    required int? durationMs,
    String? filePath,
    String? errorMessage,
    String? sourceRef,
  }) {
    Uyava.emitNodeEvent(
      nodeId: receiveSessionNodeId,
      message: success ? 'Receive complete' : 'Receive failed',
      severity: success ? UyavaSeverity.info : UyavaSeverity.error,
      tags: <String>[tagReceive, tagFile],
      payload: <String, dynamic>{
        'sessionId': sessionId,
        'fileId': file.id,
        'fileName': file.fileName,
        'fileSize': file.size,
        if (filePath != null) 'path': filePath,
        if (durationMs != null) 'durationMs': durationMs,
        if (errorMessage != null) 'error': errorMessage,
        if (durationMs != null)
          'metric': _metric(metricFileDurationMs, durationMs),
      },
      sourceRef: sourceRef,
    );
    if (durationMs != null && durationMs > 0) {
      final double throughput = _bytesToMb(file.size) / (durationMs / 1000);
      Uyava.emitNodeEvent(
        nodeId: receiveSessionNodeId,
        message: 'Receive throughput sample',
        tags: <String>[tagReceive, tagMetrics],
        payload: <String, dynamic>{
          'sessionId': sessionId,
          'fileId': file.id,
          'metric': _metric(metricThroughputMbPerSec, throughput),
        },
        sourceRef: sourceRef,
      );
    }
    _emitChainStep(
      nodeId: fileSaverNodeId,
      chainId: receiveFileChainId,
      stepId: 'file_saved',
      attempt: file.id,
      edgeId: edgeReceiveToStorageId,
      message: success ? 'Saved ${file.fileName}' : 'Failed to save ${file.fileName}',
      severity: success ? UyavaSeverity.info : UyavaSeverity.error,
      status: success ? null : 'failed',
      tags: <String>[tagReceive, tagFile, tagStorage],
      payload: <String, dynamic>{
        'sessionId': sessionId,
        'fileId': file.id,
        'fileName': file.fileName,
        if (filePath != null) 'path': filePath,
        if (errorMessage != null) 'error': errorMessage,
      },
      sourceRef: sourceRef,
    );
    _untrackFile(_activeReceiveFiles, sessionId, file.id);
  }

  static void onReceiveSessionFinished({
    required String sessionId,
    required bool success,
    required int? durationMs,
    String? sourceRef,
  }) {
    _emitChainStep(
      nodeId: receiveSessionNodeId,
      chainId: receiveChainId,
      stepId: 'transfer_complete',
      attempt: sessionId,
      edgeId: edgeReceiveToHistoryId,
      message: success ? 'Receive session finished' : 'Receive session failed',
      severity: success ? UyavaSeverity.info : UyavaSeverity.error,
      status: success ? null : 'failed',
      tags: <String>[tagReceive, tagSession],
      payload: <String, dynamic>{
        'sessionId': sessionId,
        if (durationMs != null)
          'metric': _metric(metricSessionDurationMs, durationMs),
      },
      sourceRef: sourceRef,
    );
    if (!success) {
      _failPendingFiles(
        fileMap: _activeReceiveFiles,
        sessionId: sessionId,
        chainId: receiveFileChainId,
        stepId: 'file_saved',
        nodeId: fileSaverNodeId,
        edgeId: edgeReceiveToStorageId,
        tags: const <String>[tagReceive, tagFile, tagStorage],
        reason: 'session_failed',
        sourceRef: sourceRef,
      );
    } else {
      _activeReceiveFiles.remove(sessionId);
    }
    Uyava.updateNodeLifecycle(
      nodeId: receiveSessionNodeId,
      state: UyavaLifecycleState.disposed,
    );
  }

  static void onReceiveSessionCanceled({
    required String sessionId,
    required String reason,
    String? sourceRef,
  }) {
    _emitChainStep(
      nodeId: receiveSessionNodeId,
      chainId: receiveChainId,
      stepId: 'transfer_complete',
      attempt: sessionId,
      edgeId: edgeReceiveToHistoryId,
      message: 'Receive session canceled',
      severity: UyavaSeverity.error,
      status: 'failed',
      tags: const <String>[tagReceive, tagSession],
      payload: <String, dynamic>{
        'sessionId': sessionId,
        'reason': reason,
      },
      sourceRef: sourceRef,
    );
    Uyava.emitNodeEvent(
      nodeId: receiveSessionNodeId,
      message: 'Receive session canceled',
      severity: UyavaSeverity.error,
      tags: const <String>[tagReceive, tagSession],
      payload: <String, dynamic>{
        'sessionId': sessionId,
        'reason': reason,
      },
      sourceRef: sourceRef,
    );
    _failPendingFiles(
      fileMap: _activeReceiveFiles,
      sessionId: sessionId,
      chainId: receiveFileChainId,
      stepId: 'file_saved',
      nodeId: fileSaverNodeId,
      edgeId: edgeReceiveToStorageId,
      tags: const <String>[tagReceive, tagFile, tagStorage],
      reason: reason,
      sourceRef: sourceRef,
    );
    Uyava.updateNodeLifecycle(
      nodeId: receiveSessionNodeId,
      state: UyavaLifecycleState.disposed,
    );
  }

  static void _registerGraph() {
    Uyava.replaceGraph();
    for (final _NodeSpec spec in _nodeSpecs) {
      Uyava.addNode(
        UyavaNode.standard(
          id: spec.id,
          standardType: spec.standardType,
          label: spec.label,
          description: spec.description,
          parentId: spec.parentId,
          tags: spec.tags,
        ),
        sourceRef: spec.sourceRef,
      );
    }

    const List<UyavaEdge> edges = <UyavaEdge>[
      UyavaEdge(
        id: edgeUiToSendId,
        from: uiSendNodeId,
        to: sendSessionNodeId,
        label: 'start send',
      ),
      UyavaEdge(
        id: edgeUiToReceiveId,
        from: uiReceiveNodeId,
        to: receiveSessionNodeId,
        label: 'accept receive',
      ),
      UyavaEdge(
        id: edgeDiscoveryToHttpId,
        from: discoveryNodeId,
        to: httpClientNodeId,
        label: 'discover via HTTP',
      ),
      UyavaEdge(
        id: edgeSecurityToRustCryptoId,
        from: securityNodeId,
        to: rustCryptoNodeId,
        label: 'verify cert',
      ),
      UyavaEdge(
        id: edgeSignalingToRustWebrtcId,
        from: signalingNodeId,
        to: rustWebrtcNodeId,
        label: 'RTC signaling',
      ),
      UyavaEdge(
        id: edgeRustBridgeToWebrtcId,
        from: rustBridgeNodeId,
        to: rustWebrtcNodeId,
        label: 'FRB call',
      ),
      UyavaEdge(
        id: edgeRustBridgeToCryptoId,
        from: rustBridgeNodeId,
        to: rustCryptoNodeId,
        label: 'FRB call',
      ),
      UyavaEdge(
        id: edgeRustBridgeToLoggingId,
        from: rustBridgeNodeId,
        to: rustLoggingNodeId,
        label: 'FRB call',
      ),
      UyavaEdge(
        id: edgeSendManagerToSessionId,
        from: sendManagerNodeId,
        to: sendSessionNodeId,
        label: 'manage send session',
      ),
      UyavaEdge(
        id: edgeReceiveManagerToSessionId,
        from: receiveManagerNodeId,
        to: receiveSessionNodeId,
        label: 'manage receive session',
      ),
      UyavaEdge(
        id: edgeSendToHttpId,
        from: sendSessionNodeId,
        to: httpClientNodeId,
        label: 'prepare/upload',
      ),
      UyavaEdge(
        id: edgeReceiveToHttpId,
        from: receiveSessionNodeId,
        to: httpServerNodeId,
        label: 'incoming upload',
      ),
      UyavaEdge(
        id: edgeReceiveToStorageId,
        from: receiveSessionNodeId,
        to: fileSaverNodeId,
        label: 'save files',
      ),
      UyavaEdge(
        id: edgeSendToHistoryId,
        from: sendSessionNodeId,
        to: historyNodeId,
        label: 'record send history',
      ),
      UyavaEdge(
        id: edgeReceiveToHistoryId,
        from: receiveSessionNodeId,
        to: historyNodeId,
        label: 'record receive history',
      ),
    ];

    for (final UyavaEdge edge in edges) {
      Uyava.addEdge(edge);
    }
  }

  static void _defineMetrics() {
    Uyava.defineMetric(
      id: metricFileSizeMb,
      label: 'Transfer size (MB)',
      unit: 'MB',
      tags: const <String>[tagTransfer, tagFile, tagMetrics],
      aggregators: const <UyavaMetricAggregator>[
        UyavaMetricAggregator.last,
        UyavaMetricAggregator.max,
        UyavaMetricAggregator.sum,
      ],
    );
    Uyava.defineMetric(
      id: metricFileDurationMs,
      label: 'Transfer duration (ms)',
      unit: 'ms',
      tags: const <String>[tagTransfer, tagFile, tagMetrics],
      aggregators: const <UyavaMetricAggregator>[
        UyavaMetricAggregator.last,
        UyavaMetricAggregator.max,
        UyavaMetricAggregator.min,
      ],
    );
    Uyava.defineMetric(
      id: metricSessionDurationMs,
      label: 'Session duration (ms)',
      unit: 'ms',
      tags: const <String>[tagTransfer, tagSession, tagMetrics],
      aggregators: const <UyavaMetricAggregator>[
        UyavaMetricAggregator.last,
        UyavaMetricAggregator.max,
        UyavaMetricAggregator.min,
      ],
    );
    Uyava.defineMetric(
      id: metricThroughputMbPerSec,
      label: 'Throughput (MB/s)',
      unit: 'MB/s',
      tags: const <String>[tagTransfer, tagMetrics],
      aggregators: const <UyavaMetricAggregator>[
        UyavaMetricAggregator.last,
        UyavaMetricAggregator.max,
        UyavaMetricAggregator.min,
      ],
    );
    Uyava.defineMetric(
      id: metricFilesCount,
      label: 'Files per session',
      unit: 'count',
      tags: const <String>[tagTransfer, tagSession, tagMetrics],
      aggregators: const <UyavaMetricAggregator>[UyavaMetricAggregator.last],
    );
  }

  static void _defineEventChains() {
    Uyava.defineEventChain(
      id: sendChainId,
      tag: 'chain:send',
      label: 'Send Flow',
      description: 'Prepare and complete a send session',
      steps: const <UyavaEventChainStep>[
        UyavaEventChainStep(stepId: 'session_created', nodeId: sendSessionNodeId, edgeId: edgeUiToSendId),
        UyavaEventChainStep(stepId: 'prepare_upload', nodeId: httpClientNodeId, edgeId: edgeSendToHttpId),
        UyavaEventChainStep(stepId: 'transfer_complete', nodeId: sendSessionNodeId, edgeId: edgeSendToHistoryId),
      ],
    );
    Uyava.defineEventChain(
      id: receiveChainId,
      tag: 'chain:receive',
      label: 'Receive Flow',
      description: 'Accept and complete a receive session',
      steps: const <UyavaEventChainStep>[
        UyavaEventChainStep(stepId: 'incoming_request', nodeId: receiveSessionNodeId, edgeId: edgeReceiveToHttpId),
        UyavaEventChainStep(stepId: 'user_accept', nodeId: uiReceiveNodeId, edgeId: edgeUiToReceiveId),
        UyavaEventChainStep(stepId: 'transfer_complete', nodeId: receiveSessionNodeId, edgeId: edgeReceiveToHistoryId),
      ],
    );
    Uyava.defineEventChain(
      id: sendFileChainId,
      tag: 'chain:send-file',
      label: 'Send File Flow',
      description: 'Upload and record a single file',
      steps: const <UyavaEventChainStep>[
        UyavaEventChainStep(stepId: 'file_upload_start', nodeId: httpClientNodeId, edgeId: edgeSendToHttpId),
        UyavaEventChainStep(stepId: 'file_upload_complete', nodeId: historyNodeId, edgeId: edgeSendToHistoryId),
      ],
    );
    Uyava.defineEventChain(
      id: receiveFileChainId,
      tag: 'chain:receive-file',
      label: 'Receive File Flow',
      description: 'Download and store a single file',
      steps: const <UyavaEventChainStep>[
        UyavaEventChainStep(stepId: 'file_download_start', nodeId: httpServerNodeId, edgeId: edgeReceiveToHttpId),
        UyavaEventChainStep(stepId: 'file_saved', nodeId: fileSaverNodeId, edgeId: edgeReceiveToStorageId),
      ],
    );
  }

  static void _installErrorBridge() {
    if (_errorBridgeInstalled) {
      return;
    }
    _errorBridgeInstalled = true;

    final FlutterExceptionHandler? previousFlutterHandler = FlutterError.onError;
    FlutterError.onError = (FlutterErrorDetails details) {
      if (previousFlutterHandler != null) {
        previousFlutterHandler(details);
      } else {
        FlutterError.dumpErrorToConsole(details);
      }
      _emitFlutterError(details);
    };

    final ui.PlatformDispatcher dispatcher = ui.PlatformDispatcher.instance;
    final bool Function(Object, StackTrace)? previousPlatformHandler = dispatcher.onError;
    dispatcher.onError = (Object error, StackTrace stack) {
      final bool handled = previousPlatformHandler?.call(error, stack) ?? false;
      _emitPlatformError(error, stack);
      return handled;
    };
  }

  static void onRustBridgeReady({String? sourceRef}) {
    Uyava.emitNodeEvent(
      nodeId: rustBridgeNodeId,
      message: 'Rust bridge ready',
      tags: const <String>[tagNative, tagRust],
      sourceRef: sourceRef,
    );
  }

  static void onRustLoggingEnabled({
    required bool success,
    String? sourceRef,
    String? error,
  }) {
    Uyava.emitNodeEvent(
      nodeId: rustLoggingNodeId,
      message: success ? 'Rust logging enabled' : 'Rust logging failed',
      severity: success ? UyavaSeverity.info : UyavaSeverity.error,
      tags: const <String>[tagNative, tagRust],
      payload: <String, dynamic>{
        'success': success,
        if (error != null) 'error': error,
      },
      sourceRef: sourceRef,
    );
    Uyava.emitEdgeEvent(
      edge: edgeRustBridgeToLoggingId,
      message: success ? 'Enable logging' : 'Enable logging failed',
      severity: success ? UyavaSeverity.info : UyavaSeverity.error,
      sourceRef: sourceRef,
    );
  }

  static void onRustCryptoVerify({
    required bool success,
    String? sourceRef,
    String? error,
  }) {
    Uyava.emitNodeEvent(
      nodeId: securityNodeId,
      message: success ? 'Certificate verified' : 'Certificate verification failed',
      severity: success ? UyavaSeverity.info : UyavaSeverity.error,
      tags: const <String>[tagSecurity],
      payload: <String, dynamic>{
        'success': success,
        if (error != null) 'error': error,
      },
      sourceRef: sourceRef,
    );
    Uyava.emitEdgeEvent(
      edge: edgeSecurityToRustCryptoId,
      message: 'Verify certificate',
      severity: success ? UyavaSeverity.info : UyavaSeverity.error,
      sourceRef: sourceRef,
    );
    Uyava.emitEdgeEvent(
      edge: edgeRustBridgeToCryptoId,
      message: 'FRB crypto call',
      severity: success ? UyavaSeverity.info : UyavaSeverity.error,
      sourceRef: sourceRef,
    );
  }

  static void onRustCryptoKeyGenerated({String? sourceRef}) {
    Uyava.emitNodeEvent(
      nodeId: rustCryptoNodeId,
      message: 'Key pair generated',
      tags: const <String>[tagNative, tagRust, tagSecurity],
      sourceRef: sourceRef,
    );
    Uyava.emitEdgeEvent(
      edge: edgeRustBridgeToCryptoId,
      message: 'FRB crypto call',
      severity: UyavaSeverity.info,
      sourceRef: sourceRef,
    );
  }

  static void onRustWebrtcConnect({
    required String signalingServer,
    String? sourceRef,
  }) {
    Uyava.emitNodeEvent(
      nodeId: signalingNodeId,
      message: 'Connect WebRTC signaling',
      tags: const <String>[tagNetwork, tagWebrtc],
      payload: <String, dynamic>{
        'server': signalingServer,
      },
      sourceRef: sourceRef,
    );
    Uyava.emitEdgeEvent(
      edge: edgeSignalingToRustWebrtcId,
      message: 'Connect signaling',
      severity: UyavaSeverity.info,
      sourceRef: sourceRef,
    );
    Uyava.emitEdgeEvent(
      edge: edgeRustBridgeToWebrtcId,
      message: 'FRB WebRTC call',
      severity: UyavaSeverity.info,
      sourceRef: sourceRef,
    );
  }

  static void onRustWebrtcOfferAccepted({
    required String sessionId,
    String? sourceRef,
  }) {
    Uyava.emitNodeEvent(
      nodeId: rustWebrtcNodeId,
      message: 'WebRTC offer accepted',
      tags: const <String>[tagNative, tagRust, tagWebrtc],
      payload: <String, dynamic>{
        'sessionId': sessionId,
      },
      sourceRef: sourceRef,
    );
    Uyava.emitEdgeEvent(
      edge: edgeSignalingToRustWebrtcId,
      message: 'Accept offer',
      severity: UyavaSeverity.info,
      sourceRef: sourceRef,
    );
    Uyava.emitEdgeEvent(
      edge: edgeRustBridgeToWebrtcId,
      message: 'FRB WebRTC call',
      severity: UyavaSeverity.info,
      sourceRef: sourceRef,
    );
  }

  static void _emitFlutterError(FlutterErrorDetails details) {
    Uyava.emitNodeEvent(
      nodeId: errorsNodeId,
      message: details.exceptionAsString(),
      severity: UyavaSeverity.error,
      tags: const <String>[tagDiagnostics, tagError, 'source:flutter'],
      payload: <String, dynamic>{
        'kind': 'flutter',
        'exception': details.exceptionAsString(),
        if (details.stack != null) 'stack': details.stack.toString(),
        if (details.library != null) 'library': details.library,
        if (details.context != null) 'context': details.context?.toDescription(),
        if (details.silent) 'silent': true,
      },
    );
  }

  static void _emitPlatformError(Object error, StackTrace stack) {
    Uyava.emitNodeEvent(
      nodeId: errorsNodeId,
      message: error.toString(),
      severity: UyavaSeverity.error,
      tags: const <String>[tagDiagnostics, tagError, 'source:platform'],
      payload: <String, dynamic>{
        'kind': 'platform',
        'error': error.toString(),
        'stack': stack.toString(),
      },
    );
  }

  static const List<String> _uiNodeIds = <String>[
    uiHomeNodeId,
    uiSendNodeId,
    uiReceiveNodeId,
    uiSettingsNodeId,
    uiProgressNodeId,
  ];

  static const List<String> _sessionNodeIds = <String>[
    sendSessionNodeId,
    receiveSessionNodeId,
  ];

  static const List<String> _alwaysOnNodeIds = <String>[
        rootNodeId,
        errorsNodeId,
        nativeGroupNodeId,
        rustBridgeNodeId,
        rustWebrtcNodeId,
        rustCryptoNodeId,
        rustLoggingNodeId,
        uiGroupNodeId,
        networkGroupNodeId,
        discoveryNodeId,
        securityNodeId,
        httpClientNodeId,
        httpServerNodeId,
        signalingNodeId,
        transferGroupNodeId,
        sendManagerNodeId,
        receiveManagerNodeId,
        storageGroupNodeId,
        fileSaverNodeId,
        historyNodeId,
        settingsNodeId,
      ];

  static final Map<String, _NodeSpec> _nodeSpecsById = <String, _NodeSpec>{
    for (final _NodeSpec spec in _nodeSpecs) spec.id: spec,
  };

  static List<String> _tagsForNode(String nodeId, {List<String>? fallback}) {
    final _NodeSpec? spec = _nodeSpecsById[nodeId];
    if (spec == null) {
      return fallback ?? const <String>[];
    }
    return spec.tags;
  }

  static Map<String, dynamic> _metric(String id, Object value) {
    return <String, dynamic>{
      'id': id,
      'value': value,
      'timestamp': DateTime.now().toUtc().toIso8601String(),
    };
  }

  static double _bytesToMb(int bytes) => bytes / (1024 * 1024);

  static void _trackFile(
    Map<String, Map<String, FileDto>> fileMap,
    String sessionId,
    FileDto file,
  ) {
    final Map<String, FileDto> files = fileMap.putIfAbsent(sessionId, () => <String, FileDto>{});
    files[file.id] = file;
  }

  static void _untrackFile(
    Map<String, Map<String, FileDto>> fileMap,
    String sessionId,
    String fileId,
  ) {
    final Map<String, FileDto>? files = fileMap[sessionId];
    if (files == null) {
      return;
    }
    files.remove(fileId);
    if (files.isEmpty) {
      fileMap.remove(sessionId);
    }
  }

  static void _failPendingFiles({
    required Map<String, Map<String, FileDto>> fileMap,
    required String sessionId,
    required String chainId,
    required String stepId,
    required String nodeId,
    required String edgeId,
    required List<String> tags,
    required String reason,
    String? sourceRef,
  }) {
    final Map<String, FileDto>? files = fileMap.remove(sessionId);
    if (files == null || files.isEmpty) {
      return;
    }
    for (final FileDto file in files.values) {
      _emitChainStep(
        nodeId: nodeId,
        chainId: chainId,
        stepId: stepId,
        attempt: file.id,
        edgeId: edgeId,
        message: 'Canceled ${file.fileName}',
        severity: UyavaSeverity.error,
        status: 'failed',
        tags: tags,
        payload: <String, dynamic>{
          'sessionId': sessionId,
          'fileId': file.id,
          'fileName': file.fileName,
          'reason': reason,
        },
        sourceRef: sourceRef,
      );
    }
  }

  static void _emitChainStep({
    required String nodeId,
    required String chainId,
    required String stepId,
    required String attempt,
    required String message,
    String? edgeId,
    String? status,
    UyavaSeverity? severity,
    List<String>? tags,
    Map<String, dynamic>? payload,
    String? sourceRef,
  }) {
    Uyava.emitNodeEvent(
      nodeId: nodeId,
      message: message,
      severity: severity,
      tags: tags,
      payload: <String, dynamic>{
        'chain': <String, String>{
          'id': chainId,
          'step': stepId,
          'attempt': attempt,
          if (status != null) 'status': status,
        },
        if (edgeId != null) 'edgeId': edgeId,
        if (status != null) 'status': status,
        if (payload != null) ...payload,
      },
      sourceRef: sourceRef,
    );
  }

  static bool _shouldEnableFileLogging(List<String> args) {
    if (kIsWeb) {
      return false;
    }
    if (args.any((arg) => arg == '--uyava-log' || arg == '--uyava-logs')) {
      return true;
    }
    final String? envValue = Platform.environment['UYAVA_LOG'];
    if (envValue == null) {
      return false;
    }
    return envValue == '1' || envValue.toLowerCase() == 'true';
  }

  static Future<void> _enableFileLogging(List<String> args) async {
    final String? overrideDir = _extractArgValue(args, '--uyava-log-dir');
    try {
      final String logDir = overrideDir ?? await _resolveLogDirectory();
      await Directory(logDir).create(recursive: true);
      await Uyava.enableFileLogging(
        config: UyavaFileLoggerConfig(
          directoryPath: logDir,
          filePrefix: 'localsend',
          realtimeSamplingRate: 1.0,
          realtimeBurstLimitPerSecond: 500,
        ),
      );
      Uyava.emitNodeEvent(
        nodeId: storageGroupNodeId,
        message: 'Uyava file logging enabled',
        tags: const <String>[tagStorage, 'uyava'],
        payload: <String, dynamic>{
          'directory': logDir,
        },
      );
    } catch (e, st) {
      _logger.warning('Uyava file logging failed to start', e, st);
    }
  }

  static String? _extractArgValue(List<String> args, String key) {
    for (int i = 0; i < args.length; i++) {
      final String arg = args[i];
      if (arg == key && i + 1 < args.length) {
        return args[i + 1];
      }
      if (arg.startsWith('$key=')) {
        return arg.substring(key.length + 1);
      }
    }
    return null;
  }

  static Future<String> _resolveLogDirectory() async {
    final Directory baseDir = await getApplicationSupportDirectory();
    return p.join(baseDir.path, 'uyava');
  }
}

class _NodeSpec {
  const _NodeSpec({
    required this.id,
    required this.label,
    required this.tags,
    required this.sourceRef,
    this.parentId,
    this.description,
    this.standardType = UyavaStandardType.group,
  });

  final String id;
  final String label;
  final String? description;
  final String? parentId;
  final List<String> tags;
  final String sourceRef;
  final UyavaStandardType standardType;
}
