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
		return "cd '#SELSTART#" & pwd & "#SELEND#'; pwd"
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
			if name of item 1 = w_name then
				# BBEdit added a Project Item to the sidebar so you have to dig one level deeper to get the path of the working dir.
				set _alias to file of item 1 of item 1
			else
				set _alias to file of item 1
			end if
			set pwd to POSIX path of _alias
			return "cd '" & pwd & "'; pwd#INSERTION#"
		else
			set _alias to file of project window 1
			if _alias = missing value then
				return "cd <# You might want to save. #>; pwd"
			else
				tell application "Finder" to set _file to container of file _alias as alias
				set pwd to POSIX path of _file
				return "cd '" & pwd & "'; pwd#INSERTION#"
			end if
		end if
	end tell
end tell