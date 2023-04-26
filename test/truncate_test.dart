import 'package:anthochamp_dart_essentials/src/extensions/runes/truncate_extension.dart';
import 'package:test/test.dart';

void main() {
  const datasets = [
    [
      true,
      TruncatePosition.end,
      '',
      'a',
      [
        [0, ''],
        [1, 'a'],
        [2, 'a'],
      ],
    ],
    [
      true,
      TruncatePosition.end,
      '.',
      'a',
      [
        [0, '.'],
        [1, 'a'],
        [2, 'a'],
      ],
    ],
    [
      true,
      TruncatePosition.end,
      '...',
      'a',
      [
        [0, '...'],
        [1, 'a'],
        [2, 'a'],
      ],
    ],
    [
      true,
      TruncatePosition.end,
      '',
      'ab',
      [
        [0, ''],
        [1, 'a'],
        [2, 'ab'],
      ],
    ],
    [
      true,
      TruncatePosition.end,
      '.',
      'ab',
      [
        [0, '.'],
        [1, 'a.'],
        [2, 'ab'],
      ],
    ],
    [
      true,
      TruncatePosition.end,
      '...',
      'ab',
      [
        [0, '...'],
        [1, 'a...'],
        [2, 'ab'],
      ],
    ],
    [
      true,
      TruncatePosition.start,
      '',
      'ab',
      [
        [0, ''],
        [1, 'b'],
        [2, 'ab'],
      ],
    ],
    [
      true,
      TruncatePosition.start,
      '.',
      'ab',
      [
        [0, '.'],
        [1, '.b'],
        [2, 'ab'],
      ],
    ],
    [
      true,
      TruncatePosition.start,
      '...',
      'ab',
      [
        [0, '...'],
        [1, '...b'],
        [2, 'ab'],
      ],
    ],
    [
      true,
      TruncatePosition.center,
      '',
      'abc',
      [
        [0, ''],
        [1, 'a'],
        [2, 'ac'],
      ],
    ],
    [
      true,
      TruncatePosition.center,
      '.',
      'abc',
      [
        [0, '.'],
        [1, 'a.'],
        [2, 'a.c'],
      ],
    ],
    [
      true,
      TruncatePosition.center,
      '...',
      'abc',
      [
        [0, '...'],
        [1, 'a...'],
        [2, 'a...c'],
      ],
    ],
    [
      true,
      TruncatePosition.end,
      '!',
      '0123',
      [
        [1, '0!'],
        [2, '01!'],
        [3, '012!'],
        [4, '0123'],
      ],
    ],
    [
      true,
      TruncatePosition.center,
      '!',
      '0123',
      [
        [1, '0!'],
        [2, '0!3'],
        [3, '01!3'],
        [4, '0123'],
      ],
    ],
    [
      true,
      TruncatePosition.start,
      '!',
      '0123',
      [
        [1, '!3'],
        [2, '!23'],
        [3, '!123'],
        [4, '0123'],
      ],
    ],
    [
      false,
      TruncatePosition.end,
      '!',
      'ab cd ef gh',
      [
        [0, '!'],
        [1, '!'],
        [2, 'ab!'],
        [3, 'ab!'],
        [4, 'ab!'],
        [5, 'ab cd!'],
        [6, 'ab cd!'],
        [7, 'ab cd!'],
        [8, 'ab cd ef!'],
        [9, 'ab cd ef!'],
        [10, 'ab cd ef!'],
        [11, 'ab cd ef gh'],
      ],
    ],
    [
      false,
      TruncatePosition.start,
      '!',
      'ab cd ef gh',
      [
        [0, '!'],
        [1, '!'],
        [2, '!gh'],
        [3, '!gh'],
        [4, '!gh'],
        [5, '!ef gh'],
        [6, '!ef gh'],
        [7, '!ef gh'],
        [8, '!cd ef gh'],
        [9, '!cd ef gh'],
        [10, '!cd ef gh'],
        [11, 'ab cd ef gh'],
      ],
    ],
    [
      false,
      TruncatePosition.center,
      '!',
      'ab cd ef gh',
      [
        [0, '!'],
        [1, '!'],
        [2, 'ab!'],
        [3, 'ab!'],
        [4, 'ab!gh'],
        [5, 'ab!gh'],
        [6, 'ab!gh'],
        [7, 'ab cd!gh'],
        [8, 'ab cd!gh'],
        [9, 'ab cd!gh'],
        [10, 'ab cd!gh'],
        [11, 'ab cd ef gh'],
      ],
    ],
  ];

  for (final dataset in datasets) {
    group(
        'breakWord=${dataset.first}, position=${(dataset[1] as TruncatePosition).name}, indicator="${dataset[2]}" value="${dataset[3]}"',
        () {
      for (final subset in dataset[4] as List) {
        test('maxLength=${subset[0]}', () {
          expect(
              (dataset[3] as String).truncate(
                breakWord: dataset.first as bool,
                position: dataset[1] as TruncatePosition,
                truncateIndicator: dataset[2] as String,
                maxLength: subset[0],
              ),
              equals(subset[1]),);
        });
      }
    },);
  }
}
