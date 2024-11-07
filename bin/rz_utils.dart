import 'dart:io';
import 'package:process_run/shell.dart';
import 'package:args/args.dart';

void main(List<String> arguments) async {
  final parser = ArgParser()
    ..addCommand('install')
    ..addCommand('generate')
    ..addFlag('help', abbr: 'h', negatable: false, help: 'Show this help');

  final argResults = parser.parse(arguments);

  if (argResults['help'] as bool || argResults.command == null) {
    print('Usage: my_cli <command> [options]');
    print('Available commands:');
    print('  install     Install required packages');
    print('  generate    Generate files');
    print(parser.usage);
    exit(0);
  }

  final shell = Shell();

  if (argResults.command?.name == 'install') {
    await installPackages(shell);
  } else if (argResults.command?.name == 'generate') {
    generateFiles();
  } else {
    print('Unknown command. Use --help to see usage.');
  }
}

Future<void> installPackages(Shell shell) async {
  print('Installing packages...');

  // List of packages to install
  List<String> packages = [
    'google_fonts',
    'hexcolor',
    'logger',
    'intl',
    'flutter_screenutil',
  ];

  for (var package in packages) {
    print('Installing $package...');
    await shell.run('flutter pub add $package');
  }

  print('All packages installed!');

  // Jalankan `get init` setelah instalasi paket
  print('Initializing GetX...');
  await shell.run('flutter pub run get_cli:create init');
  print('GetX initialized!');
}

void generateFiles() {
  print('Generating files...');

  // Generate a file with some boilerplate content
  final fileContent = '''
import 'package:logger/logger.dart';

class TLoggerHelper {
  static final Logger _logger = Logger(
    printer: PrettyPrinter(),
    // Customize the log levels based on your needs
    level: Level.debug,
  );

  static void debug(String message) {
    _logger.d(message);
  }

  static void info(String message) {
    _logger.i(message);
  }

  static void warning(String message) {
    _logger.w(message);
  }

  static void error(String message, [dynamic error]) {
    _logger.e(message, error: error,  stackTrace: StackTrace.current);
  }
}

''';

  final filePath = 'lib/app/utils/custom_logger.dart';
  final file = File(filePath);
  file.createSync(recursive: true);
  file.writeAsStringSync(fileContent);

  print('File generated at $filePath');
}

void generateFiles2() {
  print('Generating files...');

  // Generate a file with some boilerplate content
  final fileContent = '''
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:iconsax/iconsax.dart';

import '../constants/colors.dart';
import '../helpers/helper_functions.dart';

class TSnackbar {
  static hideSnackBar() =>
      ScaffoldMessenger.of(Get.context!).hideCurrentSnackBar();

  static customToast({required message}) {
    ScaffoldMessenger.of(Get.context!).showSnackBar(
      SnackBar(
        elevation: 0,
        duration: const Duration(seconds: 3),
        backgroundColor: Colors.transparent,
        content: Container(
          padding: const EdgeInsets.all(12.0),
          margin: const EdgeInsets.symmetric(horizontal: 30),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(30),
            color: THelperFunctions.isDarkMode(Get.context!)
                ? TColors.darkerGrey.withOpacity(0.9)
                : TColors.grey.withOpacity(0.9),
          ),
          child: Center(
              child: Text(message,
                  style: Theme.of(Get.context!).textTheme.labelLarge)),
        ),
      ),
    );
  }

  static successSnackBar({required title, message, duration = 3}) {
    Get.snackbar(
      title,
      message,
      isDismissible: true,
      shouldIconPulse: true,
      colorText: Colors.white,
      backgroundColor: TColors.primary,
      snackPosition: SnackPosition.BOTTOM,
      duration: Duration(seconds: duration),
      margin: const EdgeInsets.all(10),
      icon: const Icon(Iconsax.check, color: TColors.white),
    );
  }

  static warningSnackBar({required title, message}) {
    Get.snackbar(
      title,
      message,
      isDismissible: true,
      shouldIconPulse: true,
      colorText: TColors.white,
      backgroundColor: Colors.orange,
      snackPosition: SnackPosition.BOTTOM,
      duration: const Duration(seconds: 3),
      margin: const EdgeInsets.all(20),
      icon: const Icon(Iconsax.warning_2, color: TColors.white),
    );
  }

  static errorSnackBar({required title, message}) {
    Get.snackbar(
      title,
      message,
      isDismissible: true,
      shouldIconPulse: true,
      colorText: TColors.white,
      backgroundColor: Colors.red.shade600,
      snackPosition: SnackPosition.BOTTOM,
      duration: const Duration(seconds: 3),
      margin: const EdgeInsets.all(20),
      icon: const Icon(Iconsax.warning_2, color: TColors.white),
    );
  }
}
''';

  final filePath = 'lib/app/utils/custom_snackbar.dart';
  final file = File(filePath);
  file.createSync(recursive: true);
  file.writeAsStringSync(fileContent);

  print('File generated at $filePath');
}

void generateFiles3() {
  print('Generating files...');

  // Generate a file with some boilerplate content
  final fileContent = '''
import 'package:flutter/material.dart';

class TColors {
  // App theme colors
  static const Color primary = Color(0xFF2F70AA);
  static const Color secondary = Color(0xFFFFE24B);
  static const Color accent = Color(0xFFb0c7ff);

  // Text colors
  static const Color textPrimary = Color(0xFF333333);
  static const Color textSecondary = Color(0xFF6C757D);
  static const Color textWhite = Colors.white;

  // Background colors
  static const Color light = Color(0xFFF6F6F6);
  static const Color dark = Color(0xFF272727);
  static const Color primaryBackground = Color(0xFFF3F5FF);

  // Background Container colors
  static const Color lightContainer = Color(0xFFF6F6F6);
  static Color darkContainer = TColors.white.withOpacity(0.1);

  // Button colors
  static const Color buttonPrimary = Color(0xFF2F70AA);
  static const Color buttonSecondary = Color(0xFF6C757D);
  static const Color buttonDisabled = Color(0xFFC4C4C4);

  // Border colors
  static const Color borderPrimary = Color(0xFFD9D9D9);
  static const Color borderSecondary = Color(0xFFE6E6E6);

  // Error and validation colors
  static const Color error = Color(0xFFD32F2F);
  static const Color success = Color(0xFF388E3C);
  static const Color warning = Color(0xFFFF9500);
  static const Color info = Color(0xFF2F70AA);

  // Neutral Shades
  static const Color black = Color(0xFF232323);
  static const Color darkerGrey = Color(0xFF4F4F4F);
  static const Color darkGrey = Color(0xFF939393);
  static const Color grey = Color(0xFFE0E0E0);
  static const Color softGrey = Color(0xFFF4F4F4);
  static const Color lightGrey = Color(0xFFF9F9F9);
  static const Color white = Color(0xFFFFFFFF);

}
''';

  final filePath = 'lib/app/utils/custom_colors.dart';
  final file = File(filePath);
  file.createSync(recursive: true);
  file.writeAsStringSync(fileContent);

  print('File generated at $filePath');
}
