import 'package:flutter/material.dart';
import 'package:kozak/shared/shared.dart';

class DonatesCardsWidget extends StatefulWidget {
  const DonatesCardsWidget({
    required this.image,
    required this.title,
    required this.subtitle,
    required this.link,
    required this.isDesk,
    super.key,
  });
  final List<String> image;
  final List<String> title;
  final List<String> subtitle;
  final List<String> link;
  final bool isDesk;

  @override
  State<DonatesCardsWidget> createState() => _DonatesCardsWidgetState();
}

class _DonatesCardsWidgetState extends State<DonatesCardsWidget> {
  late List<bool> hasSubtitles;
  @override
  void initState() {
    hasSubtitles = List.generate(widget.title.length, (index) => false);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return widget.isDesk
        ? Row(
            children: List.generate(
              widget.title.length,
              (index) {
                final changeSize =
                    hasSubtitles.indexOf(true) < hasSubtitles.length - 1
                        ? hasSubtitles.indexOf(true) + 1 == index
                        : hasSubtitles.indexOf(true) - 1 == index;
                return Expanded(
                  flex: hasSubtitles.elementAt(index) ||
                          hasSubtitles.contains(true) && !changeSize
                      ? 4
                      : 3,
                  child: MouseRegion(
                    onEnter: (event) => setState(() {
                      hasSubtitles[index] = true;
                    }),
                    onExit: (event) => setState(() {
                      hasSubtitles[index] = false;
                    }),
                    child: Padding(
                      padding: EdgeInsets.only(
                        right: widget.title.length + 1 != index
                            ? KPadding.kPaddingSize24
                            : 0,
                      ),
                      child: DonateCardWidget(
                        image: widget.image.elementAt(index),
                        title: widget.title.elementAt(index),
                        subtitle: widget.subtitle.elementAt(index),
                        hasSubtitle: hasSubtitles.elementAt(index),
                        titleStyle: hasSubtitles.contains(true) && changeSize
                            ? AppTextStyle.text24
                            : null,
                      ),
                    ),
                  ),
                );
              },
            ),
          )
        : Column(
            children: List.generate(
              widget.title.length,
              (index) => DonateCardWidget(
                image: widget.image.elementAt(index),
                title: widget.title.elementAt(index),
                subtitle: widget.subtitle.elementAt(index),
                hasSubtitle: hasSubtitles.elementAt(index),
              ),
            ),
          );
  }
}
