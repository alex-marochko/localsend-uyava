import 'package:uyava/uyava.dart';

const String diagnosticsGroupNodeId = 'localsend.diagnostics';
const String errorsNodeId = 'localsend.diagnostics.errors';
const String discoveryLogsNodeId = 'localsend.diagnostics.discovery_logs';
const String httpLogsNodeId = 'localsend.diagnostics.http_logs';

const String nativeGroupNodeId = 'localsend.native';
const String rustBridgeNodeId = 'localsend.native.rust_bridge';
const String rustWebrtcNodeId = 'localsend.native.rust_webrtc';
const String rustCryptoNodeId = 'localsend.native.rust_crypto';
const String rustLoggingNodeId = 'localsend.native.rust_logging';

const String uiGroupNodeId = 'localsend.ui';
const String uiTabsGroupNodeId = 'localsend.ui.tabs';
const String uiTransferPagesGroupNodeId = 'localsend.ui.transfer_pages';
const String uiSettingsPagesGroupNodeId = 'localsend.ui.settings_pages';
const String uiDebugPagesGroupNodeId = 'localsend.ui.debug_pages';

const String uiHomeNodeId = 'localsend.ui.home_shell';
const String uiSendNodeId = 'localsend.ui.tabs.send';
const String uiReceiveNodeId = 'localsend.ui.tabs.receive';
const String uiSettingsNodeId = 'localsend.ui.tabs.settings';
const String uiProgressNodeId = 'localsend.ui.transfer_pages.progress';
const String uiSendPageNodeId = 'localsend.ui.transfer_pages.send_session';
const String uiReceivePageNodeId = 'localsend.ui.transfer_pages.receive_session';
const String uiReceiveOptionsNodeId = 'localsend.ui.transfer_pages.receive_options';
const String uiSelectedFilesNodeId = 'localsend.ui.transfer_pages.selected_files';
const String uiReceiveHistoryPageNodeId = 'localsend.ui.transfer_pages.receive_history';
const String uiWebSendNodeId = 'localsend.ui.transfer_pages.web_send';
const String uiApkPickerNodeId = 'localsend.ui.transfer_pages.apk_picker';
const String uiTroubleshootNodeId = 'localsend.ui.transfer_pages.troubleshoot';
const String uiAboutNodeId = 'localsend.ui.settings_pages.about';
const String uiDonationNodeId = 'localsend.ui.settings_pages.donation';
const String uiChangelogNodeId = 'localsend.ui.settings_pages.changelog';
const String uiLanguageNodeId = 'localsend.ui.settings_pages.language';
const String uiNetworkInterfacesNodeId = 'localsend.ui.settings_pages.network_interfaces';
const String uiDebugNodeId = 'localsend.ui.debug_pages.debug';
const String uiDiscoveryDebugNodeId = 'localsend.ui.debug_pages.discovery';
const String uiSecurityDebugNodeId = 'localsend.ui.debug_pages.security';
const String uiHttpLogsDebugNodeId = 'localsend.ui.debug_pages.http_logs';

const String presentationGroupNodeId = 'localsend.presentation';
const String homeControllerNodeId = 'localsend.presentation.home_controller';
const String sendTabVmNodeId = 'localsend.presentation.send_tab_vm';
const String receiveTabVmNodeId = 'localsend.presentation.receive_tab_vm';
const String settingsTabControllerNodeId = 'localsend.presentation.settings_tab_controller';
const String progressStateNodeId = 'localsend.presentation.progress_state';

const String networkGroupNodeId = 'localsend.network';
const String nearbyDevicesNodeId = 'localsend.network.discovery';
const String localIpNodeId = 'localsend.network.local_ips';
const String serverServiceNodeId = 'localsend.network.server_service';
const String httpClientNodeId = 'localsend.network.http_client';
const String httpServerNodeId = 'localsend.network.http_server';
const String signalingNodeId = 'localsend.network.signaling';

const String transferGroupNodeId = 'localsend.transfer';
const String sendProviderNodeId = 'localsend.transfer.send_provider';
const String uploadIsolatesNodeId = 'localsend.transfer.upload_isolates';
const String receiveControllerNodeId = 'localsend.transfer.receive_controller';
const String webSendControllerNodeId = 'localsend.transfer.web_send_controller';
const String sendSessionNodeId = 'localsend.transfer.send_session';
const String receiveSessionNodeId = 'localsend.transfer.receive_session';

const String stateGroupNodeId = 'localsend.state';
const String settingsNodeId = 'localsend.state.settings';
const String selectedSendingFilesNodeId = 'localsend.state.selected_sending_files';
const String selectedReceivingFilesNodeId = 'localsend.state.selected_receiving_files';
const String favoritesNodeId = 'localsend.state.favorites';
const String securityNodeId = 'localsend.state.security';
const String persistenceNodeId = 'localsend.state.persistence';
const String receiveHistoryNodeId = 'localsend.state.receive_history';

const String storageGroupNodeId = 'localsend.storage';
const String fileSaverNodeId = 'localsend.storage.file_saver';
const String uyavaLogsNodeId = 'localsend.storage.uyava_logs';

const String edgeHomeToControllerId = 'edge.ui.home.controller';
const String edgeControllerToReceiveTabId = 'edge.ui.controller.receive_tab';
const String edgeControllerToSendTabId = 'edge.ui.controller.send_tab';
const String edgeControllerToSettingsTabId = 'edge.ui.controller.settings_tab';
const String edgeSendTabToVmId = 'edge.ui.send.vm';
const String edgeReceiveTabToVmId = 'edge.ui.receive.vm';
const String edgeSettingsTabToControllerId = 'edge.ui.settings.controller';
const String edgeProgressToStateId = 'edge.ui.progress.state';
const String edgeReceivePageToSelectedFilesId = 'edge.ui.receive_page.selection';
const String edgeReceiveHistoryPageToHistoryId = 'edge.ui.receive_history_page.history';
const String edgeDebugPageToDiscoveryLogsId = 'edge.ui.debug.discovery_logs';
const String edgeSecurityDebugToSecurityId = 'edge.ui.security_debug.security';
const String edgeDebugPageToHttpLogsId = 'edge.ui.debug.http_logs';

const String edgeSendTabToSelectedFilesId = 'edge.ui.send.selected_files';
const String edgeSendTabToTroubleshootId = 'edge.ui.send.troubleshoot';
const String edgeSendTabToWebSendId = 'edge.ui.send.web_send';
const String edgeSendTabToApkPickerId = 'edge.ui.send.apk_picker';
const String edgeReceiveTabToHistoryPageId = 'edge.ui.receive.history_page';
const String edgeReceivePageToOptionsId = 'edge.ui.receive.options';
const String edgeSettingsTabToAboutId = 'edge.ui.settings.about';
const String edgeSettingsTabToDonationId = 'edge.ui.settings.donation';
const String edgeSettingsTabToChangelogId = 'edge.ui.settings.changelog';
const String edgeSettingsTabToLanguageId = 'edge.ui.settings.language';
const String edgeSettingsTabToNetworkInterfacesId = 'edge.ui.settings.network_interfaces';
const String edgeAboutToDebugId = 'edge.ui.about.debug';
const String edgeDebugToDiscoveryDebugId = 'edge.ui.debug.discovery';
const String edgeDebugToSecurityDebugId = 'edge.ui.debug.security';
const String edgeDebugToHttpLogsDebugId = 'edge.ui.debug.http';

