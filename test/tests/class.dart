library class_tests;

import 'package:guinness/guinness.dart';
import 'package:umls/umls.dart';

main() {
    describe('Class', () {
        describe('parse', () {
            it('should parse simple classes', () {
                Class classObject = new Class()..parse('[Simple]');

                expect(classObject.name).toEqual('Simple');
                expect(classObject.attributes).toEqual([]);
                expect(classObject.methods).toEqual([]);
            });

            it('should parse classes with a single attribute', () {
                Class classObject = new Class()..parse('[Attribute|attribute]');

                expect(classObject.name).toEqual('Attribute');
                expect(classObject.attributes.length).toEqual(1);
                expect(classObject.attributes.first.name).toEqual('attribute');
                expect(classObject.attributes.first.type).toBeNull();
                expect(classObject.methods).toEqual([]);
            });

            it('should parse classes with multiple attributes', () {
                Class classObject = new Class()..parse('[Attributes|firstname;lastname]');

                expect(classObject.name).toEqual('Attributes');
                expect(classObject.attributes.length).toEqual(2);
                expect(classObject.attributes.first.name).toEqual('firstname');
                expect(classObject.attributes.first.type).toBeNull();
                expect(classObject.attributes.last.name).toEqual('lastname');
                expect(classObject.attributes.last.type).toBeNull();
                expect(classObject.methods).toEqual([]);
            });

            it('should parse classes with typed attributes', () {
                Class classObject = new Class()..parse('[Attributes|firstname:string;lastname:string]');

                expect(classObject.name).toEqual('Attributes');
                expect(classObject.attributes.length).toEqual(2);
                expect(classObject.attributes.first.name).toEqual('firstname');
                expect(classObject.attributes.first.type).toEqual('string');
                expect(classObject.attributes.last.name).toEqual('lastname');
                expect(classObject.attributes.last.type).toEqual('string');
                expect(classObject.methods).toEqual([]);
            });

            it('should parse classes with a single method', () {
                Class classObject = new Class()..parse('[Method||go()]');

                expect(classObject.name).toEqual('Method');
                expect(classObject.attributes).toEqual([]);
                expect(classObject.methods.length).toEqual(1);
                expect(classObject.methods.first.name).toEqual('go');
                expect(classObject.methods.first.arguments).toEqual([]);
                expect(classObject.methods.first.returnType).toBeNull();
            });

            it('should parse classes with multiple methods', () {
                Class classObject = new Class()..parse('[Methods||go();stop()]');

                expect(classObject.name).toEqual('Methods');
                expect(classObject.attributes).toEqual([]);
                expect(classObject.methods.length).toEqual(2);
                expect(classObject.methods.first.name).toEqual('go');
                expect(classObject.methods.first.arguments).toEqual([]);
                expect(classObject.methods.first.returnType).toBeNull();
                expect(classObject.methods.last.name).toEqual('stop');
                expect(classObject.methods.last.arguments).toEqual([]);
                expect(classObject.methods.last.returnType).toBeNull();
            });

            it('should parse classes with methods with arguments', () {
                Class classObject = new Class()..parse('[Methods||go(length:int, direction);stop(force:bool)]');

                expect(classObject.name).toEqual('Methods');
                expect(classObject.attributes).toEqual([]);
                expect(classObject.methods.length).toEqual(2);
                expect(classObject.methods.first.name).toEqual('go');
                expect(classObject.methods.first.arguments.length).toEqual(2);
                expect(classObject.methods.first.arguments.first.name).toEqual('length');
                expect(classObject.methods.first.arguments.first.type).toEqual('int');
                expect(classObject.methods.first.arguments.last.name).toEqual('direction');
                expect(classObject.methods.first.arguments.last.type).toBeNull();
                expect(classObject.methods.first.returnType).toBeNull();
                expect(classObject.methods.last.name).toEqual('stop');
                expect(classObject.methods.last.arguments.length).toEqual(1);
                expect(classObject.methods.last.arguments.first.name).toEqual('force');
                expect(classObject.methods.last.arguments.first.type).toEqual('bool');
                expect(classObject.methods.last.returnType).toBeNull();
            });

            it('should parse classes with methods with a return type', () {
                Class classObject = new Class()..parse('[Method||go():bool]');

                expect(classObject.name).toEqual('Method');
                expect(classObject.attributes).toEqual([]);
                expect(classObject.methods.length).toEqual(1);
                expect(classObject.methods.first.name).toEqual('go');
                expect(classObject.methods.first.arguments).toEqual([]);
                expect(classObject.methods.first.returnType).toEqual('bool');
            });
        });

        describe('toString', () {
            it('should encode simple classes', () {
                expect(
                    (new Class()
                        ..name = 'Simple'
                    ).toString()
                ).toEqual('[Simple]');
            });

            it('should encode classes with a single attribute', () {
                expect(
                    (new Class()
                        ..name = 'Attribute'
                        ..attributes.add(
                            new Variable()
                                ..name = 'attribute'
                        )
                    ).toString()
                ).toEqual('[Attribute|attribute]');
            });

            it('should encode classes with multiple attributes', () {
                expect(
                    (new Class()
                        ..name = 'Attributes'
                        ..attributes.addAll([
                            new Variable()
                                ..name = 'firstname',
                            new Variable()
                                ..name = 'lastname',
                        ])
                    ).toString()
                ).toEqual('[Attributes|firstname;lastname]');
            });

            it('should encode classes with typed attributes', () {
                expect(
                    (new Class()
                        ..name = 'Attributes'
                        ..attributes.addAll([
                            new Variable()
                                ..name = 'firstname'
                                ..type = 'string',
                            new Variable()
                                ..name = 'lastname'
                                ..type = 'string',
                        ])
                    ).toString()
                ).toEqual('[Attributes|firstname:string;lastname:string]');
            });

            it('should encode classes with a single method', () {
                expect(
                    (new Class()
                        ..name = 'Method'
                        ..methods.add(
                            new Method()
                                ..name = 'go'
                        )
                    ).toString()
                ).toEqual('[Method||go()]');
            });

            it('should encode classes with multiple methods', () {
                expect(
                    (new Class()
                        ..name = 'Methods'
                        ..methods.addAll([
                            new Method()
                                ..name = 'go',
                            new Method()
                                ..name = 'stop'
                        ])
                    ).toString()
                ).toEqual('[Methods||go();stop()]');
            });

            it('should encode classes with methods with arguments', () {
                expect(
                    (new Class()
                        ..name = 'Methods'
                        ..methods.addAll([
                            new Method()
                                ..name = 'go'
                                ..arguments.addAll([
                                    new Variable()
                                        ..name = 'length'
                                        ..type = 'int',
                                    new Variable()
                                        ..name = 'direction',
                                ]),
                            new Method()
                                ..name = 'stop'
                                ..arguments.add(
                                    new Variable()
                                        ..name = 'force'
                                        ..type = 'bool'
                                )
                        ])
                    ).toString()
                ).toEqual('[Methods||go(length:int, direction);stop(force:bool)]');
            });

            it('should encode classes with methods with a return type', () {
                expect(
                    (new Class()
                        ..name = 'Method'
                        ..methods.add(
                            new Method()
                                ..name = 'go'
                                ..returnType = 'bool'
                        )
                    ).toString()
                ).toEqual('[Method||go():bool]');
            });
        });
    });
}
