import 'package:flutter/material.dart';
import 'package:expense_tracker/widgets/expenses/expenses.dart';

var kColorScheme =
    ColorScheme.fromSeed(seedColor: const Color.fromRGBO(144, 202, 249, 1));

var kDarkColorScheme =
    ColorScheme.fromSeed(seedColor: const Color.fromRGBO(66, 165, 245, 1));

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        darkTheme: ThemeData.dark().copyWith(
            colorScheme: kDarkColorScheme,
            appBarTheme: const AppBarTheme().copyWith(
              backgroundColor:
                  kDarkColorScheme.onPrimaryContainer.withOpacity(0.8),
              foregroundColor: kDarkColorScheme.primaryContainer,
            ),
            cardTheme: const CardTheme().copyWith(
                color: kDarkColorScheme.secondaryContainer.withOpacity(0.8),
                margin: const EdgeInsets.symmetric(
                  horizontal: 16,
                  vertical: 8,
                )),
            elevatedButtonTheme: ElevatedButtonThemeData(
                style: ElevatedButton.styleFrom(
              backgroundColor: kDarkColorScheme.primaryContainer,
            )),
            textTheme: ThemeData().textTheme.copyWith(
                titleLarge: TextStyle(
                    color: kDarkColorScheme.onSecondaryContainer,
                    fontSize: 20,
                    fontWeight: FontWeight.normal)),
            bottomSheetTheme: BottomSheetThemeData(
              backgroundColor: kDarkColorScheme.secondaryContainer,
            )),
        theme: ThemeData().copyWith(
          colorScheme: kColorScheme,
          appBarTheme: const AppBarTheme().copyWith(
            backgroundColor: kColorScheme.onPrimaryContainer.withOpacity(0.8),
            foregroundColor: kColorScheme.primaryContainer,
          ),
          cardTheme: const CardTheme().copyWith(
              color: kColorScheme.secondaryContainer,
              margin: const EdgeInsets.symmetric(
                horizontal: 16,
                vertical: 8,
              )),
          elevatedButtonTheme: ElevatedButtonThemeData(
              style: ElevatedButton.styleFrom(
            backgroundColor: kColorScheme.primaryContainer,
          )),
          textTheme: ThemeData().textTheme.copyWith(
              titleLarge: TextStyle(
                  color: kColorScheme.onSecondaryContainer,
                  fontSize: 20,
                  fontWeight: FontWeight.normal)),
        ),
        themeMode: ThemeMode.system,
        home: Expenses());
  }
}
