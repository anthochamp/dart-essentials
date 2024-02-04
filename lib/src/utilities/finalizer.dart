// SPDX-FileCopyrightText: © 2023 - 2024 Anthony Champagne <dev@anthonychampagne.fr>
//
// SPDX-License-Identifier: BSD-3-Clause

import 'dart:async';

Finalizer<StreamSubscription> createStreamSubscriptionFinalizer() =>
    Finalizer<StreamSubscription>(
      (streamSubscription) => streamSubscription.cancel(),
    );
