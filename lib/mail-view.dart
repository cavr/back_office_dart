@HtmlImport('src/mail-view.html')
library polymer_core_and_paper_examples.spa.app;

import 'package:polymer/polymer.dart';
import 'user-session.dart' as globals;
import 'dart:html';

@CustomTag('mail-view')
class MailView extends PolymerElement{
  
  MailView.created() : super.created();
  
  @observable String users;
  
  void invite(Event e) {
    print(users);
    var basic = "Basic " + globals.token;
    Map header = {'Authorization': basic};
    print("Invitando Usuarios");
    HttpRequest
        .request(globals.inviteUsersUrl,
            requestHeaders: header)
        .then((HttpRequest req) {

      //Map data = JSON.decode(req.response);

      print(req.response);
    }).catchError((error) {
      print(error);
    });
   
  }
  
  void welcome(Event e) {
      var basic = "Basic " + globals.token;
      Map header = {'Authorization': basic};
      print("Welcome Mail");
      HttpRequest
          .request(globals.welcomeAllUrl,
              requestHeaders: header)
          .then((HttpRequest req) {

        //Map data = JSON.decode(req.response);

        print(req.response);
      }).catchError((error) {
        print(error);
      });
  }
}