# Asset Management

### SETUP PPC Android TC22

- android/app/build.gradle.kts
- ndkVersion = "27.0.12077973"

### Build Apk

- flutter pub get
- flutter build apk --split-per-abi
- After Build Complete :
  - /build/app/outputs/apk/release/app-armeabi-v7a-release.apk --> Device 32-Bit
  - /build/app/outputs/apk/release/app-arm64-v8a-release.apk --> Device 64-Bit
  - /build/app/outputs/apk/release/app-x86_64-release.apk --> High Device


### Build .exe
- flutter pub get
- flutter build windows
- Download and Open Inno Setup
- Create a new script file using the script wizard
- Unchek All And Next
- 3
