import 'package:flutter/material.dart';
import 'package:notes_10_6/features/notes/widgets/GridViewItem.dart';
import 'package:notes_10_6/models/note.dart';
import 'package:staggered_grid_view_flutter/widgets/staggered_grid_view.dart';
import 'package:staggered_grid_view_flutter/widgets/staggered_tile.dart';

class GridviewWidget extends StatelessWidget {
  const GridviewWidget({Key? key, required this.notes}) : super(key: key);
  final List<Note> notes;
  @override
  Widget build(BuildContext context) {
    return StaggeredGridView.countBuilder(
      physics: const BouncingScrollPhysics(),
      shrinkWrap: true,
      crossAxisCount: 4,
      itemCount: notes.length,
      itemBuilder: (context, index) {
        return GridViewItem(
          note: notes[index],
        );
      },
      staggeredTileBuilder: (int index) => const StaggeredTile.fit(
        2,
      ),
      mainAxisSpacing: 1.0,
      crossAxisSpacing: 1.0,
    );
  }
}
