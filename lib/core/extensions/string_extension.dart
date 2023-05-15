extension StringExtension on String {
  //* truncateText function to add elipsis if the string is gretteer then limit lenght
  truncateText(int limit) {
    if (length > limit) {
      return '${substring(0, limit)}...';
    }
    return this;
  }
}
