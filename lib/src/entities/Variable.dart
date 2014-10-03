part of umls;

class Variable {
    static final PATTERN = new RegExp(r'(\S+?(?=:|\s|$))(?:\s?:\s?([a-z]+))?', caseSensitive: false);

    String name;
    String type;

    parse(String input) {
        var match = PATTERN.firstMatch(input);
        name = match.group(1);
        type = match.group(2);
    }

    toJson() {
        return {
            'Variable': {
                'name': name,
                'type': type,
            }
        };
    }
}
