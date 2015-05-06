@HtmlImport('src/user-view.html')
library polymer_core_and_paper_examples.spa.app;

import 'package:polymer/polymer.dart';
import 'dart:html';
import 'dart:convert';
import 'user-session.dart' as globals;

@CustomTag('user-view')
class UserView extends PolymerElement {
  UserView.created() : super.created();

  @observable String programName = "";
  void getUsers(Event e) {
    var basic = "Basic " + globals.token;
    Map header = {'Authorization': basic};

    HttpRequest
        .request(globals.usersUrl, requestHeaders: header)
        .then((HttpRequest req) {
      drawUsers(req.response);
    });
  }


  void uploadUsers(Event e) {
    var basic = "Basic " + globals.token;
    Map header = {'Authorization': basic};
    HttpRequest
        .request(globals.loadUsersUrl + programName, requestHeaders: header)
        .then((HttpRequest req) {
      print(req.response);
      //Map data = JSON.decode(req.response);

    }).catchError((error) {
      print(error);
    });
  }
  void deleteUsersFromCsv(Event e) {
    var basic = "Basic " + globals.token;
    Map header = {'Authorization': basic};
    HttpRequest
        .request(globals.deleteUsersUrl + programName, requestHeaders: header)
        .then((HttpRequest req) {

      //Map data = JSON.decode(req.response);
      print(req.response);
    }).catchError((error) {
      print(error);
    });
  }
  void drawUsers(response) {
    Map parsedMap = JSON.decode(response);
    shadowRoot.querySelector('#users').text = JSON.encode(parsedMap["data"]);
    print("Listando " + parsedMap["data"].length.toString() + " usuarios");
    parsedMap["data"].forEach((key) => print(key));
  }
}
