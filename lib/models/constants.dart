import 'package:flutter/material.dart';

kTextfieldDecoration(String hintText, IconData icon) {
  return Padding(
    padding: const EdgeInsets.only(left: 7.0, right: 7.0, bottom: 8.0),
    child: TextField(
      decoration: InputDecoration(
        prefixIcon: Icon(icon, color: Colors.pinkAccent),
        labelText: hintText,
        border: OutlineInputBorder(borderRadius: BorderRadius.circular(18)),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(18),
          borderSide: const BorderSide(color: Colors.pinkAccent, width: 2.0),
        ),
      ),
    ),
  );
}
