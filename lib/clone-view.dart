@HtmlImport('src/company-view.html')
library polymer_core_and_paper_examples.spa.app;

import 'package:polymer/polymer.dart';
import 'dart:html';
import 'dart:convert';
import 'user-session.dart' as globals;

var usersUrl = "http://localhost:8080/admin/user";
var deleteUsersUrl = "http://localhost:8080/prototype/delete-user/";
var loadUsersUrl = "http://localhost:8080/prototype/users/";

@CustomTag('company-view')
class CompanyView extends PolymerElement {
  CompanyView.created() : super.created();

}
