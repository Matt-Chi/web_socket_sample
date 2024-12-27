// import 'package:english_words/english_words.dart';
// import 'package:flutter/material.dart';
//
// void main() => runApp(const MyApp());
//
// class MyApp extends StatelessWidget {
//   const MyApp({Key? key}) : super(key: key);
//
//   @override
//   Widget build(BuildContext context) {
//     return const MaterialApp(
//       title: 'Startup Name Generator',
//       home: RandomWords(),
//     );
//   }
// }
//
// class RandomWords extends StatefulWidget {
//   const RandomWords({Key? key}) : super(key: key);
//
//   @override
//   _RandomWordsState createState() => _RandomWordsState();
// }
//
// class _RandomWordsState extends State<RandomWords> {
//   final _suggestions = <WordPair>[];
//   final _biggerFont = const TextStyle(fontSize: 18.0);
//
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         title: const Text('Startup Name Generator'),
//       ),
//       body: _buildSuggestions(),
//       drawer: Drawer(
//         child: ListView(
//           children: <Widget>[
//             UserAccountsDrawerHeader(
//               accountName: Text('Matt'),
//               accountEmail: Text('userGmail@gmail.com'),
//               currentAccountPicture: Image.network(
//                   'https://www.pvcfigures.com/wp-content/uploads/2021/05/Fallout-Nendoroid-Action-Figure-Vault-Boy-10-cm-19844-150x200.jpg'),
//               decoration: BoxDecoration(color: Colors.blueAccent),
//             ),
//             ListTile(
//               leading: Icon(Icons.favorite),
//               title: Text('Item1'),
//               onTap: () {
//                 Navigator.pop(context);
//               },
//             ),
//             ListTile(
//               leading: Icon(Icons.headset),
//               title: Text('Item2'),
//               onTap: () {
//                 Navigator.pop(context);
//               },
//             ),
//             ListTile(
//               leading: Icon(Icons.star),
//               title: Text('Item3'),
//               onTap: () {
//                 Navigator.pop(context);
//               },
//             ),
//           ],
//         ),
//       ),
//     );
//   }
//
//   Widget _buildSuggestions() {
//     return ListView.builder(
//         padding: const EdgeInsets.all(16.0),
//         itemBuilder: /*1*/ (context, i) {
//           if (i.isOdd) return const Divider();
//           /*2*/
//
//           final index = i ~/ 2; /*3*/
//           if (index >= _suggestions.length) {
//             _suggestions.addAll(generateWordPairs().take(10)); /*4*/
//           }
//           return _buildRow(_suggestions[index]);
//         });
//   }
//
//   Widget _buildRow(WordPair pair) {
//     return ListTile(
//       title: Transform.rotate(
//           angle: 0.2,
//           child: Text(
//             pair.asPascalCase,
//             style: _biggerFont,
//           )),
//     );
//   }
// }
import 'package:flutter/material.dart';
import 'package:web_socket_channel/web_socket_channel.dart';

void main() => runApp(const MyApp());

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  final String _title = 'Flutter Code Sample';

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: _title,
      home: Scaffold(
        appBar: AppBar(title: Text(_title)),
        backgroundColor: Colors.blueGrey,
        body: const MyWidget(),
      ),
    );
  }
}

class MyWidget extends StatefulWidget {
  const MyWidget({Key? key}) : super(key: key);

  @override
  State<MyWidget> createState() => _MyWidgetState();
}

class _MyWidgetState extends State<MyWidget> {
  var ip = "192.168.0.52";
  var port = 18080;
  late WebSocketChannel channel;
  
  @override
  void initState() {
    super.initState();
    connectToSocket();
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        ElevatedButton(
          onPressed: () {
            connectToSocket();
            // channel.sink.add('Send from first device');
            channel.sink.add('Send from second device');
          },
          child: const Text('Emit Request'),
        ),
        StreamBuilder(
          stream: channel.stream,
          builder: (context, snapshot) {
            if (snapshot.hasData) {
              return Text(snapshot.data.toString());
            } else if (snapshot.hasError) {
              return Text('Error: ${snapshot.error}');
            } else {
              return const CircularProgressIndicator();
            }
          },
        ),
      ],
    );
  }

  void connectToSocket() {
    channel = WebSocketChannel.connect(
      Uri.parse('ws://$ip:$port'),
    );
  }
}
