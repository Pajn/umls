library association_tests;

import 'package:guinness/guinness.dart';
import 'package:uml_parser/uml_parser.dart';

main() {
    describe('ClassDiagram', () {
        it('it should parse a simple association', () {
            Association association = new Association()..parse('[Member]-[Comment]');

            expect(association.name).toBeNull();
            expect(association.from).toEqual('Member');
            expect(association.fromMultiplicity).toBeNull();
            expect(association.to).toEqual('Comment');
            expect(association.toMultiplicity).toBeNull();
        });

        it('it should parse an association with a name', () {
            Association association = new Association()..parse('[Member]-Posts-[Comment]');

            expect(association.name).toEqual('Posts');
            expect(association.from).toEqual('Member');
            expect(association.fromMultiplicity).toBeNull();
            expect(association.to).toEqual('Comment');
            expect(association.toMultiplicity).toBeNull();
        });

        it('it should parse an association with a from multiplicity', () {
            Association association = new Association()..parse('[Member]1-[Comment]');

            expect(association.name).toBeNull();
            expect(association.from).toEqual('Member');
            expect(association.fromMultiplicity).toEqual('1');
            expect(association.to).toEqual('Comment');
            expect(association.toMultiplicity).toBeNull();
        });

        it('it should parse an association with a to multiplicity', () {
            Association association = new Association()..parse('[Member]-*[Comment]');

            expect(association.name).toBeNull();
            expect(association.from).toEqual('Member');
            expect(association.fromMultiplicity).toBeNull();
            expect(association.to).toEqual('Comment');
            expect(association.toMultiplicity).toEqual('*');
        });

        it('it should parse an association with multiplicity', () {
            Association association = new Association()..parse('[Member]1-*[Comment]');

            expect(association.name).toBeNull();
            expect(association.from).toEqual('Member');
            expect(association.fromMultiplicity).toEqual('1');
            expect(association.to).toEqual('Comment');
            expect(association.toMultiplicity).toEqual('*');
        });

        it('it should parse a fully described association', () {
            Association association = new Association()..parse('[Member]1-Posts-*[Comment]');

            expect(association.name).toEqual('Posts');
            expect(association.from).toEqual('Member');
            expect(association.fromMultiplicity).toEqual('1');
            expect(association.to).toEqual('Comment');
            expect(association.toMultiplicity).toEqual('*');
        });

        describe('multiplicity', () {
            it('it should parse multiplicity with a closed interval', () {
                Association association = new Association()..parse('[Member]1..5-1..5[Comment]');

                expect(association.fromMultiplicity).toEqual('1..5');
                expect(association.toMultiplicity).toEqual('1..5');
            });

            it('it should parse multiplicity with a minimum value', () {
                Association association = new Association()..parse('[Member]1..*-1..*[Comment]');

                expect(association.fromMultiplicity).toEqual('1..*');
                expect(association.toMultiplicity).toEqual('1..*');
            });

            it('it should parse multiplicity with a maximium value', () {
                Association association = new Association()..parse('[Member]*..5-*..5[Comment]');

                expect(association.fromMultiplicity).toEqual('*..5');
                expect(association.toMultiplicity).toEqual('*..5');
            });

            it('it should parse multiplicity with a comma separated list', () {
                Association association = new Association()..parse('[Member]1,2,3,4..5,8-115,200[Comment]');

                expect(association.fromMultiplicity).toEqual('1,2,3,4..5,8');
                expect(association.toMultiplicity).toEqual('115,200');
            });
        });
    });
}
