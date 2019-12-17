import 'package:intl/intl.dart';

class DateFormatter {
  DateFormatter._();

  static String formatFullWithTime(DateTime date) {
    final formatter = DateFormat('H:mm - EEEE, dd.MM.y', 'zh_CN');

    return formatter.format(date);
  }

  static String safeFormatFullWithTime(DateTime date) {
    if (date == null) {
      return '未分配';
    }

    return formatFullWithTime(date);
  }

  static String formatFull(DateTime date) {
    final formatter = DateFormat('EEEE, dd.MM.y', 'zh_CN');
    return formatter.format(date);
  }

  static String safeFormatFull(DateTime date) {
    if (date == null) {
      return '未分配';
    }

    return formatFull(date);
  }

  static String formatDays(DateTime date) {
    final today = DateTime.now();
    final resetToday = DateTime.utc(today.year, today.month, today.day);

    // 'resets' are for ensuring proper difference calculation
    final resetDate = DateTime.utc(date.year, date.month, date.day);
    final difference = resetDate.difference(resetToday);
    final days = difference.inDays;

    if (days == 0) {
      return '今天';
    }

    if (difference.isNegative) {
      // past
      final daysAbs = days.abs();
      if (daysAbs == 1) {
        return '昨天';
      }

      if (daysAbs < 7) {
        return DateFormat("$daysAbs '天前'").format(date);
      }

      if (daysAbs < 30) {
        final weeks = (daysAbs / 7).truncate();
        return _pastPlural(text: '周', value: weeks);
      }

      final months = (daysAbs / 30).truncate();
      return _pastPlural(text: '月', value: months);
    } else {
      // future
      if (days == 1) {
        return '明天';
      }

      if (days < 7) {
        return DateFormat("$days '天后'").format(date);
      }

      if (days < 30) {
        final weeks = (days / 7).truncate();
        return _futurePlural(text: '周', value: weeks);
      }

      final months = (days / 30).truncate();
      return _futurePlural(text: '月', value: months);
    }
  }

  static String safeFormatDays(DateTime date) {
    if (date == null) {
      return '';
    }

    return formatDays(date);
  }

  static String _pastPlural({String text, int value}) {
    if (value == 1) {
      return 'Last $text';
    } else {
      return '$value ${text}s ago';
    }
  }

  static String _futurePlural({String text, int value}) {
    if (value == 1) {
      return 'Next $text';
    } else {
      return 'In $value ${text}s';
    }
  }
}
