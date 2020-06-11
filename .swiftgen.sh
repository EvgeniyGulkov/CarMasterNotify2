#!/bin/sh

RSROOT=$SRCROOT/CarMasterNotify/Resources

"$PODS_ROOT/SwiftGen/bin/swiftgen" \
xcassets -t swift4 "$RSROOT/Assets.xcassets" \
--output "$RSROOT/Assets.swift"

"$PODS_ROOT/SwiftGen/bin/swiftgen" \
strings -t structured-swift4 "$RSROOT/Localization/en.lproj/Localization.strings" \
--output "$RSROOT/Localization.swift"
