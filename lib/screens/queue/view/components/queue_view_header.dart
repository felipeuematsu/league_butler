import 'package:flutter/material.dart';
import 'package:league_butler/screens/ban/ban_strings.dart';
import 'package:league_butler/screens/picks/picks_strings.dart';
import 'package:league_butler/screens/queue/queue_strings.dart';
import 'package:league_butler/screens/queue/view/components/queue_header_cell.dart';

class QueueViewHeader extends StatelessWidget {
  const QueueViewHeader({Key? key}) : super(key: key);

  static const height = 4 * QueueHeaderCell.height;
  static const minWidth = 4 * QueueHeaderCell.width;

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        const SizedBox(width: QueueHeaderCell.width),
        QueueHeaderCell(text: QueueStrings.queue.tr),
        QueueHeaderCell(text: BanStrings.bans.tr),
        QueueHeaderCell(text: PicksStrings.picks.tr),
      ],
    );
  }
}
