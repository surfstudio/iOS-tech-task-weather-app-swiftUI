fastlane documentation
================
# Installation

Make sure you have the latest version of the Xcode command line tools installed:

```
xcode-select --install
```

Install _fastlane_ using
```
[sudo] gem install fastlane -NV
```
or alternatively using `brew cask install fastlane`

# Available Actions
## iOS
### ios tag_app_icon
```
fastlane ios tag_app_icon
```

### ios load_signins
```
fastlane ios load_signins
```

### ios build
```
fastlane ios build
```
Build Debug and Prod Xcode target in Debug configuration

Parameters:
  - clean: Pass **true** if you need to clean project before build
  
### ios tests
```
fastlane ios tests
```
Run tests
### ios prepare_for_integration
```
fastlane ios prepare_for_integration
```
Update build number, set tag and push version bump commit to the develop branch if needed

Parameters:
  - version_number: Number of version that will be set
  - type: Type of the build which will be set with the tag. For Example: for release candidate builds with tag `1.0.0-rc10` you need to pass `rc`.
  - type_v: Version of current build type (type parameter).
  - skip_push: Pass **true** if you need to skip push commits to the repository. The default is **false**
  
### ios prepare_for_beta
```
fastlane ios prepare_for_beta
```
Update build number, set tag and push version bump commit to the develop branch if needed

Parameters:
  - type: Type of the build which will be set with the tag. For Example: for release candidate builds with tag `1.0.0-rc10` you need to pass `rc`.
  - skip_push: Pass **true** if you need to skip push commits to the repository. The default is **false**
  
### ios prepare_for_release
```
fastlane ios prepare_for_release
```
Set `rc` tag and push to the current branch

Parameters:
  - include_beta: Pass **true** to call `prepare_for_beta` lane for debug and prod types
  - skip_push: Pass **true** if you need to skip push commits to the repository. The default is **false**
  
### ios beta
```
fastlane ios beta
```
Upload a new Beta Build to Firebase

Parameters:
  - destination: Type of the build which will be submitted
  
### ios release
```
fastlane ios release
```
Upload a new Release Build to iTunesConnect

Parameters:
    - destination: debug/prod - Type of the build which will be uploaded, debug by default
  
### ios upload_to_firebase
```
fastlane ios upload_to_firebase
```
Uploads a new build to Firebase

Parameters:
  - destination: debug/prod - Type of the build which will be uploaded
  
### ios refresh_dsyms
```
fastlane ios refresh_dsyms
```
Send dSYMS to Firebase

Parameters:
  - destination: debug/prod - Type of the build which will be used to download dSYMS, debug by default
  
### ios create_apps_certs_profiles
```
fastlane ios create_apps_certs_profiles
```


----

This README.md is auto-generated and will be re-generated every time [fastlane](https://fastlane.tools) is run.
More information about fastlane can be found on [fastlane.tools](https://fastlane.tools).
The documentation of fastlane can be found on [docs.fastlane.tools](https://docs.fastlane.tools).
