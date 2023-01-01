# Sflashy UI

This is a suite of **Flutter Widgets** for specific sflashy effects.


- [Components](#components)
    -  [TextRoller](#textroller)

## Components

# TextRoller

![Alt text](https://github.com/doc-code-hub/sflashy_ui/blob/main/example/assets/TextRoller%20-%20Example.gif?raw=true)

*Example:*

```dart
TextRoller(
    strings: [
        'First',
        'Second',
        'Third',
        'Fourth',
    ],
    waitDuration: Duration(second: 2), // (optional) same as `wait: 2`
    transitionDuration: Duration(milliseconds: 1250) // (optional)
);
```
### Strings merge transition in an infinite loop animation


The widget shows strings in the order it receives them.

##### Params

- *`style`*: TextStyle of the Text rendered.

- *`waitDuration`*: indicates how long each string remains static before being replaced with the next.  
  `wait` can be used instead to specify seconds.

- *`transitionDuration`*: indicates how long the transition between the two strings lasts, during which the text gradually merges.  
`transition` can be used instead to specify seconds.


