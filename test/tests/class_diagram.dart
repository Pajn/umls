import 'package:guinness/guinness.dart';
import 'package:uml_parser/uml_parser.dart';

main() {
    describe('ClassDiagram', () {
        it('it should parse simple diagrams', () {
            var classDiagram = new ClassDiagram()..parse(
                '[Post][Member|/name:string;cat : bool|login( username : string, password ):bool;'
                'logout()] [Member]-[Comment]'
            );

            expect(classDiagram.classes.length).toEqual(3);
            expect(classDiagram.classes[0].name).toEqual('Post');
            expect(classDiagram.classes[1].name).toEqual('Member');
            expect(classDiagram.classes[2].name).toEqual('Comment');
        });
    });
}
