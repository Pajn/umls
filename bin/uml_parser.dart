import 'dart:convert';
import 'package:uml_parser/uml_parser.dart';

main(List<String> arguments) {
    var classDiagram = new ClassDiagram()
        ..parse(arguments.first)
        ..toJson();

    var jsonEncoder = const JsonEncoder.withIndent('    ');
    print(jsonEncoder.convert(classDiagram));
}
