# PumpState

Fitness app to help you design your own workout, guide you through it, and track your analytics.

## Getting Started

This project is a starting point for a Flutter application.

A few resources to get you started if this is your first Flutter project:

- [Lab: Write your first Flutter app](https://docs.flutter.dev/get-started/codelab)
- [Cookbook: Useful Flutter samples](https://docs.flutter.dev/cookbook)

For help getting started with Flutter development, view the
[online documentation](https://docs.flutter.dev/), which offers tutorials,
samples, guidance on mobile development, and a full API reference.

SDK: Flutter v3.3.1 Language: Dart v2.18.0

Storage: Local

Kits: Path_Provider, UUID

### Emulate Application on Windows:

- Download and install the latest version of Android Studio
- Download the SDK components from within Android Studio
- Open plugin preferences (File > Settings > Plugins).
- Select Marketplace, select the Flutter plugin and click Install.
- Install the Dart SDK
- You may use a package manager to easily install and update a stable channel Dart SDK. 
- On Windows, an easy way to install Dart is via the package manager, Chocolately. With Chocolatey on your machine, you simply have to run:
  - ```C:\> choco install dart-sdk```
- You may also  build the SDK from source, grab a Dart Docker image, or install from any release channel by downloading the SDK as a zip file.
- Create an emulator in Android Studio
- To open the new Device Manager, do the following:
  - From the Android Studio Welcome screen, select More Actions > Virtual Device Manager.
  - After opening a project, select View > Tool Windows > Device Manager from the main menu bar.

- How to create an android device from the command line in Android Studio:
  - ```avdmanager create avd -n test -k "system-images;android-30;google_apis;x86"```
- Cloning PumpState in Android Studio from Git Repo:
  - File > New > Project from Version Control 
- In the Version control choose Git from the drop-down menu.
- Then at last paste the link in the URL and choose your Directory. Click on the Clone button and you are done.

- To update project packages:
  - In Android Studio Terminal run:
	 - ```flutter packages get```
	 - ```dart pub get```

### Emulate Application on Mac OS:

- Download and install the latest version of Android Studio
- Download the SDK components from within Android Studio
- Open plugin preferences (Preferences > Plugins as of v3.6.3.0 or later).
- Select the Flutter plugin and click Install.
- Click Yes when prompted to install the Dart plugin.
- Click Restart when prompted
- Installing the Dart SDK
 - You may use a package manager to easily install and update a stable channel Dart SDK. On Windows, an easy way to install Dart is via the package manager, Chocolately. With Chocolatey on your machine, you simply have to run:
 - ```C:\> choco install dart-sdk```
- You may also  build the SDK from source, grab a Dart Docker image, or install from any release channel by downloading the SDK as a zip file.
- Creating an iOS emulator form the command line in Mac OS:
  - Install iOS Simulator
  - iOS Simulator is a part of Xcode. As a Mac user you can download and install it for free from the App Store.
- How to launch iOS simulator from Terminal:
  - Run this command to see a list of available simulators and their UDID, then copy UDID of the device and run the next command:
  - ```$ xcrun simctl list```
  - ```$ open -a Simulator --args -CurrentDeviceUDID <your device UDID>```
- How to launch Android Emulator from Terminal:
  - To see Android SDK location run this command.
  - ```$ which adb```
- Copy the path and run the command to display a list of emulators. 
- Output should look as follows:
  - ```/Users/user_name/Library/Android/sdk/platform-tools/adb```
- To get a list of devices, change the path to the emulator.
  - ```$ /Users/<user_name>/Library/Android/sdk/tools/emulator -list-avds```
- Copy the name of the needed device and run the command
  - ```$ /Users/<user_name>/Library/Android/sdk/tools/emulator -avd <device name>```
- How to open the Emulator in Android Studio
- Click on the Tools tab -> AVD Manager or Click on the AVD Manager icon on the top icons bar.
- Use the AVD manager to create new devices, you can also manage them, and launch them directly from this manager.
- Cloning PumpState in Android Studio from Git Repo:
  - File > New > Project from Version Control 
- In the Version control choose Git from the drop-down menu.
- Then at last paste the link in the URL and choose your Directory. Click on the Clone button and you are done.
- To update project packages:
  - In Android Studio Terminal run:
	- ```flutter packages get```
	- ```dart pub get```




