@HtmlImport('src/auth-view.html')
@HtmlImport('src/main-app.html')
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
class AuthView extends PolymerElement{
  AuthView.created() : super.created();
  
  @observable String userValue = "";
  @observable String pwdValue = "";

  
  void change(Event event, var detail, TextAreaElement textElement) {
    user = userValue;
    password = pwdValue;
  }
  
  void login(Event e) {
      print("Login event");
    
     var data = {
       'email': userValue,
       'password': pwdValue
     };

     HttpRequest.postFormData(globals.authUrl, data).then((HttpRequest req) {
       print('Request complete ${req.response}');
  
       Map data = JSON.decode(req.response);
  
       print('apiId: ${data["apiId"]}');
       print('apiSecret ${data["apiSecret"]}');
  
  
       globals.token = window.btoa("${data["apiId"]}:${data["apiSecret"]}");
      
       print(globals.token);
       setUserSession();

   });
  }
  
  void setUserSession(){
      globals.isLogggedIn = true;
      shadowRoot.querySelector('#home_login').style.display = 'none';
      shadowRoot.querySelector('#home_welcome').style.display = '';
      main.userIcon.style.backgroundColor = '#64DD17';
  }
}

