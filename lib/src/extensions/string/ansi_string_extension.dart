// SPDX-FileCopyrightText: © 2023 - 2024 Anthony Champagne <dev@anthonychampagne.fr>
//
// SPDX-License-Identifier: BSD-3-Clause

extension AnsiStringExtension on String {
  /// Remove ANSI characters from a string
  String removeAnsiChars() =>
      replaceAll(RegExp(r'(\x9B|\x1B\[)[0-?]*[ -\/]*[@-~]'), '');
}
