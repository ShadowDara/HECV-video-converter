import 'dart:io';
import 'package:cli/folder.dart' as folder;

void main(List<String> arguments) async {
  print('HECV Video Converter');
  print('This Programm will convert HECV (H.265) encoded videos to H.264 (libx264)');

  print("\nSelect your videos!");

  print("\nBUT THIS WILL VERY CPU HUNGRY!");

  print("\n[ENTER]");
  stdin.readLineSync();

  final files = await folder.pickMultipleFiles();

  for (var f in files) {
    print('Converting: ${f.path}');

    // Pfad zu input/output
    final inputPath = f.path;
    final outputPath = inputPath.replaceAll(RegExp(r'\.\w+$'), '_converted.mp4');

    // Kommando je nach OS
    List<String> cmd;
    if (Platform.isWindows) {
      cmd = ['cmd', '/c', 'ffmpeg', '-i', inputPath, '-c:v', 'libx264', '-crf', '23', '-preset', 'faster', '-c:a', 'aac', '-b:a', '192k', outputPath];
    } else {
      cmd = ['ffmpeg', '-i', inputPath, '-c:v', 'libx264', '-crf', '23', '-preset', 'faster', '-c:a', 'aac', '-b:a', '192k', outputPath];
    }

    // Prozess ausführen
    final result = await Process.run(cmd.first, cmd.sublist(1));
    print('Exit code: ${result.exitCode}');
    print('stdout: ${result.stdout}');
    print('stderr: ${result.stderr}');
  }

  print("Finished Converting!");
}
