@HtmlImport('src/user-view.html')
library polymer_core_and_paper_examples.spa.app;

import 'package:polymer/polymer.dart';
import 'dart:html';
import 'dart:convert';
import 'user-session.dart' as globals;

@CustomTag('user-view')
class UserView extends PolymerElement {
  UserView.created() : super.created();


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
        .request(globals.loadUsersUrl, requestHeaders: header)
        .then((HttpRequest req) {
      print(req.response);
      //Map data = JSON.decode(req.response);

    }).catchError((error) {
      shadowRoot.querySelector('#users').text = error;
    });
  }
  void deleteUsersFromCsv(Event e) {
    var basic = "Basic " + globals.token;
    Map header = {'Authorization': basic};
    HttpRequest
        .request(globals.deleteUsersUrl , requestHeaders: header)
        .then((HttpRequest req) {

      //Map data = JSON.decode(req.response);
      print(req.response);
    }).catchError((error) {
      shadowRoot.querySelector('#users').text = error;
    });
  }
  void drawUsers(response) {
    Map parsedMap = JSON.decode(response);
    String result = "";
    parsedMap["data"].forEach((value){
      result += value["email"]+" "+"\n";
    });
    shadowRoot.querySelector('#users').text = result;
    print("Listando " + parsedMap["data"].length.toString() + " usuarios");
    parsedMap["data"].forEach((key) => print(key));
  }
}
