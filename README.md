# reman_app

A Flutter project.

## Flutter version
-3.16.8


## Getting Started
- flutter doctor
- flutter clean
- flutter pub get
- flutter run

- flutter pub run build_runner build --delete-conflicting-outputs
- flutter pub run build_runner watch --delete-conflicting-outputs


### 모델, 이미지 추가 후 실행
- flutter packages pub run build_runner build

### ios
- cd ios
- pod install
- flutter run --release (ios 테스트용)

### android
- flutter build apk (android 테스트용)
- flutter build appbundle (android 배포용)


## Android 인증
추후 배포시 key파일 필요함