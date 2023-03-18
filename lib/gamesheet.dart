import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'dart:convert';
import 'constants.dart';

class GamePage extends StatefulWidget {
  const GamePage({super.key, required this.gameID});
  final String gameID;

  @override
  State<StatefulWidget> createState() => _GamePageState();
}

class _GamePageState extends State<GamePage> {
  final _formKey = GlobalKey<FormState>();
  List<String> players = [];
  late List<int> playerScores;
  late List<int> gameData;
  int turn = 0;
  final List<DataRow> rows = [];
  String player1Wind = "";
  String player2Wind = "";
  String player3Wind = "";
  String player4Wind = "";
  String player5Wind = "";
  String turnEnd = "draw";
  final List<String> turnEndChoices = ["draw", "self", "off discard"];
  int currentHandValue = 0;
  int currentWinner = 0;
  String currentWinnerName = "";
  int currentLoser = 0;
  String currentLoserName = "";

  @override
  void initState() {
    print("bruh3");
    super.initState();
    _loadGames();
  }

  @override
  void didUpdateWidget(GamePage oldGamePage) {
    super.didUpdateWidget(oldGamePage);

    _loadGames();
    print("bruh4");
  }

  bool _is5thPlayer(int player, int turn) {
    return players.length == 5 && fivePlayersTurns[player][turn].isEmpty;
  }

  void _updatePlayersWinds(int turn) {
    if (turn >= 16) {
      player1Wind = "";
      player2Wind = "";
      player3Wind = "";
      player4Wind = "";
      player5Wind = "";
    } else if (players.length == 5) {
      player1Wind = windChars[fivePlayersTurns[0][turn]]!;
      player2Wind = windChars[fivePlayersTurns[1][turn]]!;
      player3Wind = windChars[fivePlayersTurns[2][turn]]!;
      player4Wind = windChars[fivePlayersTurns[3][turn]]!;
      player5Wind = windChars[fivePlayersTurns[4][turn]]!;
    } else {
      player1Wind = windChars[fourPlayersTurns[0][turn]]!;
      player2Wind = windChars[fourPlayersTurns[1][turn]]!;
      player3Wind = windChars[fourPlayersTurns[2][turn]]!;
      player4Wind = windChars[fourPlayersTurns[3][turn]]!;
    }
    print("$turn, '$player1Wind' '$player2Wind' '$player3Wind' '$player4Wind' '$player5Wind'");
  }

  void _loadGames() async {
    final prefs = await SharedPreferences.getInstance();

    setState(() {
      List<String> data = prefs.getStringList(widget.gameID) ?? [];
      if (data.isNotEmpty) {
        gameData = base64Decode(data[0]);
        print("Loaded game : $gameData");
        turn = gameData.length ~/ 3;
        players = data.sublist(1);
        _updatePlayersWinds(turn);
        if (players.length == 5) {
          playerScores = [0, 0, 0, 0, 0];
        } else {
          playerScores = [0, 0, 0, 0];
        }
        _loadDataRows();
      }
    });
  }

  void _loadDataRows() {
    rows.clear();
    //           E   S  W  N
    //           P1 P2 P3 P4 P5
    rows.add(
      DataRow(
        cells: [
          const DataCell(Text("")),
          const DataCell(Text("")),
          for (String player in players)
            DataCell(
                Container(
                    alignment: Alignment.center,
                    child: Text(player, style: const TextStyle(fontWeight: FontWeight.bold)))
            ),
        ],
      ),
    );
    for (int turnToAdd = 0; turnToAdd < turn; turnToAdd++) {
      int handValue = gameData[3 * turnToAdd];
      int winner = gameData[3 * turnToAdd + 1];
      int loser = gameData[3 * turnToAdd + 2];
      _addNewRow(turnToAdd, handValue, winner, loser);
    }
  }

  void _addNewRow(int turnToAdd, int handValue, int winner, int loser) {
    List<int> delta = [];
    for (int playerNum = 1; playerNum < players.length + 1; playerNum++) {
      if (handValue == 0 || _is5thPlayer(playerNum - 1, turnToAdd)) {
        delta.add(0);
      } else if (loser == 0) {
        // self draw
        if (playerNum == winner) {
          delta.add(3 * (8 + handValue));
        } else {
          delta.add(-8 -handValue);
        }
      } else {
        // win off discard
        if (playerNum == winner) {
          delta.add(3 * 8 + handValue);
        } else if (playerNum == loser) {
          delta.add(-8 -handValue);
        } else {
          delta.add(-8);
        }
      }
    }
    for (int playerIndex = 0; playerIndex < players.length; playerIndex++) {
      playerScores[playerIndex] += delta[playerIndex];
    }
    // TURN HAND -8 -8 -18 +x
    rows.add(
      DataRow(
        cells: [
          DataCell(Container(alignment: Alignment.center, child: Text(turnNamesShort[turnToAdd]))),
          DataCell(Container(alignment: Alignment.center, child: Text(handValue.toString()))),
          for (int playerIndex = 0; playerIndex < players.length; playerIndex++)
            DataCell(Container(
                alignment: Alignment.center,
                child: Text(delta[playerIndex].toString()))
            ),
        ],
      ),
    );
    // (total)    x   x  x  x  x
    rows.add(
      DataRow(
        cells: [
          DataCell(Container(alignment: Alignment.center, child: const Text("Total"))),
          const DataCell(Text("")),
          for (int playerIndex = 0; playerIndex < players.length; playerIndex++)
            DataCell(Container(
                alignment: Alignment.center,
                child: Text(playerScores[playerIndex].toString()))
            ),
        ],
      ),
    );
  }

