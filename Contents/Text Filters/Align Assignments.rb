#!/usr/bin/env ruby

assign_lines = []
output       = ""
group_num    = nil
new_group    = true
groups       = []
last_char    = ""

# This script is only as good as this regex, makes me nervous.
# Layout: (indention)(optional keyword + optional type + var name)(operator)(data). There are some options spaces " ?" & " *".
assignments = %r{(^[ \t]*)([a-z]* ?[a-z_-]* ?[$@:%&a-zA-Z0-9_-]+ +)(\+=|-=|\*=|\*\*=|/=|//=|%=|&=|\|=|\^=|\|=|\|\|=|<<=|>>=|=>|:=|=) *(.+)}

# Makes an array of MatchData objects "m" which is the line split into four peices.
# Finds the longest length start of variable name to operator.
# Finds the longest operator so padding on the far side will be consistent even if list contains different kinds.
ARGF.each_line do | line |
	if m = line.match( assignments )
		if new_group
			group_num.nil? ? group_num = 0 : group_num += 1
			groups[ group_num ] = { line_no: [], gap_width: 0, op_width: 0 }
			new_group = false
		end
 		assign_lines << m
		groups[ group_num ][ :gap_width ] = m[2].length if m[2].length > groups[ group_num ][ :gap_width ]
		groups[ group_num ][ :op_width ] = m[3].length if m[3].length > groups[ group_num ][ :op_width ]
 		groups[ group_num ][ :line_no ] << ARGF.lineno
	else
 		new_group = true
 		assign_lines << line
	end
	last_char = line[-1]
end

# Makes each line with consistent spacing around assignment operators.
assign_lines.each_with_index  do | line, index |
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
		
		output << "#{indent}#{var}#{gap}#{op}#{op_pad}#{stuff}\n"
	else
		output << "#{line}"
	end
end

if ENV[ 'BB_DOC_SELSTART' ] != ENV[ 'BB_DOC_SELEND' ] && last_char != "\n"
	print output.chomp
else
	print output
end