const String edgeUiToSendId = 'edge.ui.send_session';
const String edgeUiToReceiveId = 'edge.ui.receive_session';
const String edgeReceiveControllerAutoAcceptId = 'edge.transfer.receive.auto_accept';
const String edgeSendPageToProgressId = 'edge.ui.send_page.progress';
const String edgeReceivePageToProgressId = 'edge.ui.receive_page.progress';

const String edgeSendTabVmToSelectionId = 'edge.presentation.send.selection';
const String edgeSendTabVmToDiscoveryId = 'edge.presentation.send.discovery';
const String edgeSendTabVmToFavoritesId = 'edge.presentation.send.favorites';
const String edgeSendTabVmToLocalIpId = 'edge.presentation.send.local_ips';
const String edgeSendTabVmToSettingsId = 'edge.presentation.send.settings';
const String edgeSendTabVmToSendProviderId = 'edge.presentation.send.provider';
const String edgeReceiveTabVmToSettingsId = 'edge.presentation.receive.settings';
const String edgeReceiveTabVmToServerId = 'edge.presentation.receive.server';
const String edgeReceiveTabVmToLocalIpId = 'edge.presentation.receive.local_ips';
const String edgeSettingsControllerToSettingsId = 'edge.presentation.settings.settings';
const String edgeSettingsControllerToServerId = 'edge.presentation.settings.server';
const String edgeSettingsControllerToLocalIpId = 'edge.presentation.settings.local_ips';

const String edgeServerToHttpId = 'edge.network.server.http';
const String edgeServerToReceiveControllerId = 'edge.network.server.receive_controller';
const String edgeServerToWebSendControllerId = 'edge.network.server.web_send_controller';
const String edgeSecurityToRustCryptoId = 'edge.network.security.rust_crypto';
const String edgeSignalingToRustWebrtcId = 'edge.network.signaling.rust_webrtc';
const String edgeRustBridgeToWebrtcId = 'edge.native.rust_bridge.webrtc';
const String edgeRustBridgeToCryptoId = 'edge.native.rust_bridge.crypto';
const String edgeRustBridgeToLoggingId = 'edge.native.rust_bridge.logging';

const String edgeSendProviderToSessionId = 'edge.transfer.send_provider.session';
const String edgeReceiveControllerToSessionId = 'edge.transfer.receive_controller.session';
const String edgeSendPrepareToHttpId = 'edge.transfer.send.prepare_http';
const String edgeSendProviderToUploadIsolatesId = 'edge.transfer.send.upload_isolates';
const String edgeReceiveToHttpId = 'edge.transfer.receive.http';
const String edgeReceiveToStorageId = 'edge.transfer.receive.storage';
const String edgeSendToProviderId = 'edge.transfer.send.completion';
const String edgeReceiveToControllerId = 'edge.transfer.receive.completion';
const String edgeFileSaverToHistoryId = 'edge.storage.file_saver.history';
const String edgeStorageToLogsId = 'edge.storage.uyava_logs';

const String tagUi = 'ui';
const String tagPage = 'page';
const String tagDebug = 'debug';
const String tagPresentation = 'presentation';
const String tagNetwork = 'network';
const String tagDiscovery = 'discovery';
const String tagNative = 'native';
const String tagRust = 'rust';
const String tagSecurity = 'security';
const String tagWebrtc = 'webrtc';
const String tagTransfer = 'transfer';
const String tagSend = 'send';
const String tagReceive = 'receive';
const String tagSession = 'session';
const String tagFile = 'file';
const String tagStorage = 'storage';
const String tagMetrics = 'metrics';
const String tagDiagnostics = 'diagnostics';
const String tagError = 'error';
const String tagState = 'state';
const String tagController = 'controller';
const String tagHistory = 'history';
const String tagSelection = 'selection';
const String tagSettings = 'settings';
const String tagWebSend = 'web_send';

const String sendChainId = 'localsend.send_flow';
const String receiveChainId = 'localsend.receive_flow';
const String sendFileChainId = 'localsend.send_file_flow';
const String receiveFileChainId = 'localsend.receive_file_flow';

const String metricFileSizeMb = 'localsend.transfer.file_size_mb';
const String metricFileDurationMs = 'localsend.transfer.file_duration_ms';
const String metricSessionDurationMs = 'localsend.transfer.session_duration_ms';
const String metricThroughputMbPerSec = 'localsend.transfer.throughput_mb_s';
const String metricFilesCount = 'localsend.transfer.files_count';
const String metricSelectedFilesCount = 'localsend.transfer.selected_files_count';

