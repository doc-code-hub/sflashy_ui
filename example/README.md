# Examples

- [TextRoller](#textroller)

# TextRoller

![Alt text](../assets/examples/TextRoller%20-%20Example.gif)

### Strings merge transition in an infinite loop animation


The widget shows strings in the order it receives them.

`waitDuration` indicates how long each string remains static before being replaced with the next. `wait` can be used instead to specify seconds.

`transitionDuration` indicates how long the transition between the two strings lasts, during which the text gradually merges. `transition` can be used instead to specify seconds.


```dart
TextRoller(
    strings: [
        'First',
        'Second',
        'Third',
        'Fourth',
    ],
    style: SomeTextStyle(), // optional
    wait: 1, // same as waitDuration: Duration(seconds: 4)
    transition: 1, // same as transitionDuration: Duration(seconds: 4)
    /// For better time flexibility:
    // waitDuration: Duration(milliseconds: 4500)
    // transitionDuration: Duration(milliseconds: 2500)
);
```