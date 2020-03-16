#!/usr/bin/env ruby

# The smoke_it boolean is a gatekeeper. If it is set to true the script will return the BBEdit document with no changes.
smoke_it     = false
doc = ARGF.read
start_line   = ENV['BB_DOC_SELSTART_LINE']
end_line     = ENV['BB_DOC_SELEND_LINE']
assign_lines = []
gap_width    = 0
op_width     = 0
output       = ""

# More than one line must be selected. Only assignment lines can be selected.
smoke_it = true if start_line == end_line

# This script is only as good as this regex, makes me nervous.
# Layout: (indention)(optional keyword + optional type + var name)(operator)(data). There are some options spaces " ?" & " *".
assignments = %r{(^[ \t]*)([a-z]* ?[a-z_-]* ?[$@:%&a-zA-Z0-9_-]+ +)(\+=|-=|\*=|\*\*=|/=|//=|%=|&=|\|=|\^=|\|=|\|\|=|<<=|>>=|=>|:=|=) *(.+)}

# Makes an array of MatchData objects "m" which is the line split into four peices.
# Finds the longest length start of variable name to operator.
# Finds the longest operator so padding on the far side will be consistent even if list contains different ones.
doc.each_line do | line |
	if m = line.match( assignments )
		assign_lines << m
		gap_width = m[2].length if m[2].length > gap_width
		op_width  = m[3].length if m[3].length > op_width
	else
 		smoke_it = true
	end
end

# Makes each line with consistent spacing around assignment operators.
assign_lines.each do | m |
	indent = m[1]
	var    = m[2]
	op     = m[3]
	stuff  = m[4]
	
	var.length < gap_width ? gap = " " * (gap_width - var.length) : gap = ""
	
	op.length < op_width ? op_pad = " " * (1 + op_width - op.length) : op_pad = " "
	
	output << "#{indent}#{var}#{gap}#{op}#{op_pad}#{stuff}\n"
end

unless smoke_it
	output.chomp! unless doc[-1] == "\n"
	print output
else
	print doc
end