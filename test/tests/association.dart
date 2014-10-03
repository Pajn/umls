library association_tests;

import 'package:guinness/guinness.dart';
import 'package:umls/umls.dart';

main() {
    describe('Association', () {
        describe('parse', () {
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
        });

        describe('toString', () {
            it('it should encode a simple association', () {
                expect(
                    (new Association()
                        ..from = 'Member'
                        ..to = 'Comment'
                    ).toString()
                ).toEqual('[Member]-[Comment]');
            });

            it('it should encode an association with a name', () {
                expect(
                    (new Association()
                        ..from = 'Member'
                        ..to = 'Comment'
                        ..name = 'Posts'
                    ).toString()
                ).toEqual('[Member]-Posts-[Comment]');
            });

            it('it should encode an association with a from multiplicity', () {
                expect(
                    (new Association()
                        ..from = 'Member'
                        ..to = 'Comment'
                        ..fromMultiplicity = '1'
                    ).toString()
                ).toEqual('[Member]1-[Comment]');
            });

            it('it should encode an association with a to multiplicity', () {
                expect(
                    (new Association()
                        ..from = 'Member'
                        ..to = 'Comment'
                        ..toMultiplicity = '*'
                    ).toString()
                ).toEqual('[Member]-*[Comment]');
            });

            it('it should encode an association with multiplicity', () {
                expect(
                    (new Association()
                        ..from = 'Member'
                        ..to = 'Comment'
                        ..fromMultiplicity = '1'
                        ..toMultiplicity = '*'
                    ).toString()
                ).toEqual('[Member]1-*[Comment]');
            });

            it('it should encode a fully described association', () {
                expect(
                    (new Association()
                        ..from = 'Member'
                        ..to = 'Comment'
                        ..name = 'Posts'
                        ..fromMultiplicity = '1'
                        ..toMultiplicity = '*'
                    ).toString()
                ).toEqual('[Member]1-Posts-*[Comment]');
            });
        });

        describe('multiplicity', () {
            describe('parse', () {
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

            describe('toString', () {
                it('it should encode multiplicity with a closed interval', () {
                    expect(
                        (new Association()
                            ..from = 'Member'
                            ..to = 'Comment'
                            ..fromMultiplicity = '1..5'
                            ..toMultiplicity = '1..5'
                        ).toString()
                    ).toEqual('[Member]1..5-1..5[Comment]');
                });

                it('it should encode multiplicity with a minimum value', () {
                    expect(
                        (new Association()
                            ..from = 'Member'
                            ..to = 'Comment'
                            ..fromMultiplicity = '1..*'
                            ..toMultiplicity = '1..*'
                        ).toString()
                    ).toEqual('[Member]1..*-1..*[Comment]');
                });

                it('it should encode multiplicity with a maximium value', () {
                    expect(
                        (new Association()
                            ..from = 'Member'
                            ..to = 'Comment'
                            ..fromMultiplicity = '*..5'
                            ..toMultiplicity = '*..5'
                        ).toString()
                    ).toEqual('[Member]*..5-*..5[Comment]');
                });

                it('it should encode multiplicity with a comma separated list', () {
                    expect(
                        (new Association()
                            ..from = 'Member'
                            ..to = 'Comment'
                            ..fromMultiplicity = '1,2,3,4..5,8'
                            ..toMultiplicity = '115,200'
                        ).toString()
                    ).toEqual('[Member]1,2,3,4..5,8-115,200[Comment]');
                });
            });
        });
    });
}
