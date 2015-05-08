@HtmlImport('src/mail-view.html')
library polymer_core_and_paper_examples.spa.app;

import 'package:polymer/polymer.dart';
import 'user-session.dart' as globals;
import 'dart:html';
import 'dart:convert';

@CustomTag('mail-view')
class MailView extends PolymerElement{
  
  MailView.created() : super.created();
  
  @observable String users;
  
  void invite(Event e) {
    print(users);
    var basic = "Basic " + window.sessionStorage["token"];

    print("Invitando Usuarios");
    
    List userList = users.trim().split("\n"); 
    Map usersData = {'userList': userList};
    
    var request = new HttpRequest();

      request.onReadyStateChange.listen((Event e) {
        printMessage(request.responseText);
      });

      request.open('POST', globals.inviteUsersUrl);

      request.setRequestHeader('Authorization', basic);
      request.setRequestHeader('Content-Type', 'application/json');
      request.send(JSON.encode(usersData));
   
  }
  
  void welcome(Event e) {
      var basic = "Basic " + window.sessionStorage["token"];
      
      print("Welcome Mail");
      
      List userList = users.trim().split("\n"); 
          Map usersData = {'userList': userList};
          
          var request = new HttpRequest();

            request.onReadyStateChange.listen((Event e) {
              printMessage(request.responseText);
            });

            request.open('POST', globals.welcomeAllUrl);

            request.setRequestHeader('Authorization', basic);
            request.setRequestHeader('Content-Type', 'application/json');
            request.send(JSON.encode(usersData));
            
  }
  
  void printMessage(String response) {
      shadowRoot
           .querySelector('#response')
           .innerHtml = ("<br><br><br>><pre>" + response + "</pre>");
     }
}