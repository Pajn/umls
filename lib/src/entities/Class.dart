part of uml;

class Class {
    static final PATTERN = new RegExp(r'\[([^\s\]]+?(?=\||\]))((?:\|[^\|\]]*)+)?\]', caseSensitive: false);

    String name;
    List<Variable> attributes = [];
    List<Method> methods = [];

    parse(String input) {
        var match = PATTERN.firstMatch(input);

        name = match.group(1);

        if (match.group(2) != null) {
            var blocks = match.group(2).split('|');
            if (blocks.length > 1) {
                blocks[1].split(';')
                    ..removeWhere(((element) => element.isEmpty))
                    ..forEach((attribute) => attributes.add(new Variable()..parse(attribute)));
            }
            if (blocks.length > 2) {
                blocks[2].split(';')
                    ..removeWhere(((element) => element.isEmpty))
                    ..forEach((method) => methods.add(new Method()..parse(method)));
            }
        }
    }

    toJson() {
        return {
            'Class': {
                'name': name,
                'attributes': attributes.map((a) => a.toJson()).toList(),
                'methods': methods.map((a) => a.toJson()).toList(),
                //'parent': parent.toJson(),
            }
        };
    }
}
