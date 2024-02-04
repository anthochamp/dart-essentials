// SPDX-FileCopyrightText: © 2023 - 2024 Anthony Champagne <dev@anthonychampagne.fr>
//
// SPDX-License-Identifier: BSD-3-Clause

export 'exports/platform_independant.dart'
    if (dart.library.io) 'exports/platform_native.dart'
    if (dart.library.html) 'exports/platform_web.dart';
