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
    var basic = "Basic " + globals.token;
    Map header = {'Authorization': basic};
    print("Cargando Data Mining");
    HttpRequest
        .request(globals.dataminingUrl,
            requestHeaders: header)
        .then((HttpRequest req) {

      //Map data = JSON.decode(req.response);

      print(req.response);
    }).catchError((error) {
      print(error);
    });
   
  }
  
  void loadReporting(Event e) {
      var basic = "Basic " + globals.token;
      Map header = {'Authorization': basic};
      print("Cargando Reporting");
      HttpRequest
          .request(globals.reportingUrl + programId,
              requestHeaders: header)
          .then((HttpRequest req) {

        //Map data = JSON.decode(req.response);

        print(req.response);
      }).catchError((error) {
        print(error);
      });
  }
}