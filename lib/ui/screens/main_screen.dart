import 'package:flutter/material.dart';
import 'package:flutter_game_minesweeper_app/ui/themes/colors.dart';
import 'package:flutter_game_minesweeper_app/utils/game_helper.dart';

class MainScreen extends StatefulWidget {
  const MainScreen({Key? key}) : super(key: key);

  @override
  State<MainScreen> createState() => _MainScreenState();
}

class _MainScreenState extends State<MainScreen> {
  MineSweeperGame game = MineSweeperGame();

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    game.generateMap();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColor.primaryColor,
      appBar: AppBar(
        backgroundColor: AppColor.primaryColor,
        elevation: 0,
        centerTitle: true,
        title: Text('MineSweeper'),
        actions: [
          IconButton(
            onPressed: () {},
            icon: Icon(Icons.settings_rounded),
          ),
        ],
      ),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Expanded(
                child: Container(
                  margin: EdgeInsets.symmetric(
                    horizontal: 20,
                  ),
                  padding: EdgeInsets.symmetric(
                    horizontal: 22,
                    vertical: 16,
                  ),
                  decoration: BoxDecoration(
                    color: AppColor.lightPrimaryColor,
                    borderRadius: BorderRadius.circular(8),
                  ),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Icon(
                        Icons.flag_rounded,
                        color: AppColor.accentColor,
                        size: 30,
                      ),
                      Text(
                        '10',
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 30,
                          fontWeight: FontWeight.w700,
                        ),
                      ),
                    ],
                  ),
                ),
              ),
              Expanded(
                child: Container(
                  margin: EdgeInsets.symmetric(
                    horizontal: 20,
                  ),
                  padding: EdgeInsets.symmetric(
                    horizontal: 22,
                    vertical: 16,
                  ),
                  decoration: BoxDecoration(
                    color: AppColor.lightPrimaryColor,
                    borderRadius: BorderRadius.circular(8),
                  ),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Icon(
                        Icons.access_time_rounded,
                        color: AppColor.accentColor,
                        size: 30,
                      ),
                      Text(
                        '23:59',
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 30,
                          fontWeight: FontWeight.w700,
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
          Container(
            width: double.infinity,
            height: 400,
            padding: EdgeInsets.all(20),
            child: GridView.builder(
              gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: MineSweeperGame.row,
                crossAxisSpacing: 4,
                mainAxisSpacing: 4,
              ),
              itemCount: MineSweeperGame.cells,
              itemBuilder: (BuildContext context, index) {
                Color cellColor = game.gameMap[index].reveal
                    ? AppColor.clickedCardColor
                    : AppColor.lightPrimaryColor;
                return GestureDetector(
                  onTap: game.gameOver
                      ? null
                      : () {
                          setState(() {
                            game.getClickedCell(game.gameMap[index]);
                          });
                        },
                  child: Container(
                    decoration: BoxDecoration(
                      color: cellColor,
                      borderRadius: BorderRadius.circular(6),
                    ),
                    child: Center(
                      child: Text(
                        game.gameMap[index].reveal
                            ? '${game.gameMap[index].content}'
                            : '',
                        style: TextStyle(
                          color: game.gameMap[index].reveal
                              ? '${game.gameMap[index].content}' == 'X'
                                  ? Colors.red
                                  : AppColor
                                      .letterColors[game.gameMap[index].content]
                              : Colors.transparent,
                          fontSize: 18,
                        ),
                      ),
                    ),
                  ),
                );
              },
            ),
          ),
          Text(
            game.gameOver ? 'You Lose' : '',
            style: TextStyle(
              color: Colors.white,
              fontWeight: FontWeight.w700,
              fontSize: 28,
            ),
          ),
          SizedBox(
            height: 6,
          ),
          RawMaterialButton(
            onPressed: () {
              setState(() {
                game.resetGame();
                game.gameOver = false;
              });
            },
            fillColor: AppColor.lightPrimaryColor,
            elevation: 0,
            shape: StadiumBorder(),
            padding: EdgeInsets.symmetric(
              horizontal: 64,
              vertical: 12,
            ),
            child: Text(
              'Repeat',
              style: TextStyle(
                color: Colors.white,
                fontSize: 22,
                fontWeight: FontWeight.w700,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
