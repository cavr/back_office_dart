@HtmlImport('src/auth-view.html')
library polymer_core_and_paper_examples.spa.app;

import 'dart:html';
import 'dart:convert';
import 'package:polymer/polymer.dart';
import 'user-session.dart' as globals;


var authUrl = "http://localhost:8080/auth";
var usersUrl = "http://localhost:8080/admin/user";
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

     HttpRequest.postFormData(authUrl, data).then((HttpRequest req) {
       print('Request complete ${req.response}');
  
       Map data = JSON.decode(req.response);
  
       print('apiId: ${data["apiId"]}');
       print('apiSecret ${data["apiSecret"]}');
  
  
       globals.token = window.btoa("${data["apiId"]}:${data["apiSecret"]}");
      
       print(globals.token);

   });
  }
  
  void setUserSession(){
      globals.isLogggedIn = true;
//      this.$.home_login.style.display = 'none';
//      this.$.home_welcome.style.display = '';
      querySelector('>>> home_login').style.display = 'none';
      querySelector('>>> home_welcome').style.display = '';
  }
}

