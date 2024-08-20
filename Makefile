FLUTTER := $(shell which flutter)

clean: podfileLockClean androidGradleClean cacheClean

androidGradleClean:
	@echo "╠ Cleaning Android Gradle build..."
	@if [ ! -f ./android/gradlew ]; then \
		echo "╠ Initializing Android Gradle project..."; \
		cd android && $(FLUTTER) pub get && $(FLUTTER) build apk --debug; \
	else \
		cd android && ./gradlew clean; \
	fi


podfileLockClean:
	@echo "╠ Deleting Podfile.lock..."
	@rm -f ./ios/Podfile.lock

cacheClean:
	@echo "╠ Cleaning caches of the app"
	@flutter clean && flutter pub get && flutter pub upgrade && cd ios && pod repo update && pod install



.PHONY: clean cacheClean podfileLockClean androidGradleClean
