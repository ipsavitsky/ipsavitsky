{ ... }:
{
  programs.plasma = {
    enable = true;
    overrideConfig = true;
    shortcuts = {

      "ActivityManager"."switch-to-activity-11642569-2617-4d7e-8bd1-397bc877aa3e" = [ ];

      "KDE Keyboard Layout Switcher" = {
        "Switch to Last-Used Keyboard Layout" = "Meta+Alt+L";
        "Switch to Next Keyboard Layout" = "Meta+Alt+K";
      };

      "kaccess"."Toggle Screen Reader On and Off" = "Meta+Alt+S";

      "kcm_touchpad" = {
        "Disable Touchpad" = "Touchpad Off";
        "Enable Touchpad" = "Touchpad On";
        "Toggle Touchpad" = [
          "Touchpad Toggle"
          "Meta+Ctrl+Zenkaku Hankaku,Touchpad Toggle"
          "Meta+Ctrl+Zenkaku Hankaku"
        ];
      };

      "kmix" = {
        "decrease_microphone_volume" = "Microphone Volume Down";
        "decrease_volume" = "Volume Down";
        "decrease_volume_small" = "Shift+Volume Down";
        "increase_microphone_volume" = "Microphone Volume Up";
        "increase_volume" = "Volume Up";
        "increase_volume_small" = "Shift+Volume Up";
        "mic_mute" = [
          "Microphone Mute"
          "Meta+Volume Mute,Microphone Mute"
          "Meta+Volume Mute,Mute Microphone"
        ];
        "mute" = "Volume Mute";
      };

      "ksmserver" = {
        "Halt Without Confirmation" = "none,,Shut Down Without Confirmation";
        "Lock Session" = [
          "Meta+L"
          "Screensaver,Meta+L"
          "Screensaver,Lock Session"
        ];
        "Log Out" = "Ctrl+Alt+Del";
        "Log Out Without Confirmation" = "none,,Log Out Without Confirmation";
        "LogOut" = "none,,Log Out";
        "Reboot" = "none,,Reboot";
        "Reboot Without Confirmation" = "none,,Reboot Without Confirmation";
        "Shut Down" = "none,,Shut Down";
      };

      "kwin" = {
        "Activate Window Demanding Attention" = "Meta+Ctrl+A";
        "Cycle Overview" = [ ];
        "Cycle Overview Opposite" = [ ];
        "Decrease Opacity" = "none,,Decrease Opacity of Active Window by 5%";

        "Expose" = "Ctrl+F9";
        "ExposeAll" = [
          "Ctrl+F10"
          "Launch (C),Ctrl+F10"
          "Launch (C),Toggle Present Windows (All desktops)"
        ];
        "ExposeClass" = "Ctrl+F7";
        "ExposeClassCurrentDesktop" = [ ];
        "Grid View" = "Meta+G";
        "Increase Opacity" = "none,,Increase Opacity of Active Window by 5%";
        "Kill Window" = "Meta+Ctrl+Esc";
        "Move Tablet to Next Output" = [ ];
        "MoveMouseToCenter" = "Meta+F6";
        "MoveMouseToFocus" = "Meta+F5";
        "MoveZoomDown" = [ ];
        "MoveZoomLeft" = [ ];
        "MoveZoomRight" = [ ];
        "MoveZoomUp" = [ ];
        "Overview" = "Meta+W";
        "Setup Window Shortcut" = "none,,Setup Window Shortcut";
        "Show Desktop" = "Meta+D";
        "Switch One Desktop Down" = "Meta+Ctrl+Down";
        "Switch One Desktop Up" = "Meta+Ctrl+Up";
        "Switch One Desktop to the Left" = "Meta+Ctrl+Left";
        "Switch One Desktop to the Right" = "Meta+Ctrl+Right";
        "Switch Window Down" = "Meta+Alt+Down";
        "Switch Window Left" = "Meta+Alt+Left";
        "Switch Window Right" = "Meta+Alt+Right";
        "Switch Window Up" = "Meta+Alt+Up";
        "Switch to Desktop 1" = "Ctrl+F1";
        "Switch to Desktop 10" = "none,,Switch to Desktop 10";
        "Switch to Desktop 11" = "none,,Switch to Desktop 11";
        "Switch to Desktop 12" = "none,,Switch to Desktop 12";
        "Switch to Desktop 13" = "none,,Switch to Desktop 13";
        "Switch to Desktop 14" = "none,,Switch to Desktop 14";
        "Switch to Desktop 15" = "none,,Switch to Desktop 15";
        "Switch to Desktop 16" = "none,,Switch to Desktop 16";
        "Switch to Desktop 17" = "none,,Switch to Desktop 17";
        "Switch to Desktop 18" = "none,,Switch to Desktop 18";
        "Switch to Desktop 19" = "none,,Switch to Desktop 19";
        "Switch to Desktop 2" = "Ctrl+F2";
        "Switch to Desktop 20" = "none,,Switch to Desktop 20";
        "Switch to Desktop 3" = "Ctrl+F3";
        "Switch to Desktop 4" = "Ctrl+F4";
        "Switch to Desktop 5" = "none,,Switch to Desktop 5";
        "Switch to Desktop 6" = "none,,Switch to Desktop 6";
        "Switch to Desktop 7" = "none,,Switch to Desktop 7";
        "Switch to Desktop 8" = "none,,Switch to Desktop 8";
        "Switch to Desktop 9" = "none,,Switch to Desktop 9";
        "Switch to Next Desktop" = "none,,Switch to Next Desktop";
        "Switch to Next Screen" = "none,,Switch to Next Screen";
        "Switch to Previous Desktop" = "none,,Switch to Previous Desktop";
        "Switch to Previous Screen" = "none,,Switch to Previous Screen";
        "Switch to Screen 0" = "none,,Switch to Screen 0";
        "Switch to Screen 1" = "none,,Switch to Screen 1";
        "Switch to Screen 2" = "none,,Switch to Screen 2";
        "Switch to Screen 3" = "none,,Switch to Screen 3";
        "Switch to Screen 4" = "none,,Switch to Screen 4";
        "Switch to Screen 5" = "none,,Switch to Screen 5";
        "Switch to Screen 6" = "none,,Switch to Screen 6";
        "Switch to Screen 7" = "none,,Switch to Screen 7";
        "Switch to Screen Above" = "none,,Switch to Screen Above";
        "Switch to Screen Below" = "none,,Switch to Screen Below";
        "Switch to Screen to the Left" = "none,,Switch to Screen to the Left";
        "Switch to Screen to the Right" = "none,,Switch to Screen to the Right";
        "Toggle Night Color" = [ ];
        "Toggle Window Raise/Lower" = "none,,Toggle Window Raise/Lower";
        "Walk Through Windows" = "Alt+Tab";
        "Walk Through Windows (Reverse)" = "Alt+Shift+Tab";
        "Walk Through Windows Alternative" = "none,,Walk Through Windows Alternative";
        "Walk Through Windows Alternative (Reverse)" = "none,,Walk Through Windows Alternative (Reverse)";
        "Walk Through Windows of Current Application" = "Alt+`";
        "Walk Through Windows of Current Application (Reverse)" = "Alt+~";
        "Walk Through Windows of Current Application Alternative" = "none,,Walk Through Windows of Current Application Alternative";
        "Walk Through Windows of Current Application Alternative (Reverse)" = "none,,Walk Through Windows of Current Application Alternative (Reverse)";
        "Window Above Other Windows" = "none,,Keep Window Above Others";
        "Window Below Other Windows" = "none,,Keep Window Below Others";
        "Window Close" = "Alt+F4";
        "Window Fullscreen" = "none,,Make Window Fullscreen";
        "Window Grow Horizontal" = "none,,Expand Window Horizontally";
        "Window Grow Vertical" = "none,,Expand Window Vertically";
        "Window Lower" = "none,,Lower Window";
        "Window Maximize" = "Meta+PgUp";
        "Window Maximize Horizontal" = "none,,Maximise Window Horizontally";
        "Window Maximize Vertical" = "none,,Maximise Window Vertically";
        "Window Minimize" = "Meta+PgDown";
        "Window Move" = "none,,Move Window";
        "Window Move Center" = "none,,Move Window to the Centre";
        "Window No Border" = "none,,Toggle Window Titlebar and Frame";
        "Window On All Desktops" = "none,,Keep Window on All Desktops";
        "Window One Desktop Down" = "Meta+Ctrl+Shift+Down";
        "Window One Desktop Up" = "Meta+Ctrl+Shift+Up";
        "Window One Desktop to the Left" = "Meta+Ctrl+Shift+Left";
        "Window One Desktop to the Right" = "Meta+Ctrl+Shift+Right";
        "Window One Screen Down" = "none,,Move Window One Screen Down";
        "Window One Screen Up" = "none,,Move Window One Screen Up";
        "Window One Screen to the Left" = "none,,Move Window One Screen to the Left";
        "Window One Screen to the Right" = "none,,Move Window One Screen to the Right";
        "Window Operations Menu" = "Alt+F3";
        "Window Pack Down" = "none,,Move Window Down";
        "Window Pack Left" = "none,,Move Window Left";
        "Window Pack Right" = "none,,Move Window Right";
        "Window Pack Up" = "none,,Move Window Up";
        "Window Quick Tile Bottom" = "Meta+Down";
        "Window Quick Tile Bottom Left" = "none,,Quick Tile Window to the Bottom Left";
        "Window Quick Tile Bottom Right" = "none,,Quick Tile Window to the Bottom Right";
        "Window Quick Tile Left" = "Meta+Left";
        "Window Quick Tile Right" = "Meta+Right";
        "Window Quick Tile Top" = "Meta+Up";
        "Window Quick Tile Top Left" = "none,,Quick Tile Window to the Top Left";
        "Window Quick Tile Top Right" = "none,,Quick Tile Window to the Top Right";
        "Window Raise" = "none,,Raise Window";
        "Window Resize" = "none,,Resize Window";
        "Window Shade" = "none,,Shade Window";
        "Window Shrink Horizontal" = "none,,Shrink Window Horizontally";
        "Window Shrink Vertical" = "none,,Shrink Window Vertically";
        "Window to Desktop 1" = "none,,Window to Desktop 1";
        "Window to Desktop 10" = "none,,Window to Desktop 10";
        "Window to Desktop 11" = "none,,Window to Desktop 11";
        "Window to Desktop 12" = "none,,Window to Desktop 12";
        "Window to Desktop 13" = "none,,Window to Desktop 13";
        "Window to Desktop 14" = "none,,Window to Desktop 14";
        "Window to Desktop 15" = "none,,Window to Desktop 15";
        "Window to Desktop 16" = "none,,Window to Desktop 16";
        "Window to Desktop 17" = "none,,Window to Desktop 17";
        "Window to Desktop 18" = "none,,Window to Desktop 18";
        "Window to Desktop 19" = "none,,Window to Desktop 19";
        "Window to Desktop 2" = "none,,Window to Desktop 2";
        "Window to Desktop 20" = "none,,Window to Desktop 20";
        "Window to Desktop 3" = "none,,Window to Desktop 3";
        "Window to Desktop 4" = "none,,Window to Desktop 4";
        "Window to Desktop 5" = "none,,Window to Desktop 5";
        "Window to Desktop 6" = "none,,Window to Desktop 6";
        "Window to Desktop 7" = "none,,Window to Desktop 7";
        "Window to Desktop 8" = "none,,Window to Desktop 8";
        "Window to Desktop 9" = "none,,Window to Desktop 9";
        "Window to Next Desktop" = "none,,Window to Next Desktop";
        "Window to Next Screen" = "Meta+Shift+Right";
        "Window to Previous Desktop" = "none,,Window to Previous Desktop";
        "Window to Previous Screen" = "Meta+Shift+Left";
        "Window to Screen 0" = "none,,Move Window to Screen 0";
        "Window to Screen 1" = "none,,Move Window to Screen 1";
        "Window to Screen 2" = "none,,Move Window to Screen 2";
        "Window to Screen 3" = "none,,Move Window to Screen 3";
        "Window to Screen 4" = "none,,Move Window to Screen 4";
        "Window to Screen 5" = "none,,Move Window to Screen 5";
        "Window to Screen 6" = "none,,Move Window to Screen 6";
        "Window to Screen 7" = "none,,Move Window to Screen 7";
        "view_actual_size" = "Meta+0";
        "view_zoom_in" = [
          "Meta++"
          "Meta+=,Meta++"
          "Meta+=,Zoom In"
        ];
        "view_zoom_out" = "Meta+-";
      };

      "mediacontrol" = {
        "mediavolumedown" = "none,,Media volume down";
        "mediavolumeup" = "none,,Media volume up";
        "nextmedia" = "Media Next";
        "pausemedia" = "Media Pause";
        "playmedia" = "none,,Play media playback";
        "playpausemedia" = "Media Play";
        "previousmedia" = "Media Previous";
        "stopmedia" = "Media Stop";
      };

      "org_kde_powerdevil" = {
        "Decrease Keyboard Brightness" = "Keyboard Brightness Down";
        "Decrease Screen Brightness" = "Monitor Brightness Down";
        "Decrease Screen Brightness Small" = "Shift+Monitor Brightness Down";
        "Hibernate" = "Hibernate";
        "Increase Keyboard Brightness" = "Keyboard Brightness Up";
        "Increase Screen Brightness" = "Monitor Brightness Up";
        "Increase Screen Brightness Small" = "Shift+Monitor Brightness Up";
        "PowerDown" = "Power Down";
        "PowerOff" = "Power Off";
        "Sleep" = "Sleep";
        "Toggle Keyboard Backlight" = "Keyboard Light On/Off";
        "Turn Off Screen" = [ ];
        "powerProfile" = [
          "Battery"
          "Meta+B,Battery"
          "Meta+B,Switch Power Profile"
        ];
      };

      "plasmashell" = {
        "activate application launcher" = [
          "Meta,Meta"
          "Alt+F1,Activate Application Launcher"
        ];
        "activate task manager entry 1" = "Meta+1";
        "activate task manager entry 10" = "none,Meta+0,Activate Task Manager Entry 10";
        "activate task manager entry 2" = "Meta+2";
        "activate task manager entry 3" = "Meta+3";
        "activate task manager entry 4" = "Meta+4";
        "activate task manager entry 5" = "Meta+5";
        "activate task manager entry 6" = "Meta+6";
        "activate task manager entry 7" = "Meta+7";
        "activate task manager entry 8" = "Meta+8";
        "activate task manager entry 9" = "Meta+9";
        "clear-history" = "none,,Clear Clipboard History";
        "clipboard_action" = "Meta+Ctrl+X";
        "cycle-panels" = "Meta+Alt+P";
        "cycleNextAction" = "none,,Next History Item";
        "cyclePrevAction" = "none,,Previous History Item";
        "manage activities" = "Meta+Q";
        "next activity" = "Meta+A,none,Walk through activities";
        "previous activity" = "Meta+Shift+A,none,Walk through activities (Reverse)";
        "repeat_action" = "none,Meta+Ctrl+R,Manually Invoke Action on Current Clipboard";
        "show dashboard" = "Ctrl+F12";
        "show-barcode" = "none,,Show Barcode…";
        "show-on-mouse-pos" = "Meta+V";
        "stop current activity" = "Meta+S";
        "switch to next activity" = "none,,Switch to Next Activity";
        "switch to previous activity" = "none,,Switch to Previous Activity";
        "toggle do not disturb" = "none,,Toggle do not disturb";
      };
    };
    configFile = {
      "baloofilerc" = {
        "General"."dbVersion" = 2;
        "General"."exclude filters" = "*~,*.part,*.o,*.la,*.lo,*.loT,*.moc,moc_*.cpp,qrc_*.cpp,ui_*.h,cmake_install.cmake,CMakeCache.txt,CTestTestfile.cmake,libtool,config.status,confdefs.h,autom4te,conftest,confstat,Makefile.am,*.gcode,.ninja_deps,.ninja_log,build.ninja,*.csproj,*.m4,*.rej,*.gmo,*.pc,*.omf,*.aux,*.tmp,*.po,*.vm*,*.nvram,*.rcore,*.swp,*.swap,lzo,litmain.sh,*.orig,.histfile.*,.xsession-errors*,*.map,*.so,*.a,*.db,*.qrc,*.ini,*.init,*.img,*.vdi,*.vbox*,vbox.log,*.qcow2,*.vmdk,*.vhd,*.vhdx,*.sql,*.sql.gz,*.ytdl,*.tfstate*,*.class,*.pyc,*.pyo,*.elc,*.qmlc,*.jsc,*.fastq,*.fq,*.gb,*.fasta,*.fna,*.gbff,*.faa,po,CVS,.svn,.git,_darcs,.bzr,.hg,CMakeFiles,CMakeTmp,CMakeTmpQmake,.moc,.obj,.pch,.uic,.npm,.yarn,.yarn-cache,__pycache__,node_modules,node_packages,nbproject,.terraform,.venv,venv,core-dumps,lost+found";
        "General"."exclude filters version" = 9;
      };

      "dolphinrc" = {
        "General"."ViewPropsTimestamp" = "2024,10,21,23,13,39.663";
        "KFileDialog Settings"."Places Icons Auto-resize" = false;
        "KFileDialog Settings"."Places Icons Static Size" = 22;
      };

      "kactivitymanagerdrc" = {
        "activities"."11642569-2617-4d7e-8bd1-397bc877aa3e" = "Default";
        "main"."currentActivity" = "11642569-2617-4d7e-8bd1-397bc877aa3e";
      };

      "katerc" = {
        "General"."Days Meta Infos" = 30;
        "General"."Save Meta Infos" = true;
        "General"."Show Full Path in Title" = false;
        "General"."Show Menu Bar" = true;
        "General"."Show Status Bar" = true;
        "General"."Show Tab Bar" = true;
        "General"."Show Url Nav Bar" = true;
        "KTextEditor Renderer"."Animate Bracket Matching" = false;
        "KTextEditor Renderer"."Auto Color Theme Selection" = true;
        "KTextEditor Renderer"."Color Theme" = "Breeze Light";
        "KTextEditor Renderer"."Line Height Multiplier" = 1;
        "KTextEditor Renderer"."Show Indentation Lines" = false;
        "KTextEditor Renderer"."Show Whole Bracket Expression" = false;
        "KTextEditor Renderer"."Text Font" = "Hack,10,-1,7,400,0,0,0,0,0,0,0,0,0,0,1";
        "KTextEditor Renderer"."Text Font Features" = "";
        "KTextEditor Renderer"."Word Wrap Marker" = false;
        "KTextEditor::Search"."Search History" = "settings";
        "filetree"."editShade" = "183,220,246";
        "filetree"."listMode" = false;
        "filetree"."middleClickToClose" = false;
        "filetree"."shadingEnabled" = true;
        "filetree"."showCloseButton" = false;
        "filetree"."showFullPathOnRoots" = false;
        "filetree"."showToolbar" = true;
        "filetree"."sortRole" = 0;
        "filetree"."viewShade" = "211,190,222";
      };

      "kded5rc"."Module-device_automounter"."autoload" = false;

      "kdeglobals" = {
        "WM" = {
          "activeBackground" = "49,54,59";
          "activeBlend" = "252,252,252";
          "activeForeground" = "252,252,252";
          "inactiveBackground" = "42,46,50";
          "inactiveBlend" = "161,169,177";
          "inactiveForeground" = "161,169,177";
        };
      };

      "kwalletrc"."Wallet"."First Use" = false;

      "kwinrc" = {
        "Desktops" = {
          "Id_1" = "d232a96c-8d17-4f72-a2dd-88f6fa3bd1d4";
          "Number" = 1;
          "Rows" = 1;
        };
        "Tiling"."padding" = 4;
        "Tiling/10bf67ee-359f-52d1-aecb-7ef06c6b456a"."tiles" = "{\"layoutDirection\":\"horizontal\",\"tiles\":[{\"width\":0.25},{\"width\":0.5},{\"width\":0.25}]}";
        "Tiling/d02c035d-eef0-5c68-aa2f-2e83d0ba08b1"."tiles" = "{\"layoutDirection\":\"horizontal\",\"tiles\":[{\"width\":0.25},{\"width\":0.5},{\"width\":0.25}]}";
        "Xwayland"."Scale" = 1.75;
      };

      "plasma-localerc"."Formats"."LANG" = "en_GB.UTF-8";

      "plasmanotifyrc"."Applications/org.telegram.desktop"."Seen" = true;

      "spectaclerc" = {
        "GuiConfig"."captureMode" = 0;
        "ImageSave"."lastImageSaveLocation" = "file:///home/ilya/Pictures/Screenshots/Screenshot_20241021_231304.png";
        "ImageSave"."translatedScreenshotsFolder" = "Screenshots";
        "VideoSave"."translatedScreencastsFolder" = "Screencasts";
      };
    };
    dataFile = {
      "kate/anonymous.katesession"."Document 0"."URL" = "file:///home/ilya/Downloads/Telegram Desktop/key.json";
      "kate/anonymous.katesession"."Kate Plugins"."cmaketoolsplugin" = false;
      "kate/anonymous.katesession"."Kate Plugins"."compilerexplorer" = false;
      "kate/anonymous.katesession"."Kate Plugins"."eslintplugin" = false;
      "kate/anonymous.katesession"."Kate Plugins"."externaltoolsplugin" = true;
      "kate/anonymous.katesession"."Kate Plugins"."formatplugin" = false;
      "kate/anonymous.katesession"."Kate Plugins"."katebacktracebrowserplugin" = false;
      "kate/anonymous.katesession"."Kate Plugins"."katebuildplugin" = false;
      "kate/anonymous.katesession"."Kate Plugins"."katecloseexceptplugin" = false;
      "kate/anonymous.katesession"."Kate Plugins"."katecolorpickerplugin" = false;
      "kate/anonymous.katesession"."Kate Plugins"."katectagsplugin" = false;
      "kate/anonymous.katesession"."Kate Plugins"."katefilebrowserplugin" = false;
      "kate/anonymous.katesession"."Kate Plugins"."katefiletreeplugin" = true;
      "kate/anonymous.katesession"."Kate Plugins"."kategdbplugin" = false;
      "kate/anonymous.katesession"."Kate Plugins"."kategitblameplugin" = false;
      "kate/anonymous.katesession"."Kate Plugins"."katekonsoleplugin" = true;
      "kate/anonymous.katesession"."Kate Plugins"."kateprojectplugin" = true;
      "kate/anonymous.katesession"."Kate Plugins"."katereplicodeplugin" = false;
      "kate/anonymous.katesession"."Kate Plugins"."katesearchplugin" = true;
      "kate/anonymous.katesession"."Kate Plugins"."katesnippetsplugin" = false;
      "kate/anonymous.katesession"."Kate Plugins"."katesqlplugin" = false;
      "kate/anonymous.katesession"."Kate Plugins"."katesymbolviewerplugin" = false;
      "kate/anonymous.katesession"."Kate Plugins"."katexmlcheckplugin" = false;
      "kate/anonymous.katesession"."Kate Plugins"."katexmltoolsplugin" = false;
      "kate/anonymous.katesession"."Kate Plugins"."keyboardmacrosplugin" = false;
      "kate/anonymous.katesession"."Kate Plugins"."ktexteditorpreviewplugin" = false;
      "kate/anonymous.katesession"."Kate Plugins"."latexcompletionplugin" = false;
      "kate/anonymous.katesession"."Kate Plugins"."lspclientplugin" = true;
      "kate/anonymous.katesession"."Kate Plugins"."openlinkplugin" = false;
      "kate/anonymous.katesession"."Kate Plugins"."rainbowparens" = false;
      "kate/anonymous.katesession"."Kate Plugins"."rbqlplugin" = false;
      "kate/anonymous.katesession"."Kate Plugins"."tabswitcherplugin" = true;
      "kate/anonymous.katesession"."Kate Plugins"."textfilterplugin" = true;
      "kate/anonymous.katesession"."MainWindow0"."Active ViewSpace" = 0;
      "kate/anonymous.katesession"."MainWindow0"."Kate-MDI-H-Splitter" = "0,2149,0";
      "kate/anonymous.katesession"."MainWindow0"."Kate-MDI-Sidebar-0-Bar-0-TvList" = "kate_private_plugin_katefiletreeplugin,kateproject,kateprojectgit,lspclient_symbol_outline";
      "kate/anonymous.katesession"."MainWindow0"."Kate-MDI-Sidebar-0-LastSize" = 200;
      "kate/anonymous.katesession"."MainWindow0"."Kate-MDI-Sidebar-0-SectSizes" = 0;
      "kate/anonymous.katesession"."MainWindow0"."Kate-MDI-Sidebar-0-Splitter" = 1053;
      "kate/anonymous.katesession"."MainWindow0"."Kate-MDI-Sidebar-1-Bar-0-TvList" = "";
      "kate/anonymous.katesession"."MainWindow0"."Kate-MDI-Sidebar-1-LastSize" = 200;
      "kate/anonymous.katesession"."MainWindow0"."Kate-MDI-Sidebar-1-SectSizes" = 0;
      "kate/anonymous.katesession"."MainWindow0"."Kate-MDI-Sidebar-1-Splitter" = 1053;
      "kate/anonymous.katesession"."MainWindow0"."Kate-MDI-Sidebar-2-Bar-0-TvList" = "";
      "kate/anonymous.katesession"."MainWindow0"."Kate-MDI-Sidebar-2-LastSize" = 200;
      "kate/anonymous.katesession"."MainWindow0"."Kate-MDI-Sidebar-2-SectSizes" = 0;
      "kate/anonymous.katesession"."MainWindow0"."Kate-MDI-Sidebar-2-Splitter" = 2149;
      "kate/anonymous.katesession"."MainWindow0"."Kate-MDI-Sidebar-3-Bar-0-TvList" = "output,diagnostics,kate_plugin_katesearch,kateprojectinfo,kate_private_plugin_katekonsoleplugin";
      "kate/anonymous.katesession"."MainWindow0"."Kate-MDI-Sidebar-3-LastSize" = 200;
      "kate/anonymous.katesession"."MainWindow0"."Kate-MDI-Sidebar-3-SectSizes" = 0;
      "kate/anonymous.katesession"."MainWindow0"."Kate-MDI-Sidebar-3-Splitter" = 1898;
      "kate/anonymous.katesession"."MainWindow0"."Kate-MDI-Sidebar-Style" = 2;
      "kate/anonymous.katesession"."MainWindow0"."Kate-MDI-Sidebar-Visible" = true;
      "kate/anonymous.katesession"."MainWindow0"."Kate-MDI-ToolView-diagnostics-Position" = 3;
      "kate/anonymous.katesession"."MainWindow0"."Kate-MDI-ToolView-diagnostics-Show-Button-In-Sidebar" =
        true;
      "kate/anonymous.katesession"."MainWindow0"."Kate-MDI-ToolView-diagnostics-Visible" = false;
      "kate/anonymous.katesession"."MainWindow0"."Kate-MDI-ToolView-kate_plugin_katesearch-Position" = 3;
      "kate/anonymous.katesession"."MainWindow0"."Kate-MDI-ToolView-kate_plugin_katesearch-Show-Button-In-Sidebar" =
        true;
      "kate/anonymous.katesession"."MainWindow0"."Kate-MDI-ToolView-kate_plugin_katesearch-Visible" =
        false;
      "kate/anonymous.katesession"."MainWindow0"."Kate-MDI-ToolView-kate_private_plugin_katefiletreeplugin-Position" =
        0;
      "kate/anonymous.katesession"."MainWindow0"."Kate-MDI-ToolView-kate_private_plugin_katefiletreeplugin-Show-Button-In-Sidebar" =
        true;
      "kate/anonymous.katesession"."MainWindow0"."Kate-MDI-ToolView-kate_private_plugin_katefiletreeplugin-Visible" =
        false;
      "kate/anonymous.katesession"."MainWindow0"."Kate-MDI-ToolView-kate_private_plugin_katekonsoleplugin-Position" =
        3;
      "kate/anonymous.katesession"."MainWindow0"."Kate-MDI-ToolView-kate_private_plugin_katekonsoleplugin-Show-Button-In-Sidebar" =
        true;
      "kate/anonymous.katesession"."MainWindow0"."Kate-MDI-ToolView-kate_private_plugin_katekonsoleplugin-Visible" =
        false;
      "kate/anonymous.katesession"."MainWindow0"."Kate-MDI-ToolView-kateproject-Position" = 0;
      "kate/anonymous.katesession"."MainWindow0"."Kate-MDI-ToolView-kateproject-Show-Button-In-Sidebar" =
        true;
      "kate/anonymous.katesession"."MainWindow0"."Kate-MDI-ToolView-kateproject-Visible" = false;
      "kate/anonymous.katesession"."MainWindow0"."Kate-MDI-ToolView-kateprojectgit-Position" = 0;
      "kate/anonymous.katesession"."MainWindow0"."Kate-MDI-ToolView-kateprojectgit-Show-Button-In-Sidebar" =
        true;
      "kate/anonymous.katesession"."MainWindow0"."Kate-MDI-ToolView-kateprojectgit-Visible" = false;
      "kate/anonymous.katesession"."MainWindow0"."Kate-MDI-ToolView-kateprojectinfo-Position" = 3;
      "kate/anonymous.katesession"."MainWindow0"."Kate-MDI-ToolView-kateprojectinfo-Show-Button-In-Sidebar" =
        true;
      "kate/anonymous.katesession"."MainWindow0"."Kate-MDI-ToolView-kateprojectinfo-Visible" = false;
      "kate/anonymous.katesession"."MainWindow0"."Kate-MDI-ToolView-lspclient_symbol_outline-Position" =
        0;
      "kate/anonymous.katesession"."MainWindow0"."Kate-MDI-ToolView-lspclient_symbol_outline-Show-Button-In-Sidebar" =
        true;
      "kate/anonymous.katesession"."MainWindow0"."Kate-MDI-ToolView-lspclient_symbol_outline-Visible" =
        false;
      "kate/anonymous.katesession"."MainWindow0"."Kate-MDI-ToolView-output-Position" = 3;
      "kate/anonymous.katesession"."MainWindow0"."Kate-MDI-ToolView-output-Show-Button-In-Sidebar" = true;
      "kate/anonymous.katesession"."MainWindow0"."Kate-MDI-ToolView-output-Visible" = false;
      "kate/anonymous.katesession"."MainWindow0"."Kate-MDI-V-Splitter" = "0,1053,0";
      "kate/anonymous.katesession"."MainWindow0"."ToolBarsMovable" = "Disabled";
      "kate/anonymous.katesession"."MainWindow0 Settings"."ToolBarsMovable" = "Disabled";
      "kate/anonymous.katesession"."MainWindow0 Settings"."WindowState" = 10;
      "kate/anonymous.katesession"."MainWindow0-Splitter 0"."Children" = "MainWindow0-ViewSpace 0";
      "kate/anonymous.katesession"."MainWindow0-Splitter 0"."Orientation" = 1;
      "kate/anonymous.katesession"."MainWindow0-Splitter 0"."Sizes" = 2149;
      "kate/anonymous.katesession"."MainWindow0-ViewSpace 0"."Active View" = 0;
      "kate/anonymous.katesession"."MainWindow0-ViewSpace 0"."Count" = 1;
      "kate/anonymous.katesession"."MainWindow0-ViewSpace 0"."Documents" = 0;
      "kate/anonymous.katesession"."MainWindow0-ViewSpace 0"."View 0" = 0;
      "kate/anonymous.katesession"."Open Documents"."Count" = 1;
      "kate/anonymous.katesession"."Open MainWindows"."Count" = 1;
      "kate/anonymous.katesession"."Plugin:kateprojectplugin:"."projects" = "";
      "kate/anonymous.katesession"."Plugin:katesearchplugin:MainWindow:0"."BinaryFiles" = false;
      "kate/anonymous.katesession"."Plugin:katesearchplugin:MainWindow:0"."CurrentExcludeFilter" = "-1";
      "kate/anonymous.katesession"."Plugin:katesearchplugin:MainWindow:0"."CurrentFilter" = "-1";
      "kate/anonymous.katesession"."Plugin:katesearchplugin:MainWindow:0"."ExcludeFilters" = "";
      "kate/anonymous.katesession"."Plugin:katesearchplugin:MainWindow:0"."ExpandSearchResults" = false;
      "kate/anonymous.katesession"."Plugin:katesearchplugin:MainWindow:0"."Filters" = "";
      "kate/anonymous.katesession"."Plugin:katesearchplugin:MainWindow:0"."FollowSymLink" = false;
      "kate/anonymous.katesession"."Plugin:katesearchplugin:MainWindow:0"."HiddenFiles" = false;
      "kate/anonymous.katesession"."Plugin:katesearchplugin:MainWindow:0"."MatchCase" = false;
      "kate/anonymous.katesession"."Plugin:katesearchplugin:MainWindow:0"."Place" = 1;
      "kate/anonymous.katesession"."Plugin:katesearchplugin:MainWindow:0"."Recursive" = true;
      "kate/anonymous.katesession"."Plugin:katesearchplugin:MainWindow:0"."Replaces" = "";
      "kate/anonymous.katesession"."Plugin:katesearchplugin:MainWindow:0"."Search" = "";
      "kate/anonymous.katesession"."Plugin:katesearchplugin:MainWindow:0"."SearchAsYouTypeAllProjects" =
        true;
      "kate/anonymous.katesession"."Plugin:katesearchplugin:MainWindow:0"."SearchAsYouTypeCurrentFile" =
        true;
      "kate/anonymous.katesession"."Plugin:katesearchplugin:MainWindow:0"."SearchAsYouTypeFolder" = true;
      "kate/anonymous.katesession"."Plugin:katesearchplugin:MainWindow:0"."SearchAsYouTypeOpenFiles" =
        true;
      "kate/anonymous.katesession"."Plugin:katesearchplugin:MainWindow:0"."SearchAsYouTypeProject" = true;
      "kate/anonymous.katesession"."Plugin:katesearchplugin:MainWindow:0"."SearchDiskFiles" = "";
      "kate/anonymous.katesession"."Plugin:katesearchplugin:MainWindow:0"."SearchDiskFiless" = "";
      "kate/anonymous.katesession"."Plugin:katesearchplugin:MainWindow:0"."SizeLimit" = 128;
      "kate/anonymous.katesession"."Plugin:katesearchplugin:MainWindow:0"."UseRegExp" = false;
    };
  };
}