final LocalSendUyavaGraph localSendUyavaGraph = LocalSendUyavaGraph(
  nodeSpecs: <LocalSendUyavaNodeSpec>[
    LocalSendUyavaNodeSpec.standard(
      id: diagnosticsGroupNodeId,
      label: 'Diagnostics',
      tags: const <String>[tagDiagnostics],
      sourceRef: 'package:localsend_app/config/init.dart:1:1',
      standardType: UyavaStandardType.group,
    ),
    LocalSendUyavaNodeSpec.standard(
      id: errorsNodeId,
      label: 'Unhandled Errors',
      description: 'Flutter and platform errors bridged into Uyava.',
      parentId: diagnosticsGroupNodeId,
      tags: const <String>[tagDiagnostics, tagError],
      sourceRef: 'package:localsend_app/config/init.dart:1:1',
      standardType: UyavaStandardType.event,
    ),
    LocalSendUyavaNodeSpec.standard(
      id: discoveryLogsNodeId,
      label: 'Discovery Logs',
      description: 'In-memory discovery log stream used by debug tooling.',
      parentId: diagnosticsGroupNodeId,
      tags: const <String>[tagDiagnostics, tagDiscovery],
      sourceRef: 'package:localsend_app/provider/logging/discovery_logs_provider.dart:1:1',
      standardType: UyavaStandardType.stream,
    ),
    LocalSendUyavaNodeSpec.standard(
      id: httpLogsNodeId,
      label: 'HTTP Logs',
      description: 'HTTP log stream surfaced in debug pages.',
      parentId: diagnosticsGroupNodeId,
      tags: const <String>[tagDiagnostics, tagNetwork],
      sourceRef: 'package:localsend_app/provider/logging/http_logs_provider.dart:1:1',
      standardType: UyavaStandardType.stream,
    ),
    LocalSendUyavaNodeSpec.standard(
      id: nativeGroupNodeId,
      label: 'Native Core',
      tags: const <String>[tagNative],
      sourceRef: 'package:localsend_app/rust/frb_generated.dart:1:1',
      standardType: UyavaStandardType.group,
    ),
    LocalSendUyavaNodeSpec.standard(
      id: rustBridgeNodeId,
      label: 'Rust Bridge',
      description: 'Flutter Rust Bridge bindings used by crypto, logging, and WebRTC.',
      parentId: nativeGroupNodeId,
      tags: const <String>[tagNative, tagRust],
      sourceRef: 'package:localsend_app/rust/frb_generated.dart:1:1',
      standardType: UyavaStandardType.api,
    ),
    LocalSendUyavaNodeSpec.standard(
      id: rustWebrtcNodeId,
      label: 'Rust WebRTC',
      description: 'Native WebRTC engine and signaling core.',
      parentId: nativeGroupNodeId,
      tags: const <String>[tagNative, tagRust, tagWebrtc],
      sourceRef: 'package:localsend_app/rust/api/webrtc.dart:1:1',
      standardType: UyavaStandardType.service,
    ),
    LocalSendUyavaNodeSpec.standard(
      id: rustCryptoNodeId,
      label: 'Rust Crypto',
      description: 'Native certificate verification and key operations.',
      parentId: nativeGroupNodeId,
      tags: const <String>[tagNative, tagRust, tagSecurity],
      sourceRef: 'package:localsend_app/rust/api/crypto.dart:1:1',
      standardType: UyavaStandardType.service,
    ),
    LocalSendUyavaNodeSpec.standard(
      id: rustLoggingNodeId,
      label: 'Rust Logging',
      description: 'Native logging bridge enabled in debug flows.',
      parentId: nativeGroupNodeId,
      tags: const <String>[tagNative, tagRust],
      sourceRef: 'package:localsend_app/rust/api/logging.dart:1:1',
      standardType: UyavaStandardType.service,
    ),
    LocalSendUyavaNodeSpec.standard(
      id: uiGroupNodeId,
      label: 'UI',
      tags: const <String>[tagUi],
      sourceRef: 'package:localsend_app/pages/home_page.dart:1:1',
      standardType: UyavaStandardType.group,
    ),
    LocalSendUyavaNodeSpec.standard(
      id: uiTabsGroupNodeId,
      label: 'Tabs',
      parentId: uiGroupNodeId,
      tags: const <String>[tagUi],
      sourceRef: 'package:localsend_app/pages/home_page.dart:1:1',
      standardType: UyavaStandardType.group,
    ),
    LocalSendUyavaNodeSpec.standard(
      id: uiTransferPagesGroupNodeId,
      label: 'Transfer Pages',
      parentId: uiGroupNodeId,
      tags: const <String>[tagUi, tagTransfer],
      sourceRef: 'package:localsend_app/pages/send_page.dart:1:1',
      standardType: UyavaStandardType.group,
    ),
    LocalSendUyavaNodeSpec.standard(
      id: uiSettingsPagesGroupNodeId,
      label: 'Settings Pages',
      parentId: uiGroupNodeId,
      tags: const <String>[tagUi, tagSettings],
      sourceRef: 'package:localsend_app/pages/about/about_page.dart:1:1',
      standardType: UyavaStandardType.group,
    ),
    LocalSendUyavaNodeSpec.standard(
      id: uiDebugPagesGroupNodeId,
      label: 'Debug Pages',
      parentId: uiGroupNodeId,
      tags: const <String>[tagUi, tagDebug],
      sourceRef: 'package:localsend_app/pages/debug/debug_page.dart:1:1',
      standardType: UyavaStandardType.group,
    ),
    LocalSendUyavaNodeSpec.standard(
      id: uiHomeNodeId,
      label: 'Home Shell',
      description: 'Root shell with navigation rail / bottom navigation and page view.',
      parentId: uiGroupNodeId,
      tags: const <String>[tagUi],
      sourceRef: 'package:localsend_app/pages/home_page.dart:1:1',
      standardType: UyavaStandardType.screen,
      startupLifecycle: UyavaLifecycleState.disposed,
    ),
    LocalSendUyavaNodeSpec.standard(
      id: uiReceiveNodeId,
      label: 'Receive Tab',
      description: 'Primary inbound-transfer tab and quick-save toggles.',
      parentId: uiTabsGroupNodeId,
      tags: const <String>[tagUi, tagReceive],
      sourceRef: 'package:localsend_app/pages/tabs/receive_tab.dart:1:1',
      standardType: UyavaStandardType.screen,
      startupLifecycle: UyavaLifecycleState.disposed,
    ),
    LocalSendUyavaNodeSpec.standard(
      id: uiSendNodeId,
      label: 'Send Tab',
      description: 'Primary outbound-transfer tab with device discovery and send actions.',
      parentId: uiTabsGroupNodeId,
      tags: const <String>[tagUi, tagSend],
      sourceRef: 'package:localsend_app/pages/tabs/send_tab.dart:1:1',
      standardType: UyavaStandardType.screen,
      startupLifecycle: UyavaLifecycleState.disposed,
    ),
    LocalSendUyavaNodeSpec.standard(
      id: uiSettingsNodeId,
      label: 'Settings Tab',
      description: 'Configuration entry point for networking, UI, and support pages.',
      parentId: uiTabsGroupNodeId,
      tags: const <String>[tagUi, tagSettings],
      sourceRef: 'package:localsend_app/pages/tabs/settings_tab.dart:1:1',
      standardType: UyavaStandardType.screen,
      startupLifecycle: UyavaLifecycleState.disposed,
    ),
    LocalSendUyavaNodeSpec.standard(
      id: uiProgressNodeId,
      label: 'Progress Page',
      description: 'Shared send/receive progress page with taskbar and file-level feedback.',
      parentId: uiTransferPagesGroupNodeId,
      tags: const <String>[tagUi, tagPage, tagTransfer],
      sourceRef: 'package:localsend_app/pages/progress_page.dart:1:1',
      standardType: UyavaStandardType.screen,
      startupLifecycle: UyavaLifecycleState.disposed,
    ),
    LocalSendUyavaNodeSpec.standard(
      id: uiSendPageNodeId,
      label: 'Send Page',
      description: 'Foreground session page shown while waiting for receiver acceptance.',
      parentId: uiTransferPagesGroupNodeId,
      tags: const <String>[tagUi, tagPage, tagSend],
      sourceRef: 'package:localsend_app/pages/send_page.dart:1:1',
      standardType: UyavaStandardType.screen,
      startupLifecycle: UyavaLifecycleState.disposed,
    ),
    LocalSendUyavaNodeSpec.standard(
      id: uiReceivePageNodeId,
      label: 'Receive Page',
      description: 'Incoming-transfer approval page with file selection and quick actions.',
      parentId: uiTransferPagesGroupNodeId,
      tags: const <String>[tagUi, tagPage, tagReceive],
      sourceRef: 'package:localsend_app/pages/receive_page.dart:1:1',
      standardType: UyavaStandardType.screen,
      startupLifecycle: UyavaLifecycleState.disposed,
    ),
    LocalSendUyavaNodeSpec.standard(
      id: uiReceiveOptionsNodeId,
      label: 'Receive Options Page',
      description: 'Receive-side rename and destination adjustment page.',
      parentId: uiTransferPagesGroupNodeId,
      tags: const <String>[tagUi, tagPage, tagReceive],
      sourceRef: 'package:localsend_app/pages/receive_options_page.dart:1:1',
      standardType: UyavaStandardType.screen,
      startupLifecycle: UyavaLifecycleState.disposed,
    ),
    LocalSendUyavaNodeSpec.standard(
      id: uiSelectedFilesNodeId,
      label: 'Selected Files Page',
      description: 'Current outbound selection preview and edit page.',
      parentId: uiTransferPagesGroupNodeId,
      tags: const <String>[tagUi, tagPage, tagSend, tagSelection],
      sourceRef: 'package:localsend_app/pages/selected_files_page.dart:1:1',
      standardType: UyavaStandardType.screen,
      startupLifecycle: UyavaLifecycleState.disposed,
    ),
    LocalSendUyavaNodeSpec.standard(
      id: uiReceiveHistoryPageNodeId,
      label: 'Receive History Page',
      description: 'History browser for previously received files and messages.',
      parentId: uiTransferPagesGroupNodeId,
      tags: const <String>[tagUi, tagPage, tagHistory],
      sourceRef: 'package:localsend_app/pages/receive_history_page.dart:1:1',
      standardType: UyavaStandardType.screen,
      startupLifecycle: UyavaLifecycleState.disposed,
    ),
    LocalSendUyavaNodeSpec.standard(
      id: uiWebSendNodeId,
      label: 'Web Send Page',
      description: 'Share-via-link UI that exposes the built-in HTTP server.',
      parentId: uiTransferPagesGroupNodeId,
      tags: const <String>[tagUi, tagPage, tagSend, tagWebSend],
      sourceRef: 'package:localsend_app/pages/web_send_page.dart:1:1',
      standardType: UyavaStandardType.screen,
      startupLifecycle: UyavaLifecycleState.disposed,
    ),
    LocalSendUyavaNodeSpec.standard(
      id: uiApkPickerNodeId,
      label: 'APK Picker Page',
      description: 'Android app picker used when sharing installed APKs.',
      parentId: uiTransferPagesGroupNodeId,
      tags: const <String>[tagUi, tagPage, tagSend],
      sourceRef: 'package:localsend_app/pages/apk_picker_page.dart:1:1',
      standardType: UyavaStandardType.screen,
      startupLifecycle: UyavaLifecycleState.disposed,
    ),
    LocalSendUyavaNodeSpec.standard(
      id: uiTroubleshootNodeId,
      label: 'Troubleshoot Page',
      description: 'Manual help and diagnostics for send issues.',
      parentId: uiTransferPagesGroupNodeId,
      tags: const <String>[tagUi, tagPage, tagDiagnostics],
      sourceRef: 'package:localsend_app/pages/troubleshoot_page.dart:1:1',
      standardType: UyavaStandardType.screen,
      startupLifecycle: UyavaLifecycleState.disposed,
    ),
    LocalSendUyavaNodeSpec.standard(
      id: uiAboutNodeId,
      label: 'About Page',
      description: 'Credits, licenses, and debug entry point.',
      parentId: uiSettingsPagesGroupNodeId,
      tags: const <String>[tagUi, tagPage, tagSettings],
      sourceRef: 'package:localsend_app/pages/about/about_page.dart:1:1',
      standardType: UyavaStandardType.screen,
      startupLifecycle: UyavaLifecycleState.disposed,
    ),
    LocalSendUyavaNodeSpec.standard(
      id: uiDonationNodeId,
      label: 'Donation Page',
      description: 'Support / donation flow.',
      parentId: uiSettingsPagesGroupNodeId,
      tags: const <String>[tagUi, tagPage, tagSettings],
      sourceRef: 'package:localsend_app/pages/donation/donation_page.dart:1:1',
      standardType: UyavaStandardType.screen,
      startupLifecycle: UyavaLifecycleState.disposed,
    ),
    LocalSendUyavaNodeSpec.standard(
      id: uiChangelogNodeId,
      label: 'Changelog Page',
      description: 'Release notes browser.',
      parentId: uiSettingsPagesGroupNodeId,
      tags: const <String>[tagUi, tagPage, tagSettings],
      sourceRef: 'package:localsend_app/pages/changelog_page.dart:1:1',
      standardType: UyavaStandardType.screen,
      startupLifecycle: UyavaLifecycleState.disposed,
    ),
    LocalSendUyavaNodeSpec.standard(
      id: uiLanguageNodeId,
      label: 'Language Page',
      description: 'Language picker reachable from settings.',
      parentId: uiSettingsPagesGroupNodeId,
      tags: const <String>[tagUi, tagPage, tagSettings],
      sourceRef: 'package:localsend_app/pages/language_page.dart:1:1',
      standardType: UyavaStandardType.screen,
      startupLifecycle: UyavaLifecycleState.disposed,
    ),
    LocalSendUyavaNodeSpec.standard(
      id: uiNetworkInterfacesNodeId,
      label: 'Network Interfaces Page',
      description: 'Network whitelist / blacklist configuration page.',
      parentId: uiSettingsPagesGroupNodeId,
      tags: const <String>[tagUi, tagPage, tagSettings, tagNetwork],
      sourceRef: 'package:localsend_app/pages/settings/network_interfaces_page.dart:1:1',
      standardType: UyavaStandardType.screen,
      startupLifecycle: UyavaLifecycleState.disposed,
    ),
    LocalSendUyavaNodeSpec.standard(
      id: uiDebugNodeId,
      label: 'Debug Page',
      description: 'Debug hub exposing security, discovery, and HTTP tools.',
      parentId: uiDebugPagesGroupNodeId,
      tags: const <String>[tagUi, tagPage, tagDebug],
      sourceRef: 'package:localsend_app/pages/debug/debug_page.dart:1:1',
      standardType: UyavaStandardType.screen,
      startupLifecycle: UyavaLifecycleState.disposed,
    ),
    LocalSendUyavaNodeSpec.standard(
      id: uiDiscoveryDebugNodeId,
      label: 'Discovery Debug Page',
      description: 'Discovery log viewer.',
      parentId: uiDebugPagesGroupNodeId,
      tags: const <String>[tagUi, tagPage, tagDebug, tagDiscovery],
      sourceRef: 'package:localsend_app/pages/debug/discovery_debug_page.dart:1:1',
      standardType: UyavaStandardType.screen,
      startupLifecycle: UyavaLifecycleState.disposed,
    ),
    LocalSendUyavaNodeSpec.standard(
      id: uiSecurityDebugNodeId,
      label: 'Security Debug Page',
      description: 'Security and certificate diagnostics page.',
      parentId: uiDebugPagesGroupNodeId,
      tags: const <String>[tagUi, tagPage, tagDebug, tagSecurity],
      sourceRef: 'package:localsend_app/pages/debug/security_debug_page.dart:1:1',
      standardType: UyavaStandardType.screen,
      startupLifecycle: UyavaLifecycleState.disposed,
    ),
    LocalSendUyavaNodeSpec.standard(
      id: uiHttpLogsDebugNodeId,
      label: 'HTTP Logs Page',
      description: 'HTTP logs viewer.',
      parentId: uiDebugPagesGroupNodeId,
      tags: const <String>[tagUi, tagPage, tagDebug, tagNetwork],
      sourceRef: 'package:localsend_app/pages/debug/http_logs_page.dart:1:1',
      standardType: UyavaStandardType.screen,
      startupLifecycle: UyavaLifecycleState.disposed,
    ),
    LocalSendUyavaNodeSpec.standard(
      id: presentationGroupNodeId,
      label: 'Presentation',
      tags: const <String>[tagPresentation],
      sourceRef: 'package:localsend_app/pages/home_page_controller.dart:1:1',
      standardType: UyavaStandardType.group,
    ),
    LocalSendUyavaNodeSpec.standard(
      id: homeControllerNodeId,
      label: 'Home Controller',
      description: 'Tab orchestration and page-view coordination.',
      parentId: presentationGroupNodeId,
      tags: const <String>[tagPresentation, tagController],
      sourceRef: 'package:localsend_app/pages/home_page_controller.dart:1:1',
      standardType: UyavaStandardType.provider,
    ),
    LocalSendUyavaNodeSpec.standard(
      id: sendTabVmNodeId,
      label: 'Send Tab VM',
      description: 'Composes discovery, selection, favorites, and send actions for the send tab.',
      parentId: presentationGroupNodeId,
      tags: const <String>[tagPresentation, tagController, tagSend],
      sourceRef: 'package:localsend_app/pages/tabs/send_tab_vm.dart:1:1',
      standardType: UyavaStandardType.provider,
    ),
    LocalSendUyavaNodeSpec.standard(
      id: receiveTabVmNodeId,
      label: 'Receive Tab VM',
      description: 'Composes receive-tab state, quick-save settings, and server visibility.',
      parentId: presentationGroupNodeId,
      tags: const <String>[tagPresentation, tagController, tagReceive],
      sourceRef: 'package:localsend_app/pages/tabs/receive_tab_vm.dart:1:1',
      standardType: UyavaStandardType.provider,
    ),
    LocalSendUyavaNodeSpec.standard(
      id: settingsTabControllerNodeId,
      label: 'Settings Controller',
      description: 'Coordinates settings mutations, server restart, and device/network fields.',
      parentId: presentationGroupNodeId,
      tags: const <String>[tagPresentation, tagController, tagSettings],
      sourceRef: 'package:localsend_app/pages/tabs/settings_tab_controller.dart:1:1',
      standardType: UyavaStandardType.provider,
    ),
    LocalSendUyavaNodeSpec.standard(
      id: progressStateNodeId,
      label: 'Progress Notifier',
      description: 'Aggregates per-file progress samples for active sessions.',
      parentId: presentationGroupNodeId,
      tags: const <String>[tagPresentation, tagTransfer],
      sourceRef: 'package:localsend_app/provider/progress_provider.dart:1:1',
      standardType: UyavaStandardType.state,
    ),
    LocalSendUyavaNodeSpec.standard(
      id: networkGroupNodeId,
      label: 'Network',
      tags: const <String>[tagNetwork],
      sourceRef: 'package:localsend_app/provider/network/server/server_provider.dart:1:1',
      standardType: UyavaStandardType.group,
    ),
    LocalSendUyavaNodeSpec.standard(
      id: nearbyDevicesNodeId,
      label: 'Nearby Devices',
      description: 'Discovery service for UDP/TCP/favorite scans and transient device registry.',
      parentId: networkGroupNodeId,
      tags: const <String>[tagNetwork, tagDiscovery],
      sourceRef: 'package:localsend_app/provider/network/nearby_devices_provider.dart:1:1',
      standardType: UyavaStandardType.service,
    ),
    LocalSendUyavaNodeSpec.standard(
      id: localIpNodeId,
      label: 'Local IP Service',
      description: 'Tracks current local interface IPs used by send/receive UIs.',
      parentId: networkGroupNodeId,
      tags: const <String>[tagNetwork, tagState],
      sourceRef: 'package:localsend_app/provider/local_ip_provider.dart:1:1',
      standardType: UyavaStandardType.state,
    ),
    LocalSendUyavaNodeSpec.standard(
      id: serverServiceNodeId,
      label: 'Server Service',
      description: 'Lifecycle owner of the embedded HTTP server and web-send state.',
      parentId: networkGroupNodeId,
      tags: const <String>[tagNetwork, tagReceive, tagWebSend],
      sourceRef: 'package:localsend_app/provider/network/server/server_provider.dart:1:1',
      standardType: UyavaStandardType.service,
    ),
    LocalSendUyavaNodeSpec.standard(
      id: httpClientNodeId,
      label: 'HTTP Client',
      description: 'Outbound HTTP API used by send sessions.',
      parentId: networkGroupNodeId,
      tags: const <String>[tagNetwork, tagSend],
      sourceRef: 'package:localsend_app/provider/http_provider.dart:1:1',
      standardType: UyavaStandardType.api,
    ),
    LocalSendUyavaNodeSpec.standard(
      id: httpServerNodeId,
      label: 'HTTP Server',
      description: 'Inbound HTTP server handling receive and web-send routes.',
      parentId: networkGroupNodeId,
      tags: const <String>[tagNetwork, tagReceive, tagWebSend],
      sourceRef: 'package:localsend_app/provider/network/server/server_provider.dart:1:1',
      standardType: UyavaStandardType.api,
      startupLifecycle: UyavaLifecycleState.disposed,
    ),
    LocalSendUyavaNodeSpec.standard(
      id: signalingNodeId,
      label: 'Signaling',
      description: 'WebRTC signaling bridge for native RTC transport.',
      parentId: networkGroupNodeId,
      tags: const <String>[tagNetwork, tagWebrtc],
      sourceRef: 'package:localsend_app/provider/network/webrtc/signaling_provider.dart:1:1',
      standardType: UyavaStandardType.service,
    ),
    LocalSendUyavaNodeSpec.standard(
      id: transferGroupNodeId,
      label: 'Transfer Core',
      tags: const <String>[tagTransfer],
      sourceRef: 'package:localsend_app/provider/network/send_provider.dart:1:1',
      standardType: UyavaStandardType.group,
    ),
    LocalSendUyavaNodeSpec.standard(
      id: sendProviderNodeId,
      label: 'Send Provider',
      description: 'Owns outbound session state, retries, and file uploads.',
      parentId: transferGroupNodeId,
      tags: const <String>[tagTransfer, tagSend],
      sourceRef: 'package:localsend_app/provider/network/send_provider.dart:1:1',
      standardType: UyavaStandardType.manager,
    ),
    LocalSendUyavaNodeSpec.standard(
      id: uploadIsolatesNodeId,
      label: 'HTTP Upload Isolates',
      description: 'Background upload workers that stream file bytes to the receiver over HTTP.',
      parentId: transferGroupNodeId,
      tags: const <String>[tagTransfer, tagSend, tagNetwork],
      sourceRef: 'package:common/src/isolate/child/upload_isolate.dart:1:1',
      standardType: UyavaStandardType.service,
    ),
    LocalSendUyavaNodeSpec.standard(
      id: receiveControllerNodeId,
      label: 'Receive Controller',
      description: 'Handles incoming prepare/upload/cancel/show routes and receive-session transitions.',
      parentId: transferGroupNodeId,
      tags: const <String>[tagTransfer, tagReceive],
      sourceRef: 'package:localsend_app/provider/network/server/controller/receive_controller.dart:1:1',
      standardType: UyavaStandardType.manager,
    ),
    LocalSendUyavaNodeSpec.standard(
      id: webSendControllerNodeId,
      label: 'Web Send Controller',
      description: 'Handles share-via-link routes and approval state for web clients.',
      parentId: transferGroupNodeId,
      tags: const <String>[tagTransfer, tagSend, tagWebSend],
      sourceRef: 'package:localsend_app/provider/network/server/controller/send_controller.dart:1:1',
      standardType: UyavaStandardType.manager,
      startupLifecycle: UyavaLifecycleState.disposed,
    ),
    LocalSendUyavaNodeSpec.standard(
      id: sendSessionNodeId,
      label: 'Send Session',
      description: 'Active outbound transfer session.',
      parentId: transferGroupNodeId,
      tags: const <String>[tagTransfer, tagSend, tagSession],
      sourceRef: 'package:localsend_app/provider/network/send_provider.dart:1:1',
      standardType: UyavaStandardType.state,
      startupLifecycle: UyavaLifecycleState.disposed,
    ),
    LocalSendUyavaNodeSpec.standard(
      id: receiveSessionNodeId,
      label: 'Receive Session',
      description: 'Active inbound transfer session.',
      parentId: transferGroupNodeId,
      tags: const <String>[tagTransfer, tagReceive, tagSession],
      sourceRef: 'package:localsend_app/provider/network/server/controller/receive_controller.dart:1:1',
      standardType: UyavaStandardType.state,
      startupLifecycle: UyavaLifecycleState.disposed,
    ),
    LocalSendUyavaNodeSpec.standard(
      id: stateGroupNodeId,
      label: 'App State',
      tags: const <String>[tagState],
      sourceRef: 'package:localsend_app/provider/settings_provider.dart:1:1',
      standardType: UyavaStandardType.group,
    ),
    LocalSendUyavaNodeSpec.standard(
      id: settingsNodeId,
      label: 'Settings Service',
      description: 'Persistent app settings and network preferences.',
      parentId: stateGroupNodeId,
      tags: const <String>[tagState, tagSettings],
      sourceRef: 'package:localsend_app/provider/settings_provider.dart:1:1',
      standardType: UyavaStandardType.state,
    ),
    LocalSendUyavaNodeSpec.standard(
      id: selectedSendingFilesNodeId,
      label: 'Selected Sending Files',
      description: 'Outbound selection state for files, directories, and clipboard content.',
      parentId: stateGroupNodeId,
      tags: const <String>[tagState, tagSelection, tagSend],
      sourceRef: 'package:localsend_app/provider/selection/selected_sending_files_provider.dart:1:1',
      standardType: UyavaStandardType.state,
    ),
    LocalSendUyavaNodeSpec.standard(
      id: selectedReceivingFilesNodeId,
      label: 'Selected Receiving Files',
      description: 'Inbound selection state used by the receive approval page.',
      parentId: stateGroupNodeId,
      tags: const <String>[tagState, tagSelection, tagReceive],
      sourceRef: 'package:localsend_app/provider/selection/selected_receiving_files_provider.dart:1:1',
      standardType: UyavaStandardType.state,
    ),
    LocalSendUyavaNodeSpec.standard(
      id: favoritesNodeId,
      label: 'Favorites',
      description: 'Persistent favorite device registry.',
      parentId: stateGroupNodeId,
      tags: const <String>[tagState, tagSend],
      sourceRef: 'package:localsend_app/provider/favorites_provider.dart:1:1',
      standardType: UyavaStandardType.repository,
    ),
    LocalSendUyavaNodeSpec.standard(
      id: securityNodeId,
      label: 'Security Context',
      description: 'Certificates and trust material used for HTTPS and device verification.',
      parentId: stateGroupNodeId,
      tags: const <String>[tagState, tagSecurity],
      sourceRef: 'package:localsend_app/provider/security_provider.dart:1:1',
      standardType: UyavaStandardType.state,
    ),
    LocalSendUyavaNodeSpec.standard(
      id: persistenceNodeId,
      label: 'Persistence',
      description: 'Application persistence service for user settings and local data.',
      parentId: stateGroupNodeId,
      tags: const <String>[tagState, tagStorage],
      sourceRef: 'package:localsend_app/provider/persistence_provider.dart:1:1',
      standardType: UyavaStandardType.repository,
    ),
    LocalSendUyavaNodeSpec.standard(
      id: receiveHistoryNodeId,
      label: 'Receive History',
      description: 'Persistent history for received files and incoming messages.',
      parentId: stateGroupNodeId,
      tags: const <String>[tagState, tagHistory, tagReceive],
      sourceRef: 'package:localsend_app/provider/receive_history_provider.dart:1:1',
      standardType: UyavaStandardType.repository,
    ),
    LocalSendUyavaNodeSpec.standard(
      id: storageGroupNodeId,
      label: 'Storage',
      tags: const <String>[tagStorage],
      sourceRef: 'package:localsend_app/util/native/file_saver.dart:1:1',
      standardType: UyavaStandardType.group,
    ),
    LocalSendUyavaNodeSpec.standard(
      id: fileSaverNodeId,
      label: 'File Saver',
      description: 'Writes incoming files to disk or gallery and reports saved paths.',
      parentId: storageGroupNodeId,
      tags: const <String>[tagStorage, tagReceive],
      sourceRef: 'package:localsend_app/util/native/file_saver.dart:1:1',
      standardType: UyavaStandardType.repository,
    ),
    LocalSendUyavaNodeSpec.standard(
      id: uyavaLogsNodeId,
      label: 'Uyava Logs',
      description: 'App-side Uyava file logging output directory and archives.',
      parentId: storageGroupNodeId,
      tags: const <String>[tagStorage, tagDiagnostics],
      sourceRef: 'package:localsend_app/uyava/localsend_uyava.dart:1:1',
      standardType: UyavaStandardType.repository,
      startupLifecycle: UyavaLifecycleState.disposed,
    ),
  ],
  edges: <UyavaEdge>[
    UyavaEdge(id: edgeHomeToControllerId, from: uiHomeNodeId, to: homeControllerNodeId, label: 'drive home shell'),
    UyavaEdge(id: edgeControllerToReceiveTabId, from: homeControllerNodeId, to: uiReceiveNodeId, label: 'switch tab'),
    UyavaEdge(id: edgeControllerToSendTabId, from: homeControllerNodeId, to: uiSendNodeId, label: 'switch tab'),
    UyavaEdge(id: edgeControllerToSettingsTabId, from: homeControllerNodeId, to: uiSettingsNodeId, label: 'switch tab'),
    UyavaEdge(id: edgeSendTabToVmId, from: uiSendNodeId, to: sendTabVmNodeId, label: 'compose send vm'),
    UyavaEdge(id: edgeReceiveTabToVmId, from: uiReceiveNodeId, to: receiveTabVmNodeId, label: 'compose receive vm'),
    UyavaEdge(id: edgeSettingsTabToControllerId, from: uiSettingsNodeId, to: settingsTabControllerNodeId, label: 'compose settings vm'),
    UyavaEdge(id: edgeProgressToStateId, from: uiProgressNodeId, to: progressStateNodeId, label: 'read progress'),
    UyavaEdge(id: edgeReceivePageToSelectedFilesId, from: uiReceivePageNodeId, to: selectedReceivingFilesNodeId, label: 'edit selected files'),
    UyavaEdge(id: edgeReceiveHistoryPageToHistoryId, from: uiReceiveHistoryPageNodeId, to: receiveHistoryNodeId, label: 'browse history'),
    UyavaEdge(id: edgeDebugPageToDiscoveryLogsId, from: uiDiscoveryDebugNodeId, to: discoveryLogsNodeId, label: 'inspect discovery logs'),
    UyavaEdge(id: edgeSecurityDebugToSecurityId, from: uiSecurityDebugNodeId, to: securityNodeId, label: 'inspect certificates'),
    UyavaEdge(id: edgeDebugPageToHttpLogsId, from: uiHttpLogsDebugNodeId, to: httpLogsNodeId, label: 'inspect http logs'),
    UyavaEdge(id: edgeSendTabToSelectedFilesId, from: uiSendNodeId, to: uiSelectedFilesNodeId, label: 'open selected files'),
    UyavaEdge(id: edgeSendTabToTroubleshootId, from: uiSendNodeId, to: uiTroubleshootNodeId, label: 'open troubleshooting'),
    UyavaEdge(id: edgeSendTabToWebSendId, from: uiSendNodeId, to: uiWebSendNodeId, label: 'open web send'),
    UyavaEdge(id: edgeSendTabToApkPickerId, from: uiSendNodeId, to: uiApkPickerNodeId, label: 'pick apk'),
    UyavaEdge(id: edgeReceiveTabToHistoryPageId, from: uiReceiveNodeId, to: uiReceiveHistoryPageNodeId, label: 'open history'),
    UyavaEdge(id: edgeReceivePageToOptionsId, from: uiReceivePageNodeId, to: uiReceiveOptionsNodeId, label: 'rename / destination'),
    UyavaEdge(id: edgeSettingsTabToAboutId, from: uiSettingsNodeId, to: uiAboutNodeId, label: 'open about'),
    UyavaEdge(id: edgeSettingsTabToDonationId, from: uiSettingsNodeId, to: uiDonationNodeId, label: 'open donation'),
    UyavaEdge(id: edgeSettingsTabToChangelogId, from: uiSettingsNodeId, to: uiChangelogNodeId, label: 'open changelog'),
    UyavaEdge(id: edgeSettingsTabToLanguageId, from: uiSettingsNodeId, to: uiLanguageNodeId, label: 'open language'),
    UyavaEdge(id: edgeSettingsTabToNetworkInterfacesId, from: uiSettingsNodeId, to: uiNetworkInterfacesNodeId, label: 'open interfaces'),
    UyavaEdge(id: edgeAboutToDebugId, from: uiAboutNodeId, to: uiDebugNodeId, label: 'open debug'),
    UyavaEdge(id: edgeDebugToDiscoveryDebugId, from: uiDebugNodeId, to: uiDiscoveryDebugNodeId, label: 'open discovery debug'),
    UyavaEdge(id: edgeDebugToSecurityDebugId, from: uiDebugNodeId, to: uiSecurityDebugNodeId, label: 'open security debug'),
    UyavaEdge(id: edgeDebugToHttpLogsDebugId, from: uiDebugNodeId, to: uiHttpLogsDebugNodeId, label: 'open http logs'),
    UyavaEdge(id: edgeUiToSendId, from: uiSendNodeId, to: sendSessionNodeId, label: 'start send session'),
    UyavaEdge(id: edgeUiToReceiveId, from: uiReceivePageNodeId, to: receiveSessionNodeId, label: 'accept receive session'),
    UyavaEdge(id: edgeReceiveControllerAutoAcceptId, from: receiveControllerNodeId, to: receiveSessionNodeId, label: 'auto-accept receive session'),
    UyavaEdge(id: edgeSendPageToProgressId, from: uiSendPageNodeId, to: uiProgressNodeId, label: 'open progress'),
    UyavaEdge(id: edgeReceivePageToProgressId, from: uiReceivePageNodeId, to: uiProgressNodeId, label: 'open progress'),
    UyavaEdge(id: edgeSendTabVmToSelectionId, from: sendTabVmNodeId, to: selectedSendingFilesNodeId, label: 'read selected files'),
    UyavaEdge(id: edgeSendTabVmToDiscoveryId, from: sendTabVmNodeId, to: nearbyDevicesNodeId, label: 'read nearby devices'),
    UyavaEdge(id: edgeSendTabVmToFavoritesId, from: sendTabVmNodeId, to: favoritesNodeId, label: 'read favorites'),
    UyavaEdge(id: edgeSendTabVmToLocalIpId, from: sendTabVmNodeId, to: localIpNodeId, label: 'read local ips'),
    UyavaEdge(id: edgeSendTabVmToSettingsId, from: sendTabVmNodeId, to: settingsNodeId, label: 'read settings'),
    UyavaEdge(id: edgeSendTabVmToSendProviderId, from: sendTabVmNodeId, to: sendProviderNodeId, label: 'start session'),
    UyavaEdge(id: edgeReceiveTabVmToSettingsId, from: receiveTabVmNodeId, to: settingsNodeId, label: 'read settings'),
    UyavaEdge(id: edgeReceiveTabVmToServerId, from: receiveTabVmNodeId, to: serverServiceNodeId, label: 'read server state'),
    UyavaEdge(id: edgeReceiveTabVmToLocalIpId, from: receiveTabVmNodeId, to: localIpNodeId, label: 'read local ips'),
    UyavaEdge(id: edgeSettingsControllerToSettingsId, from: settingsTabControllerNodeId, to: settingsNodeId, label: 'mutate settings'),
    UyavaEdge(id: edgeSettingsControllerToServerId, from: settingsTabControllerNodeId, to: serverServiceNodeId, label: 'restart server'),
    UyavaEdge(id: edgeSettingsControllerToLocalIpId, from: settingsTabControllerNodeId, to: localIpNodeId, label: 'refresh local ips'),
    UyavaEdge(id: edgeServerToHttpId, from: serverServiceNodeId, to: httpServerNodeId, label: 'bind server'),
    UyavaEdge(id: edgeServerToReceiveControllerId, from: serverServiceNodeId, to: receiveControllerNodeId, label: 'install receive routes'),
    UyavaEdge(id: edgeServerToWebSendControllerId, from: serverServiceNodeId, to: webSendControllerNodeId, label: 'install web send routes'),
    UyavaEdge(id: edgeSecurityToRustCryptoId, from: securityNodeId, to: rustCryptoNodeId, label: 'verify certificate'),
    UyavaEdge(id: edgeSignalingToRustWebrtcId, from: signalingNodeId, to: rustWebrtcNodeId, label: 'open rtc signaling'),
    UyavaEdge(id: edgeRustBridgeToWebrtcId, from: rustBridgeNodeId, to: rustWebrtcNodeId, label: 'frb call'),
    UyavaEdge(id: edgeRustBridgeToCryptoId, from: rustBridgeNodeId, to: rustCryptoNodeId, label: 'frb call'),
    UyavaEdge(id: edgeRustBridgeToLoggingId, from: rustBridgeNodeId, to: rustLoggingNodeId, label: 'frb call'),
    UyavaEdge(id: edgeSendProviderToSessionId, from: sendProviderNodeId, to: sendSessionNodeId, label: 'own session state'),
    UyavaEdge(id: edgeReceiveControllerToSessionId, from: receiveControllerNodeId, to: receiveSessionNodeId, label: 'own session state'),
    UyavaEdge(id: edgeSendPrepareToHttpId, from: sendProviderNodeId, to: httpClientNodeId, label: 'prepare upload request'),
    UyavaEdge(id: edgeSendProviderToUploadIsolatesId, from: sendProviderNodeId, to: uploadIsolatesNodeId, label: 'dispatch file upload'),
    UyavaEdge(id: edgeReceiveToHttpId, from: receiveSessionNodeId, to: httpServerNodeId, label: 'receive upload'),
    UyavaEdge(id: edgeReceiveToStorageId, from: receiveSessionNodeId, to: fileSaverNodeId, label: 'save file'),
    UyavaEdge(id: edgeSendToProviderId, from: sendSessionNodeId, to: sendProviderNodeId, label: 'report completion'),
    UyavaEdge(id: edgeReceiveToControllerId, from: receiveSessionNodeId, to: receiveControllerNodeId, label: 'finalize receive session'),
    UyavaEdge(id: edgeFileSaverToHistoryId, from: fileSaverNodeId, to: receiveHistoryNodeId, label: 'record receive history'),
    UyavaEdge(id: edgeStorageToLogsId, from: storageGroupNodeId, to: uyavaLogsNodeId, label: 'persist uyava logs'),
  ],
  metricSpecs: <LocalSendUyavaMetricSpec>[
    LocalSendUyavaMetricSpec(
      id: metricFileSizeMb,
      label: 'Transfer size',
      description: 'Per-file transfer size in megabytes.',
      unit: 'MB',
      tags: const <String>[tagTransfer, tagFile, tagMetrics],
      aggregators: const <UyavaMetricAggregator>[
        UyavaMetricAggregator.last,
        UyavaMetricAggregator.max,
        UyavaMetricAggregator.sum,
        UyavaMetricAggregator.count,
      ],
    ),
    LocalSendUyavaMetricSpec(
      id: metricFileDurationMs,
      label: 'File duration',
      description: 'Per-file upload / download duration.',
      unit: 'ms',
      tags: const <String>[tagTransfer, tagFile, tagMetrics],
      aggregators: const <UyavaMetricAggregator>[
        UyavaMetricAggregator.last,
        UyavaMetricAggregator.max,
        UyavaMetricAggregator.min,
        UyavaMetricAggregator.count,
      ],
    ),
    LocalSendUyavaMetricSpec(
      id: metricSessionDurationMs,
      label: 'Session duration',
      description: 'End-to-end transfer session duration.',
      unit: 'ms',
      tags: const <String>[tagTransfer, tagSession, tagMetrics],
      aggregators: const <UyavaMetricAggregator>[
        UyavaMetricAggregator.last,
        UyavaMetricAggregator.max,
        UyavaMetricAggregator.min,
        UyavaMetricAggregator.count,
      ],
    ),
    LocalSendUyavaMetricSpec(
      id: metricThroughputMbPerSec,
      label: 'Throughput',
      description: 'Per-file throughput sample in megabytes per second.',
      unit: 'MB/s',
      tags: const <String>[tagTransfer, tagMetrics],
      aggregators: const <UyavaMetricAggregator>[
        UyavaMetricAggregator.last,
        UyavaMetricAggregator.max,
        UyavaMetricAggregator.min,
        UyavaMetricAggregator.count,
      ],
    ),
    LocalSendUyavaMetricSpec(
      id: metricFilesCount,
      label: 'Files per session',
      description: 'Number of files announced by a transfer session or web-send share.',
      unit: 'count',
      tags: const <String>[tagTransfer, tagSession, tagMetrics],
      aggregators: const <UyavaMetricAggregator>[
        UyavaMetricAggregator.last,
        UyavaMetricAggregator.max,
        UyavaMetricAggregator.min,
        UyavaMetricAggregator.count,
      ],
    ),
    LocalSendUyavaMetricSpec(
      id: metricSelectedFilesCount,
      label: 'Selected files',
      description: 'Number of files accepted for transfer after filtering or selection.',
      unit: 'count',
      tags: const <String>[tagTransfer, tagSelection, tagMetrics],
      aggregators: const <UyavaMetricAggregator>[
        UyavaMetricAggregator.last,
        UyavaMetricAggregator.max,
        UyavaMetricAggregator.min,
        UyavaMetricAggregator.count,
      ],
    ),
  ],
  eventChainSpecs: <LocalSendUyavaEventChainSpec>[
    LocalSendUyavaEventChainSpec(
      id: sendChainId,
      label: 'Send Flow',
      description: 'Send session from UI start through upload preparation and completion.',
      tag: 'chain:send',
      steps: const <UyavaEventChainStep>[
        UyavaEventChainStep(stepId: 'session_created', nodeId: sendSessionNodeId, edgeId: edgeUiToSendId),
        UyavaEventChainStep(stepId: 'prepare_upload', nodeId: httpClientNodeId, edgeId: edgeSendPrepareToHttpId),
        UyavaEventChainStep(stepId: 'transfer_complete', nodeId: sendProviderNodeId, edgeId: edgeSendToProviderId),
      ],
    ),
    LocalSendUyavaEventChainSpec(
      id: receiveChainId,
      label: 'Receive Flow',
      description: 'Incoming receive request through manual or automatic acceptance, file saving, and completion.',
      tag: 'chain:receive',
      steps: const <UyavaEventChainStep>[
        UyavaEventChainStep(stepId: 'incoming_request', nodeId: receiveSessionNodeId, edgeId: edgeReceiveToHttpId),
        UyavaEventChainStep(stepId: 'user_accept', nodeId: uiReceivePageNodeId, edgeId: edgeUiToReceiveId),
        UyavaEventChainStep(stepId: 'auto_accept', nodeId: receiveControllerNodeId, edgeId: edgeReceiveControllerAutoAcceptId),
        UyavaEventChainStep(stepId: 'transfer_started', nodeId: fileSaverNodeId, edgeId: edgeReceiveToStorageId),
        UyavaEventChainStep(stepId: 'transfer_complete', nodeId: receiveControllerNodeId, edgeId: edgeReceiveToControllerId),
      ],
    ),
    LocalSendUyavaEventChainSpec(
      id: sendFileChainId,
      label: 'Send File Flow',
      description: 'Per-file upload from isolate dispatch to session state update.',
      tag: 'chain:send-file',
      steps: const <UyavaEventChainStep>[
        UyavaEventChainStep(stepId: 'file_upload_start', nodeId: uploadIsolatesNodeId, edgeId: edgeSendProviderToUploadIsolatesId),
        UyavaEventChainStep(stepId: 'file_upload_complete', nodeId: sendProviderNodeId, edgeId: edgeSendToProviderId),
      ],
    ),
    LocalSendUyavaEventChainSpec(
      id: receiveFileChainId,
      label: 'Receive File Flow',
      description: 'Per-file receive from HTTP upload to disk save and history record.',
      tag: 'chain:receive-file',
      steps: const <UyavaEventChainStep>[
        UyavaEventChainStep(stepId: 'file_download_start', nodeId: httpServerNodeId, edgeId: edgeReceiveToHttpId),
        UyavaEventChainStep(stepId: 'file_saved', nodeId: fileSaverNodeId, edgeId: edgeReceiveToStorageId),
        UyavaEventChainStep(stepId: 'history_recorded', nodeId: receiveHistoryNodeId, edgeId: edgeFileSaverToHistoryId),
      ],
    ),
  ],
);

