import 'dart:io';
import 'dart:ui' as ui;

import 'package:common/model/device.dart';
import 'package:common/model/dto/file_dto.dart';
import 'package:flutter/foundation.dart';
import 'package:localsend_app/uyava/localsend_uyava_graph.dart';
import 'package:localsend_app/uyava/localsend_uyava_graph.dart' as graph;
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
  static String get uiHomeNodeId => graph.uiHomeNodeId;
  static String get uiSendNodeId => graph.uiSendNodeId;
  static String get uiReceiveNodeId => graph.uiReceiveNodeId;
  static String get uiSettingsNodeId => graph.uiSettingsNodeId;
  static String get uiProgressNodeId => graph.uiProgressNodeId;
  static String get uiSendPageNodeId => graph.uiSendPageNodeId;
  static String get uiReceivePageNodeId => graph.uiReceivePageNodeId;
  static String get uiReceiveOptionsNodeId => graph.uiReceiveOptionsNodeId;
  static String get uiSelectedFilesNodeId => graph.uiSelectedFilesNodeId;
  static String get uiReceiveHistoryPageNodeId => graph.uiReceiveHistoryPageNodeId;
  static String get uiWebSendNodeId => graph.uiWebSendNodeId;
  static String get uiApkPickerNodeId => graph.uiApkPickerNodeId;
  static String get uiTroubleshootNodeId => graph.uiTroubleshootNodeId;
  static String get uiAboutNodeId => graph.uiAboutNodeId;
  static String get uiDonationNodeId => graph.uiDonationNodeId;
  static String get uiChangelogNodeId => graph.uiChangelogNodeId;
  static String get uiLanguageNodeId => graph.uiLanguageNodeId;
  static String get uiNetworkInterfacesNodeId => graph.uiNetworkInterfacesNodeId;
  static String get uiDebugNodeId => graph.uiDebugNodeId;
  static String get uiDiscoveryDebugNodeId => graph.uiDiscoveryDebugNodeId;
  static String get uiSecurityDebugNodeId => graph.uiSecurityDebugNodeId;
  static String get uiHttpLogsDebugNodeId => graph.uiHttpLogsDebugNodeId;

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

    for (final MapEntry<UyavaLifecycleState, List<String>> entry in localSendUyavaGraph.startupLifecycleGroups.entries) {
      if (entry.value.isEmpty) {
        continue;
      }
      Uyava.updateNodesListLifecycle(
        nodeIds: entry.value,
        state: entry.key,
      );
    }

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

  static void onServerStarted({
    required String alias,
    required int port,
    required bool https,
    String? sourceRef,
  }) {
    Uyava.updateNodeLifecycle(
      nodeId: httpServerNodeId,
      state: UyavaLifecycleState.initialized,
    );
    Uyava.emitNodeEvent(
      nodeId: serverServiceNodeId,
      message: 'HTTP server started',
      tags: const <String>[tagNetwork, tagReceive],
      payload: <String, dynamic>{
        'alias': alias,
        'port': port,
        'https': https,
      },
      sourceRef: sourceRef,
    );
    Uyava.emitEdgeEvent(
      edge: edgeServerToHttpId,
      message: 'Bind HTTP server',
      severity: UyavaSeverity.info,
      sourceRef: sourceRef,
    );
  }

  static void onServerStopped({String? sourceRef}) {
    Uyava.emitNodeEvent(
      nodeId: serverServiceNodeId,
      message: 'HTTP server stopped',
      tags: const <String>[tagNetwork, tagReceive],
      sourceRef: sourceRef,
    );
    Uyava.updateNodeLifecycle(
      nodeId: httpServerNodeId,
      state: UyavaLifecycleState.disposed,
    );
    Uyava.updateNodeLifecycle(
      nodeId: webSendControllerNodeId,
      state: UyavaLifecycleState.disposed,
    );
  }

  static void onWebSendReady({
    required int fileCount,
    required bool https,
    String? sourceRef,
  }) {
    Uyava.updateNodeLifecycle(
      nodeId: webSendControllerNodeId,
      state: UyavaLifecycleState.initialized,
    );
    Uyava.emitNodeEvent(
      nodeId: webSendControllerNodeId,
      message: 'Web send initialized',
      tags: const <String>[tagSend, tagWebSend, tagTransfer],
      payload: <String, dynamic>{
        'fileCount': fileCount,
        'https': https,
        'metric': _metric(metricFilesCount, fileCount),
      },
      sourceRef: sourceRef,
    );
    Uyava.emitEdgeEvent(
      edge: edgeServerToWebSendControllerId,
      message: 'Prepare web send routes',
      severity: UyavaSeverity.info,
      sourceRef: sourceRef,
    );
  }

  static void onDiscoveryDevice({
    required Device device,
    required String transport,
    String? sourceRef,
  }) {
    final String alias = device.alias;
    Uyava.emitNodeEvent(
      nodeId: nearbyDevicesNodeId,
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
        'metric': _metric(metricSelectedFilesCount, acceptedCount),
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
        if (durationMs != null) 'metric': _metric(metricFileDurationMs, durationMs),
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
      nodeId: sendProviderNodeId,
      chainId: sendFileChainId,
      stepId: 'file_upload_complete',
      attempt: file.id,
      edgeId: edgeSendToProviderId,
      message: success ? 'Marked ${file.fileName} complete' : 'Upload failed for ${file.fileName}',
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
      nodeId: sendProviderNodeId,
      chainId: sendChainId,
      stepId: 'transfer_complete',
      attempt: sessionId,
      edgeId: edgeSendToProviderId,
      message: success ? 'Send session finished' : 'Send session failed',
      severity: success ? UyavaSeverity.info : UyavaSeverity.error,
      status: success ? null : 'failed',
      tags: <String>[tagSend, tagSession],
      payload: <String, dynamic>{
        'sessionId': sessionId,
        if (durationMs != null) 'metric': _metric(metricSessionDurationMs, durationMs),
      },
      sourceRef: sourceRef,
    );
    if (!success) {
      _failPendingFiles(
        fileMap: _activeSendFiles,
        sessionId: sessionId,
        chainId: sendFileChainId,
        stepId: 'file_upload_complete',
        nodeId: sendProviderNodeId,
        edgeId: edgeSendToProviderId,
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
      nodeId: sendProviderNodeId,
      chainId: sendChainId,
      stepId: 'transfer_complete',
      attempt: sessionId,
      edgeId: edgeSendToProviderId,
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
      nodeId: sendProviderNodeId,
      edgeId: edgeSendToProviderId,
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
        nodeId: uiReceivePageNodeId,
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
          'metric': _metric(metricSelectedFilesCount, selectedCount),
        },
        sourceRef: sourceRef,
      );
    } else {
      Uyava.emitNodeEvent(
        nodeId: uiReceivePageNodeId,
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
    _emitChainStep(
      nodeId: fileSaverNodeId,
      chainId: receiveChainId,
      stepId: 'transfer_started',
      attempt: sessionId,
      edgeId: edgeReceiveToStorageId,
      message: 'Receiving files',
      tags: <String>[tagReceive, tagSession, tagStorage],
      payload: <String, dynamic>{
        'sessionId': sessionId,
        'selectedCount': selectedCount,
        'metric': _metric(metricSelectedFilesCount, selectedCount),
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
        if (durationMs != null) 'metric': _metric(metricFileDurationMs, durationMs),
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
    if (success) {
      Uyava.emitEdgeEvent(
        edge: edgeFileSaverToHistoryId,
        message: 'Record receive history',
        severity: UyavaSeverity.info,
        sourceRef: sourceRef,
      );
      _emitChainStep(
        nodeId: receiveHistoryNodeId,
        chainId: receiveFileChainId,
        stepId: 'history_recorded',
        attempt: file.id,
        edgeId: edgeFileSaverToHistoryId,
        message: 'Receive history recorded',
        tags: <String>[tagReceive, tagFile, tagHistory],
        payload: <String, dynamic>{
          'sessionId': sessionId,
          'fileId': file.id,
          'fileName': file.fileName,
          if (filePath != null) 'path': filePath,
        },
        sourceRef: sourceRef,
      );
    }
    _untrackFile(_activeReceiveFiles, sessionId, file.id);
  }

  static void onReceiveSessionFinished({
    required String sessionId,
    required bool success,
    required int? durationMs,
    String? sourceRef,
  }) {
    _emitChainStep(
      nodeId: receiveControllerNodeId,
      chainId: receiveChainId,
      stepId: 'transfer_complete',
      attempt: sessionId,
      edgeId: edgeReceiveToControllerId,
      message: success ? 'Receive session finished' : 'Receive session failed',
      severity: success ? UyavaSeverity.info : UyavaSeverity.error,
      status: success ? null : 'failed',
      tags: <String>[tagReceive, tagSession],
      payload: <String, dynamic>{
        'sessionId': sessionId,
        if (durationMs != null) 'metric': _metric(metricSessionDurationMs, durationMs),
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
      nodeId: receiveControllerNodeId,
      chainId: receiveChainId,
      stepId: 'transfer_complete',
      attempt: sessionId,
      edgeId: edgeReceiveToControllerId,
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
    for (final LocalSendUyavaNodeSpec spec in localSendUyavaGraph.nodeSpecs) {
      Uyava.addNode(spec.node, sourceRef: spec.sourceRef);
    }
    for (final UyavaEdge edge in localSendUyavaGraph.edges) {
      Uyava.addEdge(edge);
    }
  }

  static void _defineMetrics() {
    for (final LocalSendUyavaMetricSpec spec in localSendUyavaGraph.metricSpecs) {
      spec.apply();
    }
  }

  static void _defineEventChains() {
    for (final LocalSendUyavaEventChainSpec spec in localSendUyavaGraph.eventChainSpecs) {
      spec.apply();
    }
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

  static List<String> _tagsForNode(String nodeId, {List<String>? fallback}) {
    final LocalSendUyavaNodeSpec? spec = localSendUyavaGraph.nodeSpecsById[nodeId];
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
        nodeId: uyavaLogsNodeId,
        message: 'Uyava file logging enabled',
        tags: const <String>[tagStorage, 'uyava'],
        payload: <String, dynamic>{
          'directory': logDir,
        },
      );
      Uyava.updateNodeLifecycle(
        nodeId: uyavaLogsNodeId,
        state: UyavaLifecycleState.initialized,
      );
      Uyava.emitEdgeEvent(
        edge: edgeStorageToLogsId,
        message: 'Enable Uyava file logging',
        severity: UyavaSeverity.info,
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
