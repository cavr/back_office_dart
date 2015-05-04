library polymer_core_and_paper_examples.spa.app;

import 'package:polymer/polymer.dart';

@CustomTag('app-globals')
class AppGlobals extends PolymerElement{
  AppGlobals.created() : super.created();
  
  var token = "";
  
 void ready (){
   this.token = token;
 }
}