class LocalSendUyavaGraph {
  LocalSendUyavaGraph({
    required this.nodeSpecs,
    required this.edges,
    required this.metricSpecs,
    required this.eventChainSpecs,
  }) : nodeSpecsById = <String, LocalSendUyavaNodeSpec>{
         for (final LocalSendUyavaNodeSpec spec in nodeSpecs) spec.id: spec,
       };

  final List<LocalSendUyavaNodeSpec> nodeSpecs;
  final List<UyavaEdge> edges;
  final List<LocalSendUyavaMetricSpec> metricSpecs;
  final List<LocalSendUyavaEventChainSpec> eventChainSpecs;
  final Map<String, LocalSendUyavaNodeSpec> nodeSpecsById;

  List<UyavaNode> get nodes => nodeSpecs.map((spec) => spec.node).toList(growable: false);

  Map<UyavaLifecycleState, List<String>> get startupLifecycleGroups {
    final Map<UyavaLifecycleState, List<String>> result = <UyavaLifecycleState, List<String>>{};
    for (final LocalSendUyavaNodeSpec spec in nodeSpecs) {
      final UyavaLifecycleState state = spec.startupLifecycle;
      result.putIfAbsent(state, () => <String>[]).add(spec.id);
    }
    return result;
  }
}

class LocalSendUyavaNodeSpec {
  const LocalSendUyavaNodeSpec.standard({
    required this.id,
    required this.label,
    required this.tags,
    required this.sourceRef,
    required this.standardType,
    this.parentId,
    this.description,
    this.startupLifecycle = UyavaLifecycleState.initialized,
  });

