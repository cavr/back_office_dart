@HtmlImport('src/company-view.html')
library polymer_core_and_paper_examples.spa.app;

import 'package:polymer/polymer.dart';
import 'dart:html';
import 'dart:convert';
import 'user-session.dart' as globals;

@CustomTag('company-view')
class CompanyView extends PolymerElement {
  CompanyView.created() : super.created();
  
  @observable String programId;
    
    void loadCompany(Event e) {
      var basic = "Basic " + globals.token;
      Map header = {'Authorization': basic};
      print("Cargando Valores de Empresa");
      HttpRequest
          .request(globals.companyUrl,
              requestHeaders: header)
          .then((HttpRequest req) {

        //Map data = JSON.decode(req.response);

        print(req.response);
      }).catchError((error) {
        print(error);
      });
     
    }
}
