import 'package:bloc/bloc.dart';
import 'package:flutter/material.dart';
import 'package:fuegosoft_ayuda_services/app/app.dart';
import 'delegates/bloc_delegate.dart';

void main() async {
  BlocSupervisor.delegate = AyudaBlocDelegate();
  runApp(AyudaApp());
}
