#!/usr/bin/env ruby

output     = []
last_char  = ""

# Note: Prints the line with or without a "\n" on last line.	
def send_line( input:, last_line: false, last_char: )
	if last_char != "\n" && last_line
		print input.chomp!
	else
		print input
	end
end

# Note: Input loop.
ARGF.each_line do | line |
	# CODE
	output << line
 	last_char = line[-1]
end

# Note: Output loop.
output.each_with_index do | line, index |
	# CODE
	index == ( output.size - 1 ) ? last_line = true : last_line = false
	send_line( input: "", last_line: last_line, last_char: last_char )
end