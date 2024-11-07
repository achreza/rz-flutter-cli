import 'dart:io';
import 'package:process_run/shell.dart';

Future<void> cloneAndRun() async {
  final shell = Shell();

  // 1. Mengkloning repositori dari GitHub
  print('Cloning repository...');
  await shell.run('git clone https://github.com/achreza/rz-flutter-cli.git');

  // 2. Pindah ke direktori repositori yang baru di-kloning
  print('Navigating to repository directory...');
  await shell.run('cd rz-flutter-cli');

  // 3. Menjalankan perintah `dart run` untuk mengeksekusi skrip dari repositori
  print('Running generate script...');
  await shell.run('dart run bin/rz_utils.dart generate');
}

void main() {
  cloneAndRun();
}
