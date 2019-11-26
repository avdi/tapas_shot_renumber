SHOT_NUMBER_PATTERN = /
(?<=\<!--\s) # Must be preceded by '<!--'
shot\(\d*\)  # e.g. 'shot(23)' or 'shot()'
(?=\s.*-->)  # must be followed by '-->'
/x

def do_in_fence(next_shot_number)
  return ->(line, state) {
    state[:thing_to_do] = do_out_of_fence(next_shot_number) if (line =~ /^```/)
    line 
  }
end

def do_out_of_fence(next_shot_number) 
  return ->(line, state) {
    output_line = line
    if line =~ SHOT_NUMBER_PATTERN
      next_shot_number = next_shot_number + 1
      output_line = line.sub(SHOT_NUMBER_PATTERN, "shot(#{next_shot_number})")
      state[:thing_to_do] = do_out_of_fence(next_shot_number)
    end
    state[:thing_to_do] = do_in_fence(next_shot_number) if (line =~ /^```/)
    output_line
  }
end

ARGF
  .each_line
  .each_with_object({thing_to_do: do_out_of_fence(0)})
  .map { |line, state|
    state[:thing_to_do].call(line, state)
  }
  .each(&method(:puts))


