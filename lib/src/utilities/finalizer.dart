import 'dart:async';

Finalizer<StreamSubscription> createStreamSubscriptionFinalizer() =>
    Finalizer<StreamSubscription>(
      (streamSubscription) => streamSubscription.cancel(),
    );
