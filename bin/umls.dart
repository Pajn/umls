import 'dart:convert';
import 'package:umls/umls.dart';

main(List<String> arguments) {
    var classDiagram = new ClassDiagram()
        ..parse(arguments.first)
        ..toJson();

    var jsonEncoder = const JsonEncoder.withIndent('    ');
    print(jsonEncoder.convert(classDiagram));
}
