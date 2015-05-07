@HtmlImport('src/prototype-view.html')
library polymer_core_and_paper_examples.spa.app;

import 'package:polymer/polymer.dart';
import 'user-session.dart' as globals;
import 'dart:html';

@CustomTag('prototype-view')
class PrototypeView extends PolymerElement{
  PrototypeView.created() : super.created();
  
  
  void loadMissionAndMail(Event e) {
    var basic = "Basic " + window.sessionStorage["token"];
    Map header = {'Authorization': basic};
    print("Cargando misiones");
    HttpRequest
        .request(globals.missionUrl ,
            requestHeaders: header)
        .then((HttpRequest req) {

      //Map data = JSON.decode(req.response);

      print("Cargando Correos");
         HttpRequest
             .request(globals.mailUrl,
                 requestHeaders: header)
             .then((HttpRequest req) {

           //Map data = JSON.decode(req.response);

           print(req.response);
         }).catchError((error) {
           print(error);
         });
      print(req.response);
    }).catchError((onError) {
      printMessage(onError.target.responseText);
    });      
  }
  void printMessage(String response) {
      shadowRoot
           .querySelector('#response')
           .innerHtml = ("<br><br><br>><pre>" + response + "</pre>");
     }
}