  final String id;
  final String label;
  final String? description;
  final String? parentId;
  final List<String> tags;
  final String sourceRef;
  final UyavaStandardType standardType;
  final UyavaLifecycleState startupLifecycle;

  UyavaNode get node => UyavaNode.standard(
    id: id,
    standardType: standardType,
    label: label,
    description: description,
    parentId: parentId,
    tags: tags,
  );
}

class LocalSendUyavaMetricSpec {
  const LocalSendUyavaMetricSpec({
    required this.id,
    required this.label,
    required this.description,
    required this.unit,
    required this.tags,
    required this.aggregators,
  });

  final String id;
  final String label;
  final String description;
  final String unit;
  final List<String> tags;
  final List<UyavaMetricAggregator> aggregators;

  void apply() {
    Uyava.defineMetric(
      id: id,
      label: label,
      description: description,
      unit: unit,
      tags: tags,
      aggregators: aggregators,
    );
  }
}

class LocalSendUyavaEventChainSpec {
  const LocalSendUyavaEventChainSpec({
    required this.id,
    required this.label,
    required this.description,
    required this.tag,
    required this.steps,
  });

  final String id;
  final String label;
  final String description;
  final String tag;
  final List<UyavaEventChainStep> steps;

  void apply() {
    Uyava.defineEventChain(
      id: id,
      tag: tag,
      label: label,
      description: description,
      steps: steps,
    );
  }
}
