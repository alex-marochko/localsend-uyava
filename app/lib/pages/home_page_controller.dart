import 'package:flutter/material.dart';
import 'package:localsend_app/pages/home_page.dart';
import 'package:localsend_app/uyava/localsend_uyava.dart';
import 'package:refena_flutter/refena_flutter.dart';
import 'package:uyava/uyava.dart';

class HomePageVm {
  final PageController controller;
  final HomeTab currentTab;
  final void Function(HomeTab) changeTab;

  HomePageVm({
    required this.controller,
    required this.currentTab,
    required this.changeTab,
  });
}

final homePageControllerProvider = ReduxProvider<HomePageController, HomePageVm>(
  (ref) => HomePageController(),
);

class HomePageController extends ReduxNotifier<HomePageVm> {
  @override
  HomePageVm init() {
    return HomePageVm(
      controller: PageController(),
      currentTab: HomeTab.receive,
      changeTab: (tab) => redux.dispatch(ChangeTabAction(tab)),
    );
  }
}

class ChangeTabAction extends ReduxAction<HomePageController, HomePageVm> {
  final HomeTab tab;

  ChangeTabAction(this.tab);

  @override
  HomePageVm reduce() {
    final String fromNodeId = _nodeIdForTab(state.currentTab);
    final String toNodeId = _nodeIdForTab(tab);
    LocalSendUyava.onUiTabChanged(
      fromNodeId: fromNodeId,
      toNodeId: toNodeId,
      sourceRef: Uyava.caller(),
    );
    state.controller.jumpToPage(tab.index);
    return HomePageVm(
      controller: state.controller,
      currentTab: tab,
      changeTab: state.changeTab,
    );
  }
}

String _nodeIdForTab(HomeTab tab) {
  switch (tab) {
    case HomeTab.receive:
      return LocalSendUyava.uiReceiveNodeId;
    case HomeTab.send:
      return LocalSendUyava.uiSendNodeId;
    case HomeTab.settings:
      return LocalSendUyava.uiSettingsNodeId;
  }
}
