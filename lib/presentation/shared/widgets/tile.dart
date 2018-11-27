import 'package:flutter/material.dart';
import 'package:tasking/domain/entity/todo_entity.dart';
import 'package:tasking/presentation/colorful_app.dart';
import 'package:tasking/presentation/shared/widgets/todo_avatar.dart';

class TodoTile extends StatelessWidget {
  final TodoEntity todo;
  final VoidCallback onTileTap;
  final VoidCallback onFavoriteTap;

  const TodoTile({
    Key key,
    @required this.todo,
    @required this.onTileTap,
    this.onFavoriteTap,
  })  : assert(todo != null),
        assert(onTileTap != null),
        super(key: key);

  @override
  Widget build(BuildContext context) {
    final children = [
      const SizedBox(width: 12.0),
      TodoAvatar(text: todo.name),
      const SizedBox(width: 8.0),
      Expanded(
        child: Text(
          todo.name,
          maxLines: 1,
          overflow: TextOverflow.ellipsis,
        ),
      ),
    ];

    if (onFavoriteTap != null) {
      children.addAll([
        const SizedBox(width: 8.0),
        _Favorite(
          initialState: todo.isFavorite,
          onTap: onFavoriteTap,
        ),
        const SizedBox(width: 8.0),
      ]);
    } else {
      children.add(const SizedBox(width: 12.0));
    }

    return GestureDetector(
      onTap: onTileTap,
      behavior: HitTestBehavior.opaque,
      child: Padding(
        padding: const EdgeInsets.symmetric(vertical: 8.0),
        child: Row(children: children),
      ),
    );
  }
}

class _Favorite extends StatefulWidget {
  final bool initialState;
  final VoidCallback onTap;

  _Favorite({
    Key key,
    this.initialState = false,
    @required this.onTap,
  })  : assert(onTap != null),
        super(key: key);

  @override
  _FavoriteState createState() => _FavoriteState();
}

class _FavoriteState extends State<_Favorite> {
  bool _isActive;

  @override
  void initState() {
    super.initState();
    _isActive = widget.initialState;
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      behavior: HitTestBehavior.opaque,
      onTap: () {
        setState(() {
          _isActive = !_isActive;
        });

        widget.onTap();
      },
      child: Container(
        // Tap area
        padding: const EdgeInsets.all(4.0),
        child: AnimatedCrossFade(
          firstChild: _buildIcon(Icons.star_border),
          secondChild: _buildIcon(Icons.star),
          duration: const Duration(milliseconds: 250),
          crossFadeState: _isActive ? CrossFadeState.showSecond : CrossFadeState.showFirst,
        ),
      ),
    );
  }

  Widget _buildIcon(IconData icon) {
    return Icon(
      icon,
      size: 26.0,
      // TODO
      color: _isActive ? ColorfulApp.of(context).colors.dark : ColorfulApp.of(context).colors.medium,
    );
  }
}
