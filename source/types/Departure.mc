import Toybox.Lang;

class Departure {
    var destination as String;
    var display as String;
    var scheduled as String;
    var expected as String;
    var groupOfLines as String;
    var expectedTime as Number;

    function initialize(
        destination as String,
        display as String,
        scheduled as String,
        expected as String,
        groupOfLines as String,
        expectedTime as Number
    ) {
        self.destination = destination;
        self.display = display;
        self.scheduled = scheduled;
        self.expected = expected;
        self.groupOfLines = groupOfLines;
        self.expectedTime = expectedTime;
    }

    function toString() as String {
        return (
            destination +
            " (" +
            display +
            ") [" +
            scheduled +
            " → " +
            expected +
            "] | " +
            groupOfLines
        );
    }
}
