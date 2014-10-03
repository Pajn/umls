part of umls;

class Association {
    static final MULTIPLICITY_PART_REGEX = r'(?:(?:\d+)|\*)(?:\.\.(?:(?:\d+)|\*))?';
    static final MULTIPLICITY_REGEX =
        '(' + MULTIPLICITY_PART_REGEX + r'?(?:,\s?' + MULTIPLICITY_PART_REGEX + ')*)?';
    static final PATTERN = new RegExp(
        Class.PATTERN.pattern + MULTIPLICITY_REGEX +
        r'-(?:(\w+)-)?' +
        MULTIPLICITY_REGEX + Class.PATTERN.pattern,
        caseSensitive: false);

    String name;
    String from;
    String fromMultiplicity;
    String to;
    String toMultiplicity;

    parse(String input) {
        var match = PATTERN.firstMatch(input);

        name = match.group(4);
        from = match.group(1);
        fromMultiplicity = match.group(3);
        to = match.group(6);
        toMultiplicity = match.group(5);
    }

    toJson() {
        return {
            'Association': {
                'name': name,
                'from': from,
                'fromMultiplicity': fromMultiplicity,
                'to': to,
                'toMultiplicity': toMultiplicity,
            }
        };
    }

    String toString() {
        var output = new StringBuffer();
        output.writeAll(['[', from, ']']);

        if (fromMultiplicity != null) {
            output.write(fromMultiplicity);
        }

        output.write('-');

        if (name != null) {
            output.write(name);
            output.write('-');
        }

        if (toMultiplicity != null) {
            output.write(toMultiplicity);
        }

        output.writeAll(['[', to, ']']);

        return output.toString();
    }
}
