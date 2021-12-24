import 'package:flutter/material.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';
import 'package:notesapp/screens/add_update_note/add_update_note_screen.dart';
import 'package:notesapp/screens/note/note_screen.dart';
import 'package:notesapp/screens/splash/splash.dart';
import 'package:notesapp/styles.dart';
import 'package:notesapp/utils/helper.dart';
import 'package:notesapp/utils/note_colors.dart';
import 'package:notesapp/utils/note_priority.dart';
import 'package:notesapp/widgets/custom_floating_action_button.dart';
import 'package:notesapp/widgets/note_tile.dart';
import 'package:notesapp/generated/l10n.dart';

class HomeScreen extends StatefulWidget {
  static const routeName = '/';

  const HomeScreen({Key? key}) : super(key: key);

  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: appBar(),
      body: notesList(),
      floatingActionButton: addNoteButton(),
    );
  }

  PreferredSizeWidget appBar() {
    return AppBar(
      title: Text(
        S.current.appTitle,
        style: Theme.of(context).textTheme.headline5,
      ),
      centerTitle: true,
      leading: IconButton(
        splashRadius: 30,
        icon: const Icon(Icons.search),
        onPressed: () {},
      ),
      actions: [
        IconButton(
          splashRadius: 30,
          icon: const Icon(Icons.grid_view_outlined),
          onPressed: () {},
        ),
        menuButton(),
      ],
    );
  }

  Widget menuButton() {
    return SizedBox(
      width: 50,
      child: PopupMenuButton<String>(
        icon: ClipOval(
          child: Align(
            heightFactor: 1,
            widthFactor: 1,
            child: Image.asset('assets/images/profile.png'),
          ),
        ),
        onSelected: (itemSelected) {
          switch (itemSelected) {
            case '1':
              logout();
              break;
          }
        },
        itemBuilder: (context) => [
          PopupMenuItem(
            value: '1',
            child: ListTile(
              leading: const Icon(Icons.logout),
              title: Text(
                S.current.logOut,
                style: kNoteBodyText1,
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget notesList() {
    return StaggeredGridView.countBuilder(
      physics: const BouncingScrollPhysics(),
      crossAxisCount: 4,
      itemCount: 10,
      itemBuilder: (BuildContext context, int index) {
        return NoteTile(
          onPressed: () => Navigator.of(context).pushNamed(NoteDetailScreen.routeName),
          title: 'Notes App',
          description: 'Build an awesome note taking app',
          priority: NotePriority.getPriorityText(1),
          priorityColor: NotePriority.getPriorityColor(1),
          color: NoteColors.colors[1],
          date: '2021-12-23T04:59:07.389+00:00',
        );
      },
      staggeredTileBuilder: (int index) => const StaggeredTile.fit(2),
      mainAxisSpacing: 4.0,
      crossAxisSpacing: 4.0,
    );
  }

  Widget addNoteButton() {
    return CustomFloatingActionButton(
      onPressed: () {
        Navigator.of(context).pushNamed(AddUpdateNoteScreen.routeName);
      },
      tooltip: S.current.addNote,
      icon: Icons.add,
    );
  }

  void logout() {
    Helper.showAlertDialog(
      context,
      S.current.wantToLogOut,
          () {
        Navigator.of(context).pop();
        Helper.showSnackbar(
          context,
          S.current.loggedOutSuccessfully,
          Colors.green,
        );
        Navigator.of(context)
            .pushNamedAndRemoveUntil(SplashScreen.routeName, (route) => false);
      },
    );
  }
}
