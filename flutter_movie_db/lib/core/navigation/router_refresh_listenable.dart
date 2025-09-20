import 'dart:async';

import 'package:flutter/foundation.dart';

class RouterRefreshListenable extends ChangeNotifier {
  late final StreamSubscription<dynamic> _streamSubscription;
  
  RouterRefreshListenable(Stream<dynamic> stream) {
    notifyListeners();
    _streamSubscription = stream.listen((event) {
      notifyListeners();
    });
  }

  @override
  void dispose() {
    _streamSubscription.cancel();
    super.dispose();
  }
}