#!/usr/bin/env osascript

tell application "BBEdit"
	set doc to source language of document 1
	set doc to change case of doc making lower case
	
	if doc = "applescript" then
		return "osascript"
	else if doc = "swift" then
		return "xcrun swift"
	else if doc = "awk" then
		return "awk -f"
	else if doc = "unix shell script" then
		return "bash"
	else if doc = "javascript" then
		return "node"
	else
		return doc
	end if
end tell