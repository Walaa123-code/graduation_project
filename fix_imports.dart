import 'dart:io';

void main() async {
  final dir = Directory('lib');
  final files = dir.listSync(recursive: true).whereType<File>().where((f) => f.path.endsWith('.dart'));
  
  for (var file in files) {
    String content = await file.readAsString();
    if (content.contains('package:graduation_project')) {
      content = content.replaceAll('package:graduation_project', 'package:mindecho');
      await file.writeAsString(content);
      print('Fixed \${file.path}');
    }
  }
}
