part of umls;

class Method {
    static final PATTERN = new RegExp(r'(\S+?(?=\())\(((?:.*?(?=,|\)),?)+)\)(?:\s?:\s?([a-z]+))?', caseSensitive: false);

    String name;
    List<Variable> arguments = [];
    String returnType;

    parse(String input) {
        var match = PATTERN.firstMatch(input);
        name = match.group(1);
        returnType = match.group(3);

        if (match.group(2) != null) {
            match.group(2).split(',')
                ..removeWhere(((element) => element.isEmpty))
                ..forEach((argument) => arguments.add(new Variable()..parse(argument)));
        }
    }

    toJson() {
        return {
            'Method': {
                'name': name,
                'arguments': arguments.map((a) => a.toJson()).toList(),
                'returnType': returnType,
            }
        };
    }
}
