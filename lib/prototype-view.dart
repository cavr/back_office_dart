@HtmlImport('src/prototype-view.html')
library polymer_core_and_paper_examples.spa.app;

import 'package:polymer/polymer.dart';
import 'user-session.dart' as globals;
import 'dart:html';

@CustomTag('prototype-view')
class PrototypeView extends PolymerElement{
  PrototypeView.created() : super.created();
  
  @observable String programName;
  
  void loadMissionAndMail(Event e) {
    var basic = "Basic " + globals.token;
    Map header = {'Authorization': basic};
    print("Cargando misiones");
    HttpRequest
        .request(globals.missionUrl + programName,
            requestHeaders: header)
        .then((HttpRequest req) {

      //Map data = JSON.decode(req.response);

      print(req.response);
    }).catchError((error) {
      print(error);
    });
    
    print("Cargando Correos");
    HttpRequest
        .request(globals.mailUrl + programName,
            requestHeaders: header)
        .then((HttpRequest req) {

      //Map data = JSON.decode(req.response);

      print(req.response);
    }).catchError((error) {
      print(error);
    });
  }
}