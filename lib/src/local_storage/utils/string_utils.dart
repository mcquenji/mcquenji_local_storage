/// String utilities for sanitizing strings.
extension SanitizeString on String {
  /// Sanitize a string to be used as a filename.
  String get sanitized {
    // Characters not allowed in Windows filenames
    final invalidWindowsChars = RegExp(r'[<>:"/\\|?*\x00-\x1F]');
    // Reserved names in Windows
    final reservedWindowsNames = [
      'CON',
      'PRN',
      'AUX',
      'NUL',
      'COM1',
      'COM2',
      'COM3',
      'COM4',
      'COM5',
      'COM6',
      'COM7',
      'COM8',
      'COM9',
      'LPT1',
      'LPT2',
      'LPT3',
      'LPT4',
      'LPT5',
      'LPT6',
      'LPT7',
      'LPT8',
      'LPT9',
    ];

    // Characters not allowed in Linux filenames
    final invalidLinuxChars = RegExp(r'[<>:"/\\|?*\x00-\x1F]');

    // Characters not allowed in macOS filenames
    final invalidMacChars = RegExp('[:]');

    // Characters not allowed in Android filenames
    final invalidAndroidChars = RegExp(r'[<>:"/\\|?*\x00-\x1F]');

    // Characters not allowed in iOS filenames (same as macOS)
    final invalidIOSChars = RegExp('[:]');

    // Replace invalid characters for each OS
    var sanitized = replaceAll(invalidWindowsChars, '_')
        .replaceAll(invalidLinuxChars, '_')
        .replaceAll(invalidMacChars, '_')
        .replaceAll(invalidAndroidChars, '_')
        .replaceAll(invalidIOSChars, '_');

    // Trim spaces and periods from the end of the filename
    sanitized = sanitized.trim().replaceAll(RegExp(r'[. ]+$'), '');

    // Check for reserved names in Windows
    if (reservedWindowsNames.contains(sanitized.toUpperCase())) {
      sanitized = '_$sanitized';
    }

    return sanitized;
  }
}
