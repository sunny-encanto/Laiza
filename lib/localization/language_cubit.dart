import 'package:bloc/bloc.dart';
import 'package:flutter/material.dart';

class LanguageCubit extends Cubit<Locale> {
  LanguageCubit() : super(const Locale('en')); // Set the default language here

  void changeLanguage(Locale locale) {
    emit(locale); // Emit the new locale
  }
}
 // Change language to Spanish (or any locale you want to set)
    // context.read<LanguageCubit>().changeLanguage(Locale('es'));