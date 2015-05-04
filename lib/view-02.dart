@HtmlImport('src/view-02.html')
library polymer_core_and_paper_examples.spa.app;

import 'package:polymer/polymer.dart';
import 'dart:html';
import 'dart:convert';
import 'user-session.dart' as globals;


var usersUrl = "http://localhost:8080/admin/user";

@CustomTag('view-02')
class View02 extends PolymerElement{
  View02.created() : super.created();
 
  void getUsers(Event e) {
    var basic = "Basic " + globals.token;
    Map header =  {'Authorization': basic};
    
    HttpRequest.request(usersUrl, requestHeaders : header).then((HttpRequest req) {
        drawUsers(req.response);

    });
  }
  void drawUsers(response){
    Map parsedMap = JSON.decode(response);
    print("Listando" + parsedMap["data"].length.toString() + "usuarios");
     parsedMap["data"].forEach((key) => print(key));

  }
}