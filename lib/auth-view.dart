@HtmlImport('src/auth-view.html')
library polymer_core_and_paper_examples.spa.app;

import 'dart:html';
import 'dart:convert';
import 'package:polymer/polymer.dart';
import 'user-session.dart' as globals;
import 'main-app.dart' as main;

String user;
String password;

var stepIndex = 1;

@CustomTag('auth-view')
class AuthView extends PolymerElement {
  AuthView.created() : super.created() {
    String token = window.sessionStorage["token"];
    if (token != null) {
      setUserSession();
    }
    
  }

  @observable String userValue = "";
  @observable String pwdValue = "";

  void change(Event event, var detail, TextAreaElement textElement) {
    user = userValue;
    password = pwdValue;
  }

  void login(Event e) {
    print("Login event");

    var data = {'email': userValue, 'password': pwdValue};

    HttpRequest.postFormData(globals.authUrl, data).then((HttpRequest req) {
      print('Request complete ${req.response}');

      Map data = JSON.decode(req.response);

      print('apiId: ${data["apiId"]}');
      print('apiSecret ${data["apiSecret"]}');

      String token = window.btoa("${data["apiId"]}:${data["apiSecret"]}");
      window.sessionStorage["token"] = token;
      print(token);
      setUserSession();
    }).catchError((onError) {
      printMessage(onError.target.responseText);
    });
  }

  void setUserSession() {
    globals.isLogggedIn = true;
//      this.$.home_login.style.display = 'none';
//      this.$.home_welcome.style.display = '';
    shadowRoot.querySelector('#home_login').style.display = 'none';
    shadowRoot.querySelector('#home_welcome').style.display = '';
    shadowRoot.querySelector('#response').style.display = 'none';
    main.userIcon.style.backgroundColor = '#64DD17';
    main.menuList.style.display = 'block';
    HttpRequest
            .request(globals.pingUrl)
            .then((HttpRequest req) {

      Map parsedMap = JSON.decode(req.response);
            if(parsedMap["credentials"] == 1)
              shadowRoot.querySelector('#serverStatus').innerHtml = "Estado del Servidor <img alt=\"OK\" src=\"packages/back_office/src/img/ok.png\">";
            else 
              shadowRoot.querySelector('#serverStatus').innerHtml = "Estado del Servidor <img alt=\"FAIL\" src=\"packages/back_office/src/img/fail.png\">";

        }).catchError((onError) {
          printMessage(onError.target.responseText);
        });
  }
  

  void logOut() {
    globals.isLogggedIn = false;
//      this.$.home_login.style.display = 'none';
//      this.$.home_welcome.style.display = '';
    shadowRoot.querySelector('#home_login').style.display = '';
    shadowRoot.querySelector('#home_welcome').style.display = 'none';
    window.sessionStorage.remove("token");
    main.userIcon.style.backgroundColor = '#E57373';
    main.menuList.style.display = 'none';
  }
  void printMessage(String response) {
      shadowRoot
           .querySelector('#response')
           .innerHtml = ("<br><br><br>><pre>" + response + "</pre>");
     }

}
