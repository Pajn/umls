library class_diagram_tests;

import 'package:guinness/guinness.dart';
import 'package:umls/umls.dart';

main() {
    describe('ClassDiagram', () {
        it('it should parse diagrams', () {
            var classDiagram = new ClassDiagram()..parse(
                '[Post]'
                '[Member|/name:string;cat : bool|login( username : string, password ):bool;logout()]'
                '[Member]1-Comments-*[Comment][Post]1-*[Comment]'
            );

            expect(classDiagram.classes.length).toEqual(3);
            expect(classDiagram.classes[0].name).toEqual('Post');
            expect(classDiagram.classes[1].name).toEqual('Member');
            expect(classDiagram.classes[2].name).toEqual('Comment');

            expect(classDiagram.associations.length).toEqual(2);
            expect(classDiagram.associations[0].name).toEqual('Comments');
            expect(classDiagram.associations[1].name).toBeNull();
        });
    });
}
