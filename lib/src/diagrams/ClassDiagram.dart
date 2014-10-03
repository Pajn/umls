part of umls;

class ClassDiagram {
    List<Association> associations = [];
    List<Class> classes = [];

    parse(String input) {
        Class.PATTERN.allMatches(input).forEach((match) {
            var name = match.group(1);

            try {
                classes.singleWhere((c) => c.name == name).parse(match.group(0));
            } on StateError catch (_) {
                classes.add(new Class()..parse(match.group(0)));
            }
        });

        Association.PATTERN.allMatches(input).forEach((match) {
            associations.add(new Association()..parse(match.group(0)));
        });
    }

    toJson() {
        return {
            'ClassDiagram': {
                'associations': associations.map((a) => a.toJson()).toList(),
                'classes': classes.map((a) => a.toJson()).toList(),
            }
        };
    }
}
