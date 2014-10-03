library class_diagram_tests;

import 'package:guinness/guinness.dart';
import 'package:umls/umls.dart';

main() {
    describe('ClassDiagram', () {
        describe('parse', () {
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

        describe('toString', () {
            it('it should encode diagrams', () {
                expect(
                    (new ClassDiagram()
                        ..classes.addAll([
                            new Class()
                                ..name = 'Post',
                            new Class()
                                ..name = 'Member'
                                ..attributes.addAll([
                                    new Variable()
                                        ..name = '/name'
                                        ..type = 'string',
                                    new Variable()
                                        ..name = 'cat'
                                        ..type = 'bool',
                                ])
                                ..methods.addAll([
                                    new Method()
                                        ..name = 'login'
                                        ..arguments.addAll([
                                            new Variable()
                                                ..name = 'username'
                                                ..type = 'string',
                                            new Variable()
                                                ..name = 'password',
                                        ])
                                        ..returnType = 'bool',
                                    new Method()
                                        ..name = 'logout'
                                ])
                        ])
                        ..associations.addAll([
                            new Association()
                                ..from = 'Member'
                                ..fromMultiplicity = '1'
                                ..name = 'Comments'
                                ..toMultiplicity = '*'
                                ..to = 'Comment',
                            new Association()
                                ..from = 'Post'
                                ..fromMultiplicity = '1'
                                ..toMultiplicity = '*'
                                ..to = 'Comment'
                        ])
                    ).toString()
                ).toEqual(
                    '[Post]\n'
                    '[Member|/name:string;cat:bool|login(username:string, password):bool;logout()]\n'
                    '[Member]1-Comments-*[Comment]\n'
                    '[Post]1-*[Comment]');
            });
        });
    });
}
