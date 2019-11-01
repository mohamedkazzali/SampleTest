!/usr/bin/env bash

#1: LOG_USERNAME
#2: LOG_PASSWORD
#3: DRONE_BUILD_NUMBER
#4: DRONE_PULL_REQUEST
#5: GIT_USERNAME
#6: GIT_TOKEN

#DAV_URL=
PUBLIC_URL=https://api.github.com/Lediya/SampleTest/app/
USER=lediya.nesakumari@rntbci.com
PASS=Lediya2019@@
BUILD=1.0
PR=$4
GIT_USERNAME=Lediya
GIT_TOKEN=23e387764c7d32821b002888fa84ddedb7c00fc2

if ! test -e build/outputs/apk/qa/debug/qa-debug-*.apk ; then
    exit 1
fi
echo "Uploaded artifact to $BUILD.apk"

apt-get -y install testapp

testapp -o $PR.png "$PUBLIC_URL/$BUILD.apk"

#curl -u $USER:$PASS -X PUT $DAV_URL/$BUILD.apk --upload-file build/outputs/apk/qa/debug/qa-debug-*.apk
#curl -u $USER:$PASS -X PUT $DAV_URL/$BUILD.png --upload-file $PR.png
curl -u $USER:$PASS -X PUT $PUBLIC_URL/$BUILD.apk --upload-file build/outputs/apk/qa/debug/qa-debug-*.apk
curl -X PUT -u $USER:$PASS -X PUT $BUILD.apk --upload-file build/outputs/apk/qa/debug/qa-debug-*.apk
curl -u $GIT_USERNAME:$GIT_TOKEN -X POST  https://api.github.com/Lediya/TestApp/issues/comments/$PR/comments -d "{ \"body\" : \"APK file: $PUBLIC_URL/$BUILD.apk <br/><br/> ![qrcode]($PUBLIC_URL/$BUILD.png) <br/><br/>To test this change/fix you can simply download above APK file and install and test it in parallel to your existing Test app. \" }"
