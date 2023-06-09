// Copyright 2023, Anthony Champagne. All rights reserved.
// Use of this source code is governed by a BSD-style license that can be
// found in the LICENSE file.

export 'exports/platform_independant.dart'
    if (dart.library.io) 'exports/platform_native.dart'
    if (dart.library.html) 'exports/platform_web.dart';
