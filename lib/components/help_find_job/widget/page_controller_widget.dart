part of 'body/help_find_job_body_contact_widget.dart';

class PageViewController extends StatefulWidget {
  const PageViewController({super.key});

  @override
  State<PageViewController> createState() => _PageViewControllerState();
}

class _PageViewControllerState extends State<PageViewController> {
  int _currentPageIndex = 0;
  final bool isDesk = false;

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: <Widget>[
        AnimatedSwitcher(
          duration: const Duration(milliseconds: 200),
          switchInCurve: Curves.easeInOut,
          switchOutCurve: Curves.easeInOut,
          child: CustomPaint(
            key: ValueKey('indicator_$_currentPageIndex'),
            painter: ViewpagerIndicatorWidget(
              pageCount: 3,
              selectedPage: _currentPageIndex,
              pageTitles: [
                context.l10n.contacts,
                context.l10n.details,
                context.l10n.skills,
              ],
              isDesk: isDesk,
            ),
            child: Container(
              height: 50,
            ),
          ),
        ),
        IndexedStack(
          index: _currentPageIndex,
          children: <Widget>[
            HelpFindJobContact(onNextPressed: onNextPressed),
            HelpFindJobDetails(
              onNextPressed: onNextPressed,
              onBackPressed: onBackPressed,
            ),
            HelpFindJobWishes(
              onBackPressed: onBackPressed,
              onLeaveRequestPressed: () {},
            ),
          ],
        ),
      ],
    );
  }

  void onNextPressed() {
    if (_currentPageIndex < 2) {
      _updateCurrentPageIndex(_currentPageIndex + 1);
    }
  }

  void onBackPressed() {
    if (_currentPageIndex > 0) {
      _updateCurrentPageIndex(_currentPageIndex - 1);
    }
  }

  void _updateCurrentPageIndex(int index) {
    setState(() {
      _currentPageIndex = index;
    });
  }
}
