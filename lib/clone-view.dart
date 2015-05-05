@HtmlImport('src/clone-view.html')
library polymer_core_and_paper_examples.spa.app;

import 'package:polymer/polymer.dart';
import 'dart:html';
import 'dart:convert';
import 'user-session.dart' as globals;

@CustomTag('clone-view')
class CompanyView extends PolymerElement {
  CompanyView.created() : super.created();
  
  @observable String prototypeId = "";
  
  var clonePrototypeUrl = "http://localhost:8080/admin/clone-prototype/";
  
  void clonePrototypeIntoProgram(Event e) {
    var basic = "Basic " + globals.token;
    Map header = {'Authorization': basic};
    print("Clonando Prototipo");
    HttpRequest
        .request(clonePrototypeUrl + prototypeId, requestHeaders: header)
        .then((HttpRequest req) {
      //Map data = JSON.decode(req.response);
      print(req.response);
    }).catchError((error) {
      print(error);
    });
  }
}
