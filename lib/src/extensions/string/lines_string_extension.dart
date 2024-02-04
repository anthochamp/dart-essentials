// SPDX-FileCopyrightText: © 2023 - 2024 Anthony Champagne <dev@anthonychampagne.fr>
//
// SPDX-License-Identifier: BSD-3-Clause

extension LinesStringExtension on String {
  String prependLines(String prepend) {
    return '$prepend${split('\n').join('\n$prepend')}';
  }
}
