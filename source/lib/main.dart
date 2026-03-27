import 'dart:io';

import 'package:desktop_multi_window/desktop_multi_window.dart';
import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';

Future<void> main(List<String> args) async {
  WidgetsFlutterBinding.ensureInitialized();

  final WindowController windowController =
  await WindowController.fromCurrentEngine();

  if (windowController.arguments == 'console') {
    runApp(ConsoleWindowApp(windowController: windowController));
    return;
  }

  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  static const Color backgroundColor = Color(0xFF2B2D31);
  static const Color surfaceColor = Color(0xFF313338);
  static const Color surfaceAltColor = Color(0xFF383A40);
  static const Color primaryTextColor = Color(0xFFE3E5E8);
  static const Color secondaryTextColor = Color(0xFFB5BAC1);
  static const Color accentColor = Color(0xFFE05A5A);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        brightness: Brightness.dark,
        scaffoldBackgroundColor: backgroundColor,
        colorScheme: const ColorScheme.dark(
          surface: surfaceColor,
          primary: accentColor,
          secondary: secondaryTextColor,
        ),
        textTheme: const TextTheme(
          bodyLarge: TextStyle(color: primaryTextColor),
          bodyMedium: TextStyle(color: secondaryTextColor),
        ),
        checkboxTheme: CheckboxThemeData(
          fillColor: WidgetStateProperty.resolveWith((states) {
              if (states.contains(WidgetState.selected)) {
                return accentColor;
              }
              return surfaceAltColor;
          }),
          checkColor: WidgetStateProperty.all(Colors.white),
          side: const BorderSide(color: secondaryTextColor),
        ),
      ),
      home: const HomePage(),
    );
  }
}

class ConsoleWindowApp extends StatelessWidget {
  final WindowController windowController;

  const ConsoleWindowApp({
      super.key,
      required this.windowController,
  });

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: ConsoleWindow(windowController: windowController),
    );
  }
}

class ConsoleWindow extends StatefulWidget {
  final WindowController windowController;

  const ConsoleWindow({
      super.key,
      required this.windowController,
  });

  @override
  State<ConsoleWindow> createState() => _ConsoleWindowState();
}

class _ConsoleWindowState extends State<ConsoleWindow> {
  final ScrollController _scrollController = ScrollController();
  String _consoleText = '';

  @override
  void initState() {
    super.initState();

    widget.windowController.setWindowMethodHandler((call) async {
        if (call.method == 'set_logs') {
          final String logs = (call.arguments ?? '') as String;
          setState(() {
              _consoleText = logs;
          });
          _scrollToBottom();
          return null;
        }

        if (call.method == 'append_log') {
          final String message = (call.arguments ?? '') as String;
          setState(() {
              if (_consoleText.isEmpty) {
                _consoleText = message;
              } else {
                _consoleText = '$_consoleText\n$message';
              }
          });
          _scrollToBottom();
          return null;
        }

        return null;
    });
  }

  @override
  void dispose() {
    _scrollController.dispose();
    super.dispose();
  }

