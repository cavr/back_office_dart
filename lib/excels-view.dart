@HtmlImport('src/excels-view.html')
library polymer_core_and_paper_examples.spa.app;

import 'package:polymer/polymer.dart';
import 'user-session.dart' as globals;
import 'dart:html';

@CustomTag('excels-view')
class ExcelsView extends PolymerElement{
  
  ExcelsView.created() : super.created();
  
  @observable String programId;
  
  void loadDataMining(Event e) {
    var basic = "Basic " + window.sessionStorage["token"];
    Map header = {'Authorization': basic};
    print("Cargando Data Mining");
    HttpRequest
        .request(globals.dataminingUrl,
            requestHeaders: header)
        .then((HttpRequest req) {

      //Map data = JSON.decode(req.response);

      print(req.response);
      printMessage(req.response);
    }).catchError((onError) {
      printMessage(onError.target.responseText);
    });
   
  }
  
  void loadReporting(Event e) {
      var basic = "Basic " + window.sessionStorage["token"];
      Map header = {'Authorization': basic};
      print("Cargando Reporting");
      HttpRequest
          .request(globals.reportingUrl + programId,
              requestHeaders: header)
          .then((HttpRequest req) {

        //Map data = JSON.decode(req.response);

        print(req.response);
        printMessage(req.response);
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