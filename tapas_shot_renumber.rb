SHOT_NUMBER_PATTERN = /
(?<=\<!--\s) # Must be preceded by '<!--'
shot\(\d*\)  # e.g. 'shot(23)' or 'shot()'
(?=\s.*-->)  # must be followed by '-->'
/x
ENTER_CODE_BLOCK_PATTERN = /^```/
EXIT_CODE_BLOCK_PATTERN  = /^```/

def in_body(next_shot_number) 
  look_for_shots = ->(line) {
    if line.sub!(SHOT_NUMBER_PATTERN, "shot(#{next_shot_number})")
      [line, in_body(next_shot_number + 1)]
    elsif line =~ ENTER_CODE_BLOCK_PATTERN
      [line, in_fenced_code_block(next_shot_number)]
    else
      [line, look_for_shots]
    end
  }
  look_for_shots
end


def in_fenced_code_block(next_shot_number)
  look_for_end = ->(line) {
    if (line =~ EXIT_CODE_BLOCK_PATTERN)
      [line, in_body(next_shot_number)]
    else
      [line, look_for_end] 
    end
  }
  look_for_end
end

ARGF
  .each_line
  .reduce(in_body(1)) { |thing_to_do, line|
    begin 
      line, thing_to_do = thing_to_do.call(line)
    rescue => e 
      warn "Unable to process line: " + line
      raise
    end
    puts line
    thing_to_do
  }