  void _scrollToBottom() {
    WidgetsBinding.instance.addPostFrameCallback((_) {
        if (!_scrollController.hasClients) {
          return;
        }

        _scrollController.animateTo(
          _scrollController.position.maxScrollExtent,
          duration: const Duration(milliseconds: 120),
          curve: Curves.easeOut,
        );
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFF000000),
      body: SafeArea(
        child: Container(
          width: double.infinity,
          height: double.infinity,
          color: const Color(0xFF000000),
          padding: const EdgeInsets.all(12),
          child: Scrollbar(
            controller: _scrollController,
            thumbVisibility: true,
            child: SingleChildScrollView(
              controller: _scrollController,
              child: SelectableText(
                _consoleText.isEmpty ? 'Console ready.' : _consoleText,
                style: const TextStyle(
                  color: Color(0xFFCCCCCC),
                  fontSize: 13,
                  height: 1.35,
                  fontFamily: 'monospace',
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}

enum AppView {
  selectDirectory,
  detectedDirectories,
}

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final TextEditingController _pathController = TextEditingController();
  final ScrollController _listScrollController = ScrollController();

  AppView _currentView = AppView.selectDirectory;
  bool _hideIconAfterApplying = false;
  List<String> _directoriesWithIcons = [];

  final List<String> _consoleLines = [];
  WindowController? _consoleWindowController;

  @override
  void dispose() {
    _pathController.dispose();
    _listScrollController.dispose();
    super.dispose();
  }

  Future<void> _openConsoleWindow() async {
    if (_consoleWindowController == null) {
      _consoleWindowController = await WindowController.create(
        const WindowConfiguration(
          hiddenAtLaunch: true,
          arguments: 'console',
        ),
      );

      await _consoleWindowController!.show();
    } else {
      await _consoleWindowController!.show();
    }

    await _consoleWindowController!.invokeMethod(
      'set_logs',
      _consoleLines.join('\n'),
    );
  }

  Future<void> _appendConsoleLine(String message) async {
    _consoleLines.add(message);

    if (_consoleWindowController != null) {
      try {
        await _consoleWindowController!.invokeMethod(
          'append_log',
          message,
        );
      } catch (_) {
        _consoleWindowController = null;
      }
    }
  }

  String _displayNameForPath(String path) {
    final List<String> parts = path
    .split(Platform.pathSeparator)
    .where((part) => part.isNotEmpty)
    .toList();

    if (parts.isEmpty) {
      return path;
    }

    return parts.last;
  }

  Future<void> _selectFolder() async {
    final String? selectedDirectory =
    await FilePicker.platform.getDirectoryPath();

    if (selectedDirectory != null) {
      setState(() {
          _pathController.text = selectedDirectory;
      });
    }
  }

  Future<void> _searchSelectedDirectory() async {
    final String selectedPath = _pathController.text.trim();

    if (selectedPath.isEmpty) {
      await _showErrorDialog('The selected directory does not exist!');
      return;
    }

    final Directory parentDirectory = Directory(selectedPath);

    if (!await parentDirectory.exists()) {
      await _showErrorDialog('The selected directory does not exist!');
      return;
    }

    final List<String> detectedDirectories =
    await _findDirectoriesContainingIcoFiles(parentDirectory);

    if (!mounted) {
      return;
    }

    if (detectedDirectories.isEmpty) {
      await _showErrorDialog(
        'The selected directory contains no subdirectories with icons!',
      );
      return;
    }

    await _appendConsoleLine('Searching directory...');

    for (final String directoryPath in detectedDirectories) {
      final String dirName = _displayNameForPath(directoryPath);
      await _appendConsoleLine('Found directory $dirName with icon.');
    }

    setState(() {
        _directoriesWithIcons = detectedDirectories;
        _currentView = AppView.detectedDirectories;
    });
  }

  Future<List<String>> _findDirectoriesContainingIcoFiles(
    Directory parentDirectory,
  ) async {
    final List<String> matches = [];

    await for (final FileSystemEntity entity
      in parentDirectory.list(recursive: false, followLinks: false)) {
      if (entity is! Directory) {
        continue;
      }

      bool hasIco = false;

      await for (final FileSystemEntity subEntity
        in entity.list(recursive: false, followLinks: false)) {
        if (subEntity is File &&
          subEntity.path.toLowerCase().endsWith('.ico')) {
          hasIco = true;
          break;
        }
      }

      if (hasIco) {
        matches.add(entity.path);
      }
    }

    matches.sort();
    return matches;
  }

  Future<String?> _findFirstIconFileName(Directory directory) async {
    await for (final FileSystemEntity entity
      in directory.list(recursive: false, followLinks: false)) {
      if (entity is File && entity.path.toLowerCase().endsWith('.ico')) {
        return entity.uri.pathSegments.last;
      }
    }

    return null;
  }

  Future<void> _applyIcons() async {
    int appliedCount = 0;

    for (final String directoryPath in _directoriesWithIcons) {
      final String dirName = _displayNameForPath(directoryPath);
      await _appendConsoleLine('Applying icon to $dirName...');

      final Directory directory = Directory(directoryPath);

      final String? iconFileName = await _findFirstIconFileName(directory);
      if (iconFileName == null) {
        continue;
      }

      final String iconFilePath =
      '${directory.path}${Platform.pathSeparator}$iconFileName';

      final String desktopIniPath =
      '${directory.path}${Platform.pathSeparator}desktop.ini';

      final File desktopIniFile =
      File('${directory.path}${Platform.pathSeparator}desktop.ini');

      if (await desktopIniFile.exists()) {
        try {
          await desktopIniFile.delete();
        } catch (_) {
          await _showErrorDialog(
            'Could not delete old desktop.ini! Check the permissions of the target folder.',
          );
          return;
        }
      }

      final String desktopIniContents =
      '[.ShellClassInfo]\n'
      'IconResource=.\\$iconFileName,0\n'
      '[ViewState]\n'
      'Mode=\n'
      'Vid=\n'
      'FolderType=Generic';

      try {
        await desktopIniFile.writeAsString(desktopIniContents);
        final ProcessResult result1 = await Process.run(
          'attrib',
          <String>['+H', '+S', desktopIniPath],
          runInShell: true,
        );
        if (result1.exitCode != 0) {
          await _showErrorDialog(
            'Could not hide desktop.ini! Check the permissions of the target folder.',
          );
          return;
        }
      } catch (_) {
        await _showErrorDialog(
          'Could not create desktop.ini! Check the permissions of the target folder.',
        );
        return;
      }

      if (_hideIconAfterApplying) {
        try {
          final ProcessResult result2 = await Process.run(
            'attrib',
            <String>['+H', iconFilePath],
            runInShell: true,
          );

          if (result2.exitCode != 0) {
            await _showErrorDialog(
              'Could not hide icon file! Check the permissions of the target folder.',
            );
            return;
          }
        } catch (_) {
          await _showErrorDialog(
            'Could not hide icon file! Check the permissions of the target folder.',
          );
          return;
        }
      }

      appliedCount++;
    }

    final String doneMessage = 'Applied all $appliedCount available icons!';
    await _appendConsoleLine(doneMessage);
    await _showInfoDialog(doneMessage);
  }

  Future<void> _showErrorDialog(String message) async {
    await _appendConsoleLine('Error: $message');

    if (!mounted) {
      return;
    }

    await showDialog<void>(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          backgroundColor: MyApp.surfaceColor,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(16),
          ),
          title: const Text(
            'Error',
            style: TextStyle(
              color: MyApp.primaryTextColor,
              fontWeight: FontWeight.w600,
            ),
          ),
          content: Text(
            message,
            style: const TextStyle(
              color: MyApp.primaryTextColor,
              fontSize: 14,
            ),
          ),
          actions: [
            TextButton(
              onPressed: () => Navigator.of(context).pop(),
              child: const Text(
                'OK',
                style: TextStyle(
                  color: MyApp.accentColor,
                  fontWeight: FontWeight.w600,
                ),
              ),
            ),
          ],
        );
      },
    );
  }

  Future<void> _showInfoDialog(String message) async {
    if (!mounted) {
      return;
    }

    await showDialog<void>(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          backgroundColor: MyApp.surfaceColor,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(16),
          ),
          title: const Text(
            'Done',
            style: TextStyle(
              color: MyApp.primaryTextColor,
              fontWeight: FontWeight.w600,
            ),
          ),
          content: Text(
            message,
            style: const TextStyle(
              color: MyApp.primaryTextColor,
              fontSize: 14,
            ),
          ),
          actions: [
            TextButton(
              onPressed: () => Navigator.of(context).pop(),
              child: const Text(
                'OK',
                style: TextStyle(
                  color: MyApp.accentColor,
                  fontWeight: FontWeight.w600,
                ),
              ),
            ),
          ],
        );
      },
    );
  }

  void _exitApp() {
    exit(0);
  }

  ButtonStyle _primaryButtonStyle() {
    return ElevatedButton.styleFrom(
      backgroundColor: MyApp.accentColor,
      foregroundColor: Colors.white,
      elevation: 0,
      padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 14),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(10),
      ),
    );
  }

  ButtonStyle _secondaryButtonStyle() {
    return ElevatedButton.styleFrom(
      backgroundColor: MyApp.surfaceAltColor,
      foregroundColor: MyApp.accentColor,
      elevation: 0,
      padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 14),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(10),
      ),
    );
  }

  ButtonStyle _consoleButtonStyle() {
    return ElevatedButton.styleFrom(
      backgroundColor: const Color(0xFF232428),
      foregroundColor: const Color(0xFFD7D7D7),
      elevation: 0,
      padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 10),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(8),
        side: const BorderSide(color: Color(0xFF45474E)),
      ),
    );
  }

  InputDecoration _inputDecoration() {
    return InputDecoration(
      filled: true,
      fillColor: MyApp.surfaceColor,
      hintText: 'Enter or select a directory...',
      hintStyle: const TextStyle(color: MyApp.secondaryTextColor),
      contentPadding: const EdgeInsets.symmetric(
        horizontal: 16,
        vertical: 16,
      ),
      border: OutlineInputBorder(
        borderRadius: BorderRadius.circular(12),
        borderSide: BorderSide.none,
      ),
    );
  }

  Widget _buildTopBar() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        ElevatedButton(
          onPressed: _openConsoleWindow,
          style: _consoleButtonStyle(),
          child: const Text(
            'Console',
            style: TextStyle(
              fontFamily: 'monospace',
              fontSize: 13,
            ),
          ),
        ),
        ClipRRect(
          borderRadius: BorderRadius.circular(8),
          child: Image.asset(
            'assets/images/app_logo.png',
            width: 90,
            height: 36,
            fit: BoxFit.contain,
          ),
        ),
      ],
    );
  }

  Widget _buildDirectorySelectionView() {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 32),
      child: Column(
        children: [
          const SizedBox(height: 18),
          _buildTopBar(),
          const SizedBox(height: 20),
          const Text(
            'Select the parent directory to search in:',
            textAlign: TextAlign.center,
            style: TextStyle(
              fontSize: 20,
              color: MyApp.primaryTextColor,
              fontWeight: FontWeight.w500,
            ),
          ),
          const SizedBox(height: 24),
          TextField(
            controller: _pathController,
            style: const TextStyle(
              color: MyApp.primaryTextColor,
              fontSize: 15,
            ),
            decoration: _inputDecoration(),
          ),
          const SizedBox(height: 16),
          ElevatedButton(
            onPressed: _selectFolder,
            style: _primaryButtonStyle(),
            child: const Text('Select'),
          ),
          const Spacer(),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              ElevatedButton(
                onPressed: _exitApp,
                style: _secondaryButtonStyle(),
                child: const Text('Exit'),
              ),
              ElevatedButton(
                onPressed: _searchSelectedDirectory,
                style: _primaryButtonStyle(),
                child: const Text('Search Selected'),
              ),
            ],
          ),
          const SizedBox(height: 16),

          const Text(
            'S Icon Master version 2.0, Copyright (C) 2026 Slavi Slavchev.\n'
            'S Icon Master comes with ABSOLUTELY NO WARRANTY; This is free software, '
            'and you are welcome to redistribute it under certain conditions as defined '
            'by the GPL-2.0 license included with this program.',
            textAlign: TextAlign.center,
            style: TextStyle(
              fontSize: 11,
              height: 1.4,
              color: Color(0xFF8E9297),
            ),
          ),

          const SizedBox(height: 16),
        ],
      ),
    );
  }

  Widget _buildDetectedDirectoriesView() {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 32),
      child: Column(
        children: [
          const SizedBox(height: 18),
          _buildTopBar(),
          const SizedBox(height: 10),
          const Text(
            'The following directories were detected to contain icons:',
            textAlign: TextAlign.center,
            style: TextStyle(
              fontSize: 20,
              color: MyApp.primaryTextColor,
              fontWeight: FontWeight.w500,
            ),
          ),
          const SizedBox(height: 24),
          Expanded(
            child: Container(
              decoration: BoxDecoration(
                color: MyApp.surfaceColor,
                borderRadius: BorderRadius.circular(16),
                border: Border.all(
                  color: const Color(0xFF3F4147),
                ),
              ),
              padding: const EdgeInsets.all(12),
              child: Scrollbar(
                controller: _listScrollController,
                thumbVisibility: true,
                child: ListView.separated(
                  controller: _listScrollController,
                  itemCount: _directoriesWithIcons.length,
                  separatorBuilder: (_, __) => const SizedBox(height: 10),
                  itemBuilder: (context, index) {
                    final String directoryPath = _directoriesWithIcons[index];

                    return Container(
                      decoration: BoxDecoration(
                        color: MyApp.surfaceAltColor,
                        borderRadius: BorderRadius.circular(12),
                      ),
                      padding: const EdgeInsets.symmetric(
                        horizontal: 16,
                        vertical: 14,
                      ),
                      child: Text(
                        directoryPath,
                        style: const TextStyle(
                          color: MyApp.primaryTextColor,
                          fontSize: 14,
                          height: 1.35,
                        ),
                      ),
                    );
                  },
                ),
              ),
            ),
          ),
          const SizedBox(height: 18),
          Container(
            padding: const EdgeInsets.symmetric(
              horizontal: 12,
              vertical: 4,
            ),
            decoration: BoxDecoration(
              color: MyApp.surfaceColor,
              borderRadius: BorderRadius.circular(12),
            ),
            child: CheckboxListTile(
              value: _hideIconAfterApplying,
              onChanged: (bool? value) {
                setState(() {
                    _hideIconAfterApplying = value ?? false;
                });
              },
              contentPadding: EdgeInsets.zero,
              controlAffinity: ListTileControlAffinity.leading,
              activeColor: MyApp.accentColor,
              title: const Text(
                'Hide icon file after applying',
                style: TextStyle(
                  color: MyApp.primaryTextColor,
                ),
              ),
            ),
          ),
          const SizedBox(height: 18),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              ElevatedButton(
                onPressed: _exitApp,
                style: _secondaryButtonStyle(),
                child: const Text('Exit'),
              ),
              ElevatedButton(
                onPressed: _applyIcons,
                style: _primaryButtonStyle(),
                child: const Text('Apply Icons'),
              ),
            ],
          ),
          const SizedBox(height: 24),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: AnimatedSwitcher(
        duration: const Duration(milliseconds: 180),
        child: _currentView == AppView.selectDirectory
        ? Container(
          key: const ValueKey('select-view'),
          width: double.infinity,
          height: double.infinity,
          color: MyApp.backgroundColor,
          child: _buildDirectorySelectionView(),
        )
        : Container(
          key: const ValueKey('results-view'),
          width: double.infinity,
          height: double.infinity,
          color: MyApp.backgroundColor,
          child: _buildDetectedDirectoriesView(),
        ),
      ),
    );
  }
}
