# dummy_app

A new Flutter project.


#앱 환경
[✓] Flutter (Channel stable, 3.22.3, on macOS 13.5 22G74 darwin-arm64, locale ko-KR)
[✓] Android toolchain - develop for Android devices (Android SDK version 34.0.0)
[✓] Xcode - develop for iOS and macOS (Xcode 15.0.1)
[✓] Chrome - develop for the web
[✓] Android Studio (version 2022.3)
[✓] VS Code (version 1.89.1)
[✓] Connected device (5 available)

## Getting Started
- flutter doctor
- flutter clean
- flutter pub get
- flutter run

- flutter pub run build_runner build --delete-conflicting-outputs
- flutter pub run build_runner watch --delete-conflicting-outputs


### 모델, 이미지 추가 후 실행
- flutter packages pub run build_runner build

### 패키지 이름 변경
- dart run change_app_package_name:main com.new.package.name

### 앱 아이콘 변경
- https://easyappicon.com/  이사이트에서 아이콘 생성후 512아이콘 사용
- 아이콘위치 assets/icon/icon.png
- flutter pub run flutter_launcher_icons

### ios
- cd ios
- pod install
- flutter run --release (ios 테스트용)

### android
- flutter build apk (android 테스트용)
- flutter build appbundle (android 배포용)


