part of uml;

class ClassDiagram {
    static final CLASS_PATTERN = new RegExp(r'\[(\S+?(?=\||\]))(?:.*?(?=\]))\]', caseSensitive: false);

    List<Class> classes = [];

    parse(String input) {
        CLASS_PATTERN.allMatches(input).forEach((match) {
            var name = match.group(1);

            try {
                classes.singleWhere((c) => c.name == name).parse(match.group(0));
            } on StateError catch (_) {
                classes.add(new Class()..parse(match.group(0)));
            }
        });
    }

    toJson() {
        return {
            'ClassDiagram': {
                'classes': classes.map((a) => a.toJson()).toList(),
            }
        };
    }
}
