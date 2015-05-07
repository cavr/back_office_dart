@HtmlImport('src/company-view.html')
library polymer_core_and_paper_examples.spa.app;

import 'package:polymer/polymer.dart';
import 'dart:html';
import 'dart:convert';
import 'user-session.dart' as globals;

@CustomTag('company-view')
class CompanyView extends PolymerElement {
  CompanyView.created() : super.created();
  
    
    void loadCompany(Event e) {
      var basic = "Basic " + window.sessionStorage["token"];
      Map header = {'Authorization': basic};
      print("Cargando Valores de Empresa");
      HttpRequest
          .request(globals.companyUrl,
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
