#!/usr/bin/env ruby

output     = []
last_input_char  = ""
group_num  = nil
new_group  = true
groups     = []

# Note: Prints the line with or without a \n
# Every assignment line is constructed with a \n.
# If you didn't get the final \n in the selection then you will end up with an extra line.
def print_line( new_line:, last_line: false, last_input_char: )
	if last_input_char != "\n" && last_line
		print new_line.chomp!
	else
		print new_line
	end
end

# Note: Regex
# This script is only as good as this regex, makes me nervous.
# Capture Groups: (indention)(optional keyword/c_type + var name + optional type)(operator)(data).
assignments = %r{(^[ \t]*)(?!if|while)((?:[a-z]* )?(?:[\[\]\*.$@:%&a-zA-Z0-9_-]+)(?: ?: ?[0-9A-Za-z]*)? ) *(\+=|-=|\*=|\*\*=|/=|//=|%=|&=|\|=|\^=|\|=|\|\|=|<<|<<=|>>=|=>|:=|=) +(.+)}

# Note: Input loop.
# Makes an array of MatchData and Strings for non-matched line. 
# Groups adjacent assignments together, spacing is made relative to these groups.
ARGF.each_line do | line |
	if m = line.match( assignments )
		if new_group
			group_num.nil? ? group_num = 0 : group_num += 1
			groups[ group_num ] = { line_no: [], gap_width: 0, op_width: 0 }
			new_group = false
		end
 		output << m
		groups[ group_num ][ :gap_width ] =  m[2].length if m[2].length > groups[ group_num ][ :gap_width ]
		groups[ group_num ][ :op_width ]  =  m[3].length if m[3].length > groups[ group_num ][ :op_width ]
 		groups[ group_num ][ :line_no ]   << ARGF.lineno
	else
 		new_group =  true
 		output    << line
	end
 	last_input_char = line[-1]
end

# Note: Output loop.
# Makes each line with consistent spacing around assignment operators.
output.each_with_index  do | line, index |
	if line.class == MatchData
		gap_width = 0
		op_width  = 0
		groups.each do | g |
			if g[ :line_no ].include?( index+1 )
				gap_width = g[ :gap_width ]
				op_width  = g[ :op_width ]
			end
		end
		indent = line[1]
		var    = line[2]
		op     = line[3]
		stuff  = line[4]
				
		var.length < gap_width ? gap = " " * (gap_width - var.length) : gap = ""
		op.length < op_width ? op_pad = " " * (1 + op_width - op.length) : op_pad = " "
		
		index == ( output.size - 1 ) ? last_line = true : last_line = false

		print_line( new_line: "#{indent}#{var}#{gap}#{op}#{op_pad}#{stuff}\n", last_line: last_line, last_input_char: last_input_char )
	else
		print_line( new_line: "#{line}", last_line: last_line, last_input_char: last_input_char )
	end
end
