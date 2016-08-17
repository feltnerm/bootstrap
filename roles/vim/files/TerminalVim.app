-- opens a vim terminal via finder

on run {input}
	if (input's class is list and (count of input) is greater than 0) then
		set myPath to POSIX path of input
	else
		set myPath to (get path to home folder)
	end if

	set cmd to "vim " & quote & myPath & quote

	tell application "iTerm"
		activate
		create window with default profile command cmd
	end tell
end run
