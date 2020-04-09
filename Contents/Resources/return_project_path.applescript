#!/usr/bin/env osascript

tell application "BBEdit"
	# BBEdits Persistent Worksheet.
	tell application "Finder" to set lib to POSIX path of (path to library folder from user domain)
	set test_path to lib & "Application Support/BBEdit/Unix Worksheet.worksheet"
	set doc to file of document 1
	if doc ≠ missing value then
		set doc to POSIX path of doc
	end if
	if test_path = doc then
		set pwd to working directory of document 1
		return "cd '#SELSTART#" & pwd & "#SELEND#'; PWD#INSERTION#"
	end if
	# Projects and free flowing Worksheets.
	tell project document 1
		set w_name to name
		set ext_test to ".bbprojectd"
		try
			set ext to characters -1 thru -11 of w_name as string
		on error
			set ext to ""
		end try
		if ext = ext_test then
			set is_proj to true
		else
			set is_proj to false
		end if
		if is_proj then
			set _alias to file of item 1
			set pwd to POSIX path of _alias
			return "cd '" & pwd & "'; PWD#INSERTION#"
		else
			set _alias to file of project window 1
			if _alias = missing value then
				return "cd <# You might want to save. #>; PWD<#? #>"
			else
				tell application "Finder" to set _file to container of file _alias as alias
				set pwd to POSIX path of _file
				return "cd '" & pwd & "'; PWD#INSERTION#"
			end if
		end if
	end tell
end tell