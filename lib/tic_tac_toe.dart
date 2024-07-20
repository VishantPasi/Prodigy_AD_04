import 'package:flutter/material.dart';

class TicTacToe extends StatefulWidget {
  const TicTacToe({super.key});

  @override
  State<TicTacToe> createState() => _TicTacToeState();
}

class _TicTacToeState extends State<TicTacToe> {
  List<String> board = List.filled(9, '');
  String currentPlayer = '╳';
  String result = '';

  int playerXScore = 0;
  int playerOScore = 0;
  int draw = 0;

  buildBoard() {
    return AspectRatio(
      aspectRatio: 1,
      child: Padding(
        padding: const EdgeInsets.all(10.0),
        child: GridView.builder(
          physics: const NeverScrollableScrollPhysics(),
          gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: 3,
          ),
          itemCount: 9,
          itemBuilder: (context, index) {
            return GestureDetector(
              onTap: () => onGridTap(index),
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: Container(
                  decoration: BoxDecoration(
                    color: const Color.fromARGB(255, 114, 23, 167),
                    border: Border.all(),
                    borderRadius: BorderRadius.circular(10),
                  ),
                  child: Center(
                    child: Text(
                      board[index],
                      style: TextStyle(
                          fontSize: 48,
                          fontWeight: FontWeight.w900,
                          color: board[index] == '╳'
                              ? const Color.fromARGB(255, 79, 234, 255)
                              : Colors.amber),
                    ),
                  ),
                ),
              ),
            );
          },
        ),
      ),
    );
  }

  resetGame() {
    setState(() {
      board = List.filled(9, '');
      currentPlayer = '╳';
      result = '';
    });
  }

  newGame() {
    setState(() {
      board = List.filled(9, '');
      currentPlayer = '╳';
      result = '';
      playerOScore = playerXScore = draw = 0;
    });
  }

  onGridTap(int index) {
    if (board[index] == '' && result == '') {
      setState(() {
        board[index] = currentPlayer;
        if (checkWinner()) {
          if (currentPlayer == "╳") {
            playerXScore++;
            result = 'Player $currentPlayer wins!';
          } else if (currentPlayer == "〇") {
            playerOScore++;
            result = 'Player $currentPlayer wins!';
          }
          result = 'Player $currentPlayer wins!';
        } else if (!board.contains('')) {
          draw++;
          result = 'It\'s a Draw!';
        } else {
          currentPlayer = currentPlayer == '╳' ? '〇' : '╳';
        }
      });
    }
  }

  checkWinner() {
    const List<List<int>> winningCombinations = [
      [0, 1, 2],
      [3, 4, 5],
      [6, 7, 8],
      [0, 3, 6],
      [1, 4, 7],
      [2, 5, 8],
      [0, 4, 8],
      [2, 4, 6],
    ];

    for (var combo in winningCombinations) {
      if (board[combo[0]] == currentPlayer &&
          board[combo[0]] == board[combo[1]] &&
          board[combo[0]] == board[combo[2]]) {
        return true;
      }
    }
    return false;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color.fromARGB(255, 57, 0, 95),
      appBar: AppBar(
        backgroundColor: const Color.fromARGB(255, 57, 0, 95),
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                Container(
                    width: 100,
                    height: 100,
                    decoration: BoxDecoration(
                        color: const Color.fromARGB(255, 49, 222, 245),
                        borderRadius: BorderRadius.circular(10)),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                        const Text(
                          "Player ╳",
                          style: TextStyle(fontSize: 17),
                        ),
                        Text(
                          playerXScore.toString(),
                          style: const TextStyle(
                              fontSize: 25, fontWeight: FontWeight.bold),
                        ),
                      ],
                    )),
                Container(
                    width: 100,
                    height: 100,
                    decoration: BoxDecoration(
                        color: const Color.fromARGB(255, 164, 244, 255),
                        borderRadius: BorderRadius.circular(10)),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                        const Text(
                          "Draw",
                          style: TextStyle(fontSize: 17),
                        ),
                        Text(
                          draw.toString(),
                          style: const TextStyle(
                              fontSize: 25, fontWeight: FontWeight.bold),
                        ),
                      ],
                    )),
                Container(
                    width: 100,
                    height: 100,
                    decoration: BoxDecoration(
                        color: Colors.amber,
                        borderRadius: BorderRadius.circular(10)),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                        const Text(
                          "Player Ｏ",
                          style: TextStyle(fontSize: 17),
                        ),
                        Text(
                          playerOScore.toString(),
                          style: const TextStyle(
                              fontSize: 25, fontWeight: FontWeight.bold),
                        ),
                      ],
                    ))
              ],
            ),
            const SizedBox(
              height: 60,
            ),
            buildBoard(),
            const SizedBox(
              height: 10,
            ),
            Text(
              result,
              style: const TextStyle(
                  fontSize: 20,
                  color: Colors.amber,
                  fontWeight: FontWeight.bold),
            ),
            const SizedBox(
              height: 30,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                Container(
                    height: 50,
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(10),
                        color: const Color.fromARGB(255, 164, 244, 255)),
                    child: Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 8.0),
                      child: TextButton(
                        onPressed: () => newGame(),
                        child: const Text(
                          "New Game",
                          style: TextStyle(
                              fontSize: 20,
                              fontWeight: FontWeight.bold,
                              color: Colors.black),
                        ),
                      ),
                    )),
                Container(
                    height: 50,
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(10),
                        color: Colors.amber),
                    child: Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 8.0),
                      child: TextButton(
                        onPressed: () => resetGame(),
                        child: const Text(
                          "Reset Game",
                          style: TextStyle(
                              fontSize: 20,
                              fontWeight: FontWeight.bold,
                              color: Colors.black),
                        ),
                      ),
                    )),
              ],
            )
          ],
        ),
      ),
    );
  }
}
