import 'package:flutter/cupertino.dart';

import 'font_manager.dart';

TextStyle _getTextStyle(double fontSize , FontWeight fontWeight , Color color){
  return TextStyle(
    fontSize: fontSize,
    fontFamily: FontConstants.fontfamilt,
    color: color,
    fontWeight: fontWeight,
  );}

//regular style
TextStyle getRegularStyle({double fontSize = FontSize.s12,required Color color}){
  return _getTextStyle(fontSize, FontWeighManager.regular, color);
}

//medum style
TextStyle getMedumStyle({double fontSize = FontSize.s12,required Color color}){
  return _getTextStyle(fontSize, FontWeighManager.medium, color);
}

//light style
TextStyle getLightStyle({double fontSize = FontSize.s12,required Color color}){
  return _getTextStyle(fontSize, FontWeighManager.light, color);
}

//bold style
TextStyle getBoldStyle({double fontSize = FontSize.s12,required Color color}){
  return _getTextStyle(fontSize, FontWeighManager.bold, color);
}

//sembold style
TextStyle getSimpoldStyle({double fontSize = FontSize.s12,required Color color}){
  return _getTextStyle(fontSize, FontWeighManager.semibold, color);
}