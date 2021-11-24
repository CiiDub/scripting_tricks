#!/usr/bin/env ruby

bb_env = ENV
.select { | e | /BB_DOC_.+|BBEDIT_.+/.match? e  }
.sort
.map! { | bb | "#{bb[0]} = #{bb[1]}" }
.join( "\n" )

system "echo '#{bb_env}' > '/var/tmp/bb_env'; open -a 'BBEdit' '/var/tmp/bb_env'"