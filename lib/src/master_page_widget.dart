import 'package:flutter/material.dart';
import 'package:master_page/src/app_page.dart';
import 'package:master_page/src/master_page_controller.dart';

class MasterPageWidget extends StatefulWidget {
  /// Page list
  final List<AppPage> appPages;

  /// Default visible page
  final String firstPageName;

  /// Controller that can change visible page
  final MasterPageController appPageController;

  /// To use custom bottom navigation bar
  final Widget bottomNavigationBar;

  /// Bottom navigation bar type
  final BottomNavigationBarType bottomNavigationBarType;

  /// When you want confirm before main page closed you can set alert dialog.
  final AlertDialog closeConfirmAlertDialog;

  final FloatingActionButtonLocation floatingActionButtonLocation;

  final Widget floatingActionButton;

  final Color selectedItemColor;
  final Color unSelectedItemColor;

  const MasterPageWidget({
    Key key,
    @required this.appPages,
    @required this.firstPageName,
    this.appPageController,
    this.closeConfirmAlertDialog,
    this.bottomNavigationBar,
    this.bottomNavigationBarType,
    this.floatingActionButton,
    this.floatingActionButtonLocation,
    this.selectedItemColor = Colors.blue,
    this.unSelectedItemColor = Colors.black,
  })  : assert(appPages != null),
        assert(firstPageName != null),
        super(key: key);
  @override
  _MasterPageWidgetState createState() => _MasterPageWidgetState();
}

class _MasterPageWidgetState extends State<MasterPageWidget> {
  final List<AppPage> _pagesForRender = [];
  String _activePageName;

  AppPage get firstPage {
    return _pagesForRender.firstWhere((x) => x.name == widget.firstPageName, orElse: () => null) ?? _pagesForRender[0];
  }

  AppPage get activePage {
    return _pagesForRender.firstWhere((x) => x.name == _activePageName);
  }

  @override
  void initState() {
    super.initState();

    if (widget.appPageController != null) widget.appPageController.addListener(setVisible: _setVisible);

    _addFirstPage();
  }

  @override
  void dispose() {
    super.dispose();
  }

  /// First page must be added
  void _addFirstPage() {
    final String firstPageName = widget.firstPageName;

    AppPage firstPage = widget.appPages.firstWhere((x) => x.name == firstPageName, orElse: () => null);

    firstPage ??= widget.appPages.isNotEmpty ? widget.appPages[0] : null;

    if (firstPage != null) {
      _pagesForRender.add(firstPage);
      _activePageName = firstPage.name;
    } else {
      _activePageName = widget.firstPageName;
    }
  }

  /// Add or update selected page to page list
  void _updateOrAddPage(String pageName) {
    final AppPage existPage = _pagesForRender.firstWhere((x) => x.name == pageName, orElse: () => null);

    if (existPage == null) {
      final AppPage pageToAdd = widget.appPages.firstWhere((x) => x.name == pageName, orElse: () => null);

      if (pageToAdd != null) {
        _pagesForRender.add(pageToAdd);
        _activePageName = pageName;
      }
    } else {
      _activePageName = existPage.name;
    }
  }

  /// Set selected page to visible
  void _setVisible(String pageName) {
    setState(() {
      _updateOrAddPage(pageName);
    });
  }

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () async {
        final bool pop = await activePage.navigatorKey.currentState.maybePop();

        if (!pop) {
          if (activePage.name != firstPage.name) {
            _setVisible(firstPage.name);
            return false;
          } else {
            if (widget.closeConfirmAlertDialog != null) {
              await showDialog(
                  context: context,
                  builder: (context) {
                    return widget.closeConfirmAlertDialog;
                  });
            } else {
              return true;
            }
          }
        }

        return null;
      },
      child: Stack(
        children: <Widget>[
          Scaffold(
            floatingActionButtonLocation: widget.floatingActionButtonLocation,
            floatingActionButton: widget.floatingActionButton,
            bottomNavigationBar: widget.bottomNavigationBar ??
                BottomNavigationBar(
                  elevation: 16.0,
                  backgroundColor: Colors.white,
                  selectedItemColor: widget.selectedItemColor,
                  type: widget.bottomNavigationBarType ?? BottomNavigationBarType.fixed,
                  onTap: (index) async {
                    final AppPage selectedPage = widget.appPages[index];
                    _setVisible(selectedPage.name);
                  },
                  items: _buildNavigationBarItem(),
                ),
            body: Stack(
              children: _buildOffstageNavigator(),
            ),
          ),
        ],
      ),
    );
  }

  List<BottomNavigationBarItem> _buildNavigationBarItem() {
    return widget.appPages.map((appPage) {
      final Color textColor = appPage.name == _activePageName ? widget.selectedItemColor : widget.unSelectedItemColor;

      return BottomNavigationBarItem(
        icon: Icon(appPage.icon ?? Icons.star, color: textColor),
        title: Text(
          "${appPage.title}",
          style: TextStyle(color: textColor),
        ),
      );
    }).toList();
  }

  List<Widget> _buildOffstageNavigator() {
    return _pagesForRender.map((appPage) {
      final Widget page = Offstage(
        offstage: appPage.name != _activePageName,
        child: Navigator(
          key: appPage.navigatorKey,
          observers: [appPage.routeObserver],
          onGenerateRoute: (routeSettings) => appPage.route,
        ),
      );

      return page;
    }).toList();
  }
}
