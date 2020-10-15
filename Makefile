## Installs all dependencies
init:
	# Install bundler if not installed
	if ! gem spec bundler > /dev/null 2>&1; then\
  		echo "bundler gem is not installed!";\
  		-sudo gem install bundler;\
	fi
	-bundle update
	-bundle install --path .bundle
	-bundle exec pod repo update
	-bundle exec pod install

	# Install git hooks
	mkdir -p .git/hooks
	chmod +x commit-msg
	ln -s -f ../../commit-msg .git/hooks/commit-msg

merge:
	-sh ./scripts/merge.sh

pbxproj:
	xcodegen generate
	-bundle exec pod install

## Generate screen module with name given in `modName` parameter
screen:
	bundle exec generamba gen $(modName) surf_mvp_coordinatable_module --module_path 'Weather/Flows/$(flow)' --test_path 'UnitTests/Flows/$(flow)'

## Generate alert module with name given in `modName` parameter
alert:
	bundle exec generamba gen $(modName) surf_mvp_coordinatable_alert --module_path 'Weather/Flows/$(flow)' --test_path 'UnitTests/Flows/$(flow)'

## Execute build with fastlane
build:
	bundle exec fastlane build clean:true

## Run tests
test:
	bundle exec fastlane tests

## Convert groups to folders if needed and sort with alphabetic order
synx:
	bundle exec synx --exclusion "Weather/Non-iOS Resources" Weather.xcodeproj

## Run SwiftLint check
lint:
	./Pods/SwiftLint/swiftlint lint --config .swiftlint.yml
	npx jscpd --config ./.jscpd.json ./Weather

## Autocorrect with SwiftLint
format:
	./Pods/SwiftLint/swiftlint autocorrect --config .swiftlint.yml

## Execute pod install command
pod:
	-bundle exec pod install

## Test that all files included to both targets
targets_check:
	bundle exec ruby ./scripts/sourcesComparing.rb  "./Weather.xcodeproj" "WeatherRelease" "WeatherDebug"

prepare_for_beta:
	bundle exec fastlane prepare_for_beta type:debug skip_push:$(skip_push)
	bundle exec fastlane prepare_for_beta type:prod skip_push:$(skip_push)

# Generates provided `name` parameter from `spectPath` openapi spec 
model:
	./Pods/SurfGen/Binary/surfgen generate $(specPath) -m $(name) --config ./surfgen/config.yaml

app_cert_profile:
	bundle exec fastlane create_apps_certs_profiles appleId:$(appleId)


## Default configuration for beta command
config ?= debug

## Create and uploads build to Firebase or AppStoreConnect
## - Parameter config: Configuration for build.
## - Allowed inputs:
## config=debug - sends debug build to Firebase
## config=prod - sends prod build to Firebase
## config=rc - sends release build to AppStoreConnect
beta:
ifeq ($(config),debug)
	bundle exec fastlane beta destination:$(config)
else ifeq ($(config),prod)
	bundle exec fastlane beta destination:$(config)
else ifeq ($(config),rc)
	bundle exec fastlane release destination:debug
else
	@echo "No suitable command for" $(config)
	exit 1;
endif

# Analytics
analytics_pods:
	./data-collector/ex pods --projectId=$(projectJiraId) --baseURL=$(serverUrl) --path=./ --configurationPath=./data-collector/pods_config.json
analytics_tests:
	./data-collector/ex tests --projectId=$(projectJiraId) --baseURL=$(serverUrl) --path=$(report)
analytics_duplicates:
	./data-collector/ex duplicates --projectId=$(projectJiraId) --baseURL=$(serverUrl) --path=$(report)
