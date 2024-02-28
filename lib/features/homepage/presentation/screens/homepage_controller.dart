import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'homepage_controller.g.dart';

@riverpod
class HomepageController extends _$HomepageController {
  @override
  Future<bool> build() async {
    return true;
  }

  get isList => state;

  void toggleView() {
    state = AsyncValue.data(!state.value!);
  }
}
