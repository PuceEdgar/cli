// TODO: Put public facing types in this file.

/// Checks if you are awesome. Spoiler: you are.
class Awesome {
  bool get isAwesome => true;
}

class CommandRunner {
  Future<void> run(List<String> input) async {
    print('CommandRunner received args: $input');
  }
}
