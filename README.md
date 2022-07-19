# From To Time Picker

Simple interactive time range picker that enables users to pick a specific duration of the day by selecting start time and end time and defining whether it was AM or PM then it returns the duration chosen in 24H format.

![time_picker_gif](light_time_picker.gif)

![time_picker_gif](dark_time_picker.gif)
## Features

TODO: List what your package can do. Maybe include images, gifs, or videos.

## Getting started

TODO: List prerequisites and provide or point to information on how to
start using the package.


## Example

default mode
```dart

showDialog(
        context: context,
        builder: (_) => FromToTimePicker(
              onTab: (from, to) {
                print('from $from to $to');
              },
            ));

```

customized mode 
```dart
showDialog(
      context: context,
      builder: (_) => FromToTimePicker(
        onTab: (from, to) {
          print('from $from to $to');
        },
        dialogBackgroundColor: Color(0xFF121212),
        fromHeadlineColor: Colors.white,
        toHeadlineColor: Colors.white,
        upIconColor: Colors.white,
        downIconColor: Colors.white,
        timeBoxColor: Color(0xFF1E1E1E),
        timeHintColor: Colors.grey,
        timeTextColor: Colors.white,
        dividerColor: Color(0xFF121212),
        doneTextColor: Colors.white,
        dismissTextColor: Colors.white,
        defaultDayNightColor: Color(0xFF1E1E1E),
        defaultDayNightTextColor: Colors.white,
        colonColor: Colors.white,
        showHeaderBullet: true,
        headerText: 'Time available from 01:00 AM to 11:00 PM',
      ),
    );
```


## Usage

TODO: Include short and useful examples for package users. Add longer examples
to `/example` folder. 

```dart
const like = 'sample';
```

## Additional information

TODO: Tell users more about the package: where to find more information, how to 
contribute to the package, how to file issues, what response they can expect 
from the package authors, and more.
