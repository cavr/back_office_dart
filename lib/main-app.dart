// Copyright (c) 2013, the Dart project authors.  Please see the AUTHORS file
// for details. All rights reserved. Use of this source code is governed by a
// BSD-style license that can be found in the LICENSE file.

@HtmlImport('src/main-app.html')
library polymer_core_and_paper_examples.spa.app;

import 'dart:html';
import 'package:polymer/polymer.dart';
import 'package:route_hierarchical/client.dart';
import 'src/elements.dart';

/// Simple class which maps page names to paths.
class Page {
  final String name;
  final String path;
  final bool isDefault;
  const Page(this.name, this.path ,{this.isDefault: false});
  String toString() => '$name';
}

/// Element representing the entire example app. There should only be one of
/// these in existence.
@CustomTag('main-app')
class MainApp extends PolymerElement {
  
  /// The current selected [Page].
  @observable Page selectedPage;
  
  /// The list of pages in our app.
  final List<Page> pages = const [
    const Page('Inicio', 'inicio', isDefault: true),
    const Page('Usuarios', 'usuarios'),
    const Page('Prototipos', 'prototipos'),
  ];

  /// The path of the current [Page].
  @observable var route;

  /// The [Router] which is going to control the app.
  final Router router = new Router(useFragment: true);
  MainApp.created() : super.created();
  
//  void main() {
//    PaperButton inButton = querySelector('#inButton');
//    inButton.onClick.listen(login);
//  }
  
  /// Convenience getters that return the expected types to avoid casts.

  CoreScaffold get scaffold => $['scaffold'];
  CoreAnimatedPages get corePages => $['pages'];
  CoreMenu get menu => $['menu'];
  BodyElement get body => document.body;

  domReady() {
    // Set up the routes for all the pages.
    for (var page in pages) {
      router.root.addRoute(
          name: page.name, path: page.path, defaultRoute: page.isDefault,
          enter: enterRoute);
    }
    router.listen();

  }

  /// Updates [selectedPage] and the current route whenever the route changes.
  void routeChanged() {
    if (route is! String) return;
    if (route.isEmpty) {
      selectedPage = pages.firstWhere((page) => page.isDefault);
    } else {
      selectedPage = pages.firstWhere((page) => page.path == route);
    }
    router.go(selectedPage.name, {});
  }

  /// Updates [route] whenever we enter a new route.
  void enterRoute(RouteEvent e) {
    route = e.path;
  }

  /// Close the menu whenever you select an item.
  void menuItemClicked(_) {
    scaffold.closeDrawer();
  }
}
