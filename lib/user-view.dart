@HtmlImport('src/user-view.html')
library polymer_core_and_paper_examples.spa.app;

import 'package:polymer/polymer.dart';
import 'dart:html';
import 'dart:convert';
import 'user-session.dart' as globals;

@CustomTag('user-view')
class UserView extends PolymerElement {
  UserView.created() : super.created();

  void getUsers(Event e) {
    var basic = "Basic " + window.sessionStorage["token"];
    Map header = {'Authorization': basic};

    HttpRequest
        .request(globals.usersUrl, requestHeaders: header)
        .then((HttpRequest req) {
      Map parsedMap = JSON.decode(req.response);
      printList(parsedMap["data"]);
    });
  }

  void uploadUsers(Event e) {
    var basic = "Basic " + window.sessionStorage["token"];
    Map header = {'Authorization': basic};
    HttpRequest
        .request(globals.loadUsersUrl, requestHeaders: header)
        .then((HttpRequest req) {     
      //Map data = JSON.decode(req.response);
      printMessage(req.response);
    }).catchError((onError) {
      printMessage(onError.target.responseText);
    });
  }
  void deleteUsersFromCsv(Event e) {
    var basic = "Basic " + window.sessionStorage["token"];
    Map header = {'Authorization': basic};
    HttpRequest
        .request(globals.deleteUsersUrl, requestHeaders: header)
        .then((HttpRequest req) {

      //Map data = JSON.decode(req.response);
      print(req.response);
      printMessage(req.response);
    }).catchError((onError) {
      printMessage(onError.target.responseText);
    });
  }
  void drawUsers(response) {
    Map parsedMap = JSON.decode(response);
    String result = "";
    parsedMap["data"].forEach((value) {
      result += value["email"] + " " + "\n";
    });
    shadowRoot.querySelector('#users').text = result;
    print("Listando " + parsedMap["data"].length.toString() + " usuarios");
    parsedMap["data"].forEach((key) => print(key));
  }
  
  void printList(List users){
    shadowRoot
            .querySelector('#response')
            .innerHtml = '';
    
    shadowRoot
                .querySelector('#users')
                .innerHtml = ("<div id=\"heading\">"+
                              "<div id=\"id\">ID</div>"+
                              "<div id=\"name\">Nombre</div>"+
                              "<div id=\"lastname\">Apellido</div>"+
                              "<div id=\"email\">Email</div>"+
                              "<div id=\"programs\">Programas</div></div>");
    for (var user in users) {
      printUser(user);
    }
  }

  void printMessage(String response) {
    shadowRoot
            .querySelector('#users')
            .innerHtml = '';
   shadowRoot
        .querySelector('#response')
        .innerHtml = ("<br><br><br><pre>" + response + "</pre>");
  }
  
  void printUser(Map user) {
   
   shadowRoot
        .querySelector('#users')
        .appendHtml("<div id=\"row\">"+
            "<div id=\"id\"><p>"+user["id"].toString()+"</p></div>"+
            "<div id=\"name\"><p>"+user["name"]+"</p></div>"+
            "<div id=\"lastname\"><p>"+user["lastName"]+"</p></div>"+
            "<div id=\"email\"><p>"+user["email"]+"</p></div>"+
            "<div id=\"programs\"><p>"+user["programs"].toString()+"</p></div></div>");
  }
}