  Future<void> _saveTurn() async {
    final prefs = await SharedPreferences.getInstance();
    gameData += [currentHandValue, currentWinner, currentLoser];
    print("Game : $gameData");
    prefs.setStringList(widget.gameID, [base64Encode(gameData)] + players);
    turn++;
    _updatePlayersWinds(turn);
    setState(() {

    });
  }

  Future<void> _deleteLastTurn() async {
    if (turn == 0) {
      return;
    }
    final prefs = await SharedPreferences.getInstance();
    gameData = gameData.sublist(0, gameData.length - 3);
    print("Game : $gameData");
    prefs.setStringList(widget.gameID, [base64Encode(gameData)] + players);
    turn--;
    _updatePlayersWinds(turn);
    rows.removeLast();
    rows.removeLast();
    setState(() {

    });
  }

  @override
  Widget build(BuildContext context) {
    final double width = MediaQuery.of(context).size.width;
    return Scaffold(
        appBar: AppBar(
          title: Text(AppLocalizations.of(context)!.scoreSheet),
        ),
        body: SizedBox.expand(
          child: Padding(
            padding: EdgeInsets.only(bottom: MediaQuery.of(context).size.height / 8),
            child: SingleChildScrollView(
              child: DataTable(
                columnSpacing: 10.0,
                columns: <DataColumn>[
                  DataColumn(
                    label: SizedBox(
                      width: (width - 70) * 2 / 24,
                      child: const Text(''),
                    ),
                  ),
                  DataColumn(
                    label: SizedBox(
                      width: (width - 70) * 1 / 24,
                      child: const Text(''),
                    ),
                  ),
                  DataColumn(
                    label: SizedBox(
                      width: (width - 70) * 3 / 24,
                      child: Container(
                          alignment: Alignment.center,
                          child: Text(player1Wind)
                      ),
                    ),
                  ),
                  DataColumn(
                    label: SizedBox(
                      width: (width - 70) * 3 / 24,
                      child: Container(
                          alignment: Alignment.center,
                          child: Text(player2Wind)
                      ),
                    ),
                  ),
                  DataColumn(
                    label: SizedBox(
                      width: (width - 70) * 3 / 24,
                      child: Container(
                          alignment: Alignment.center,
                          child: Text(player3Wind)
                      ),
                    ),
                  ),
                  DataColumn(
                    label: SizedBox(
                      width: (width - 70) * 3 / 24,
                      child: Container(
                          alignment: Alignment.center,
                          child: Text(player4Wind)
                      ),
                    ),
                  ),
                  if (players.length == 5)
                    DataColumn(
                      label: SizedBox(
                        width: (width - 70) * 3 / 24,
                        child: Container(
                            alignment: Alignment.center,
                            child: Text(player5Wind)
                        ),
                      ),
                    ),
                ],
                rows: rows,
              ),
            ),
          ),
        ),
        bottomSheet: Padding(
          padding: const EdgeInsets.only(bottom: 20.0, left: 20.0),
          child: Visibility(
            visible: turn > 0,
            child: ElevatedButton(
              style: const ButtonStyle(backgroundColor: MaterialStatePropertyAll<Color>(Colors.red)),
              onPressed: () => _deleteLastTurn(),
              child: Text(AppLocalizations.of(context)!.deleteLastTurn),
            ),
          ),
        ),
        floatingActionButton: Visibility(
          visible: turn < 16,
          child: FloatingActionButton(
            onPressed: () {
              turnEnd = "";
              currentHandValue = 0;
              currentWinner = 0;
              currentWinnerName = "";
              currentLoser = 0;
              currentLoserName = "";
              showDialog(
                  context: context,
                  builder: (BuildContext context) {
                    return StatefulBuilder(builder: (context, StateSetter setState)
                    {
                      return AlertDialog(
                        content: Stack(
                          clipBehavior: Clip.none,
                          children: <Widget>[
                            Positioned(
                              right: -40.0,
                              top: -40.0,
                              child: InkResponse(
                                onTap: () {
                                  Navigator.of(context).pop();
                                },
                                child: const CircleAvatar(
                                  backgroundColor: Colors.red,
                                  child: Icon(Icons.close),
                                ),
                              ),
                            ),
                            Form(
                              key: _formKey,
                              child: SingleChildScrollView(
                                child: Column(
                                  mainAxisSize: MainAxisSize.min,
                                  children: <Widget>[
                                    Padding(
                                      padding: const EdgeInsets.all(1.0),
                                      child: DropdownButtonFormField<String>(
                                        onChanged: (String? value) {
                                          setState(() {
                                            turnEnd = value!;
                                          });
                                        },
                                        items: turnEndChoices.map<
                                            DropdownMenuItem<String>>((
                                            String value) {
                                          return DropdownMenuItem<String>(
                                            value: value,
                                            child: Text(value),
                                          );
                                        }).toList(),
                                        onSaved: (value) {
                                          // TODO SAVE VALUE
                                        },
                                        decoration: InputDecoration(
                                            labelText: AppLocalizations.of(context)!.turnEnd
                                        ),
                                        validator: (value) {
                                          if (value == null || value.isEmpty) {
                                            return AppLocalizations.of(context)!.required;
                                          }
                                          // TODO CHECK
                                          return null;
                                        },
                                      ),
                                    ),
                                    if (turnEnd == "self" || turnEnd == "off discard")
                                      Padding(
                                        padding: const EdgeInsets.all(1.0),
                                        child: TextFormField(
                                          keyboardType: TextInputType.number,
                                          inputFormatters: [
                                            FilteringTextInputFormatter.allow(RegExp(r'\d')),
                                            FilteringTextInputFormatter.digitsOnly
                                          ],
                                          onSaved: (value) {
                                            currentHandValue = int.parse(value!);
                                          },
                                          decoration: InputDecoration(
                                              labelText: AppLocalizations.of(context)!.handValue
                                          ),
                                          validator: (value) {
                                            if (value == null || value.isEmpty || int.parse(value) < 8) {
                                              return AppLocalizations.of(context)!.moreThanEight;
                                            }
                                            return null;
                                          },
                                        ),
                                      ),
                                    if (turnEnd == "self" || turnEnd == "off discard")
                                      Padding(
                                        padding: const EdgeInsets.all(1.0),
                                        child: DropdownButtonFormField<String>(
                                          onChanged: (String? value) {
                                            setState(() {
                                              currentWinnerName = value!;
                                              currentWinner = players.indexOf(currentWinnerName) + 1;
                                            });
                                          },
                                          items: players
                                              .where((player) => player != currentLoserName && !_is5thPlayer(players.indexOf(player), turn))
                                              .map<
                                              DropdownMenuItem<String>>((
                                              String value) {
                                            return DropdownMenuItem<String>(
                                              value: value,
                                              child: Text(value),
                                            );
                                          }).toList(),
                                          onSaved: (value) {
                                          },
                                          decoration: InputDecoration(
                                              labelText: AppLocalizations.of(context)!.winner
                                          ),
                                          validator: (value) {
                                            if (value == null || value.isEmpty) {
                                              return AppLocalizations.of(context)!.required;
                                            }
                                            return null;
                                          },
                                        ),
                                      ),
                                    if (turnEnd == "off discard" && currentWinner > 0)
                                      Padding(
                                        padding: const EdgeInsets.all(1.0),
                                        child: DropdownButtonFormField<String>(
                                          onChanged: (String? value) {
                                            setState(() {
                                              currentLoserName = value!;
                                              currentLoser = players.indexOf(currentLoserName) + 1;
                                            });
                                          },
                                          items: players
                                              .where((player) => player != currentWinnerName && !_is5thPlayer(players.indexOf(player), turn))
                                              .map<
                                              DropdownMenuItem<String>>((
                                              String value) {
                                            return DropdownMenuItem<String>(
                                              value: value,
                                              child: Text(value),
                                            );
                                          }).toList(),
                                          onSaved: (value) {
                                          },
                                          decoration: InputDecoration(
                                              labelText: AppLocalizations.of(context)!.giver
                                          ),
                                          validator: (value) {
                                            if (value == null || value.isEmpty) {
                                              return AppLocalizations.of(context)!.required;
                                            }
                                            return null;
                                          },
                                        ),
                                      ),
                                    Padding(
                                      padding: const EdgeInsets.all(8.0),
                                      child: ElevatedButton(
                                        child: Text(AppLocalizations.of(context)!.addTurn),
                                        onPressed: () {
                                          if (_formKey.currentState!.validate()) {
                                            _formKey.currentState?.save();
                                            Navigator.of(context).pop();
                                          }
                                        },
                                      ),
                                    )
                                  ],
                                ),
                              ),
                            ),
                          ],
                        ),
                      );
                    });
                  }).then((value) => setState(() {
                _addNewRow(turn, currentHandValue, currentWinner, currentLoser);
                _saveTurn();
              }));
            },
            tooltip: 'New turn',
            child: const Icon(Icons.add),
          ), // This trailing comma makes auto-formatting nicer for build methods.
        )
    );
  }

}
