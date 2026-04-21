//import 'package:cli/cli.dart' as cli;
import 'dart:io';
import 'package:http/http.dart' as http;
import 'package:command_runner/command_runner.dart';

const version = '0.0.1';
void main(List<String> arguments) async {
  var commandRunner = CommandRunner(
    onError: (Object error) {
      if (error is Error) {
        throw error;
      }
      if (error is Exception) {
        print(error);
      }
    },
  )..addCommand(HelpCommand());
  commandRunner.run(arguments);

  //var runner = CommandRunner();
  //await runner.run(arguments);
  // if (arguments.isEmpty) {
  //   print('Hello Dart!');
  // } else if (arguments.first == 'version') {
  //   print('Version: ${cli.version()}');
  // } else if (arguments.first == 'hi') {
  //   cli.sayHi();
  // } else if (arguments.first == 'wikipedia') {
  //   final inputArgs = arguments.length > 1 ? arguments.sublist(1) : null;
  //   searchWikipedia(inputArgs);
  // } else {
  //   print('Unknown arg passed!');
  // }
}

void searchWikipedia(List<String>? arguments) async {
  final String articleTitle;

  if (arguments == null || arguments.isEmpty) {
    print('Please provide an article title.');
    final inputFromStdin = stdin.readLineSync(); // Read input
    if (inputFromStdin == null || inputFromStdin.isEmpty) {
      print('No article title provided. Exiting.');
      return; // Exit the function if no valid input
    }
    articleTitle = inputFromStdin;
  } else {
    articleTitle = arguments.join(' ');
  }

  print('Looking up articles about "$articleTitle". Please wait.');
  // print('Here ya go!');
  // print('(Pretend this is an article about "$articleTitle")');

  var articleContent = await getWikiArticle(articleTitle);
  print(articleContent);
}

Future<String> getWikiArticle(String articleTitle) async {
  final url = Uri.https(
    'en.wikipedia.org',
    '/api/rest_v1/page/summary/$articleTitle',
  );

  final response = await http.get(url);

  if (response.statusCode == 200) {
    return response.body;
  }

  // Return an error message if the request failed
  return 'Error: Failed to fetch article "$articleTitle". Status code: ${response.statusCode}';
}
