import 'package:flutter/material.dart';

class InputDecorations{
  static InputDecoration authInputDecoration({
    required bool esEdicion,
    required String hintText,
    required String labelText,
    required bool varEsContrasenia,
    required double varTamanioIcono,
    IconData? prefxIcon,
    IconData? sufixIcon,
    Color? colorTexto,
    Color? colorBordes,
    Color? colorPrefixIcon,
    double? tamanioLetraLabel,
    required VoidCallback varOnPress,
  }) {

    return esEdicion ?
    InputDecoration(
      enabledBorder: OutlineInputBorder(
        borderRadius: const BorderRadius.all(Radius.circular(10.0)),
        borderSide: BorderSide(
          color: colorBordes ?? Colors.deepOrange,
        ),
      ),
      focusedBorder: OutlineInputBorder(
        borderSide: BorderSide(
          color: colorBordes ?? Colors.deepOrange,
          width: 2
          )
        ),
      hintText: hintText,
      hintStyle: TextStyle(color: colorTexto),
      errorStyle: TextStyle(color: colorTexto),
      counterStyle: TextStyle(color: colorTexto),
      errorBorder: UnderlineInputBorder(
        borderRadius: const BorderRadius.all(Radius.circular(10.0)),
        borderSide: BorderSide(
          color: colorTexto ?? Colors.white,
        ),
      ),
      labelText: labelText,
      labelStyle: TextStyle(color: colorTexto, fontSize: tamanioLetraLabel),
      fillColor: colorTexto,
    )
    :
    prefxIcon != null && sufixIcon != null ?
    InputDecoration(
      enabledBorder: OutlineInputBorder(
        borderRadius: const BorderRadius.all(Radius.circular(10.0)),
        borderSide: BorderSide(
          color: colorBordes ?? Colors.deepOrange,
        ),
      ),
      focusedBorder: OutlineInputBorder(
        borderSide: BorderSide(
          color: colorBordes ?? Colors.deepOrange,
          width: 2
          )
        ),
      hintText: hintText,
      hintStyle: TextStyle(color: colorTexto),
      errorStyle: TextStyle(color: colorTexto),
      counterStyle: TextStyle(color: colorTexto),
      errorBorder: UnderlineInputBorder(
        borderRadius: const BorderRadius.all(Radius.circular(10.0)),
        borderSide: BorderSide(
          color: colorTexto ?? Colors.white,
        ),
      ),
      labelText: labelText,
      labelStyle: TextStyle(color: colorTexto, fontSize: tamanioLetraLabel),
      fillColor: colorTexto,
      prefixIcon: Icon(prefxIcon, color: colorPrefixIcon ?? Colors.white,), 
      suffixIcon: IconButton(icon: Icon(sufixIcon, color: colorPrefixIcon ?? Colors.white, size: varTamanioIcono,), onPressed: varOnPress,),
                
    )

    :

    prefxIcon != null ?

    InputDecoration(
     // border: OutlineInputBorder(borderRadius: const BorderRadius.all(Radius.circular(1.0))),
      enabledBorder: OutlineInputBorder(//UnderlineInputBorder(
        borderRadius: const BorderRadius.all(Radius.circular(10.0)),
        borderSide: BorderSide(
          color: colorBordes ?? Colors.deepOrange,
        ),
      ),
      focusedBorder: OutlineInputBorder(//UnderlineInputBorder(
        borderSide: BorderSide(
          color: colorBordes ?? Colors.deepOrange,
          width: 2
          )
        ),
      hintText: hintText,//'avaldiviezo@riasem.com.ec',
      hintStyle: TextStyle(color: colorTexto),
      errorStyle: TextStyle(color: colorTexto),
      counterStyle: TextStyle(color: colorTexto),
      errorBorder: UnderlineInputBorder(//UnderlineInputBorder(
        borderRadius: const BorderRadius.all(Radius.circular(10.0)),
        borderSide: BorderSide(
          color: colorTexto ?? Colors.white,
        ),
      ),
      labelText: labelText,//'Correo electrónico',
      labelStyle: TextStyle(color: colorTexto),//TextStyle(color: Colors.white),
      fillColor: colorTexto,//Colors.white,
      
      prefixIcon: Icon(prefxIcon, color: varEsContrasenia ? Colors.white : colorPrefixIcon,), 
                
    )

    :

    InputDecoration(
      enabledBorder: OutlineInputBorder(//UnderlineInputBorder(
        borderRadius: const BorderRadius.all(Radius.circular(10.0)),
        borderSide: BorderSide(
          color: colorBordes ?? Colors.deepOrange,
        ),
      ),
      focusedBorder: OutlineInputBorder(//UnderlineInputBorder(
        borderSide: BorderSide(
            color: colorBordes ?? Colors.deepOrange,
            width: 2
          )
        ),
      hintText: hintText,
      hintStyle: TextStyle(color: colorTexto, fontSize: 30),
      errorStyle: TextStyle(color: colorTexto, fontSize: 30),
      counterStyle: TextStyle(color: colorTexto, fontSize: 30),
      errorBorder: const UnderlineInputBorder(
        borderRadius: BorderRadius.all(Radius.circular(10.0)),
        borderSide: BorderSide(
          color: Colors.white,
        ),
      ),
      prefixStyle: TextStyle(color: colorTexto, fontSize: 30),
      suffixStyle: TextStyle(color: colorTexto, fontSize: 30),
      floatingLabelStyle: TextStyle(color: colorTexto, fontSize: 30),
      helperStyle: TextStyle(color: colorTexto, fontSize: 30),
      labelText: labelText,
      labelStyle: TextStyle(color: colorTexto, fontSize: 30),
      fillColor: colorTexto,
      suffixIcon: IconButton(icon: Icon(sufixIcon, color: colorPrefixIcon ?? Colors.white, size: varTamanioIcono,), onPressed: varOnPress,),
    );

  }
}
