import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'focusable_widget.dart';

class Sidebar extends StatefulWidget {
  @override
  State<Sidebar> createState() => _SidebarState();
}

class _SidebarState extends State<Sidebar> {
  int _selectedIndex = 0;
  bool _isFocused = false;

  final List<Map<String, dynamic>> _items = [
        {
      'title': 'Profile',
      'icon': Icons.person,
      'route': '/profile', // Hardcoded route
    },

    {
      'title': 'Home',
      'icon': Icons.home,
      'route': '/', // matches AppRoutes.home
    },
      {
      'title': 'Search',
      'icon': Icons.search,
      'route': '/search',
    },
    {
      'title': 'Library',
      'icon': Icons.library_add,
      'route': '/library',
    },
      {
      'title': 'Friends',
      'icon': Icons.people,
      'modal': 'FriendList',
    },
    {
      'title': 'Following',
      'icon': Icons.list,
      'route': '/following',
      'modal': 'FollowerPublisherList',
    },
        {
      'title': 'Account',
      'icon': Icons.settings,
      'route': '/account',
    },
    {
      'title': 'Login',
      'icon': Icons.login,
      'route': '/login',
    },
  ];

  void _handleFocusChange(bool focused) {
    setState(() {
      _isFocused = focused;
    });
  }

  void _setSelectedIndex(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return AnimatedContainer(
      duration: Duration(milliseconds: 300),
      width: _isFocused ? 200 : 70,
      color: Colors.black87,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: List.generate(_items.length, (index) {
          final item = _items[index];
          return SidebarItem(
            icon: item['icon'],
            label: item['title'],
            selected: _selectedIndex == index,
            onFocus: () {
              _handleFocusChange(true);
              _setSelectedIndex(index);
            },
            onBlur: () => _handleFocusChange(false),
            expanded: _isFocused,
            onTap: () {
              print('onTap: ${item['route']}');
              _setSelectedIndex(index);
              if (item['route'] != null) {
                Navigator.of(context).pushReplacementNamed(item['route']);
              }
            },
          );
        }),
      ),
    );
  }
}

class SidebarItem extends StatefulWidget {
  final IconData icon;
  final String label;
  final bool selected;
  final VoidCallback onFocus;
  final VoidCallback onBlur;
  final bool expanded;
  final VoidCallback? onTap;

  const SidebarItem({
    required this.icon,
    required this.label,
    required this.selected,
    required this.onFocus,
    required this.onBlur,
    required this.expanded,
    this.onTap,
  });

  @override
  State<SidebarItem> createState() => _SidebarItemState();
}

class _SidebarItemState extends State<SidebarItem> {
  bool _focused = false;

  @override
  Widget build(BuildContext context) {
    return FocusableWidget(
      onFocusChange: (focused) {
        setState(() => _focused = focused);
        if (focused) {
          widget.onFocus();
        } else {
          widget.onBlur();
        }
      },
      onSelect: widget.onTap,
      child: GestureDetector(
        onTap: widget.onTap,
        child: AnimatedContainer(
          duration: Duration(milliseconds: 200),
          margin: EdgeInsets.symmetric(vertical: 8, horizontal: 8),
          padding: EdgeInsets.symmetric(vertical: 10, horizontal: widget.expanded ? 12 : 0),
          decoration: BoxDecoration(
            color: _focused ? Colors.blue.withOpacity(0.1) : Colors.transparent,
            borderRadius: BorderRadius.circular(10),
            border: (_focused && !widget.selected)
                ? Border.all(color: Colors.white, width: 2)
                : null,
          ),
          child: Row(
            mainAxisAlignment: widget.expanded ? MainAxisAlignment.start : MainAxisAlignment.center,
            children: [
              Icon(
                widget.icon,
                color: widget.selected
                    ? (widget.expanded ? Color(0xFFA259FF) : (_focused ? Color(0xFF007AFF) : Color(0xFFA259FF)))
                    : Colors.white,
              ),
              if (widget.expanded)
                SizedBox(width: 12),
              if (widget.expanded)
                Text(
                  widget.label ?? '',
                  style: TextStyle(
                    color: widget.selected
                        ? (_focused ? Color(0xFF007AFF) : Color(  0xFFA259FF))
                        : Colors.white,
                    fontSize: 16,
                  ),
                ),
            ],
          ),
        ),
      ),
    );
  }
}
