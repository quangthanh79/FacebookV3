String toTime(int time) {
  if (time > 3600 * 24 * 30) return '${time ~/ (3600 * 24 * 30)} month ago';
  if (time > 3600 * 24) return '${time ~/ (3600 * 24)} day ago';
  if (time > 3600) return '${time ~/ 3600} hour ago';
  if (time > 60) return '${time ~/ 60} minute ago';
  if (time > 0) return '$time seconds ago';
  return 'Time error';
}
