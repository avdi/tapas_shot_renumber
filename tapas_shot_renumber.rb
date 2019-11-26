SHOT_NUMBER_PATTERN = /
(?<=\<!--\s) # Must be preceded by '<!--'
shot\(\d*\)  # e.g. 'shot(23)' or 'shot()'
(?=\s.*-->)  # must be followed by '-->'
/x

def do_in_fence(next_shot_number)
  return ->(line) {
    if (line =~ /^```/)
      [line, do_out_of_fence(next_shot_number)]
    else
      [line, do_in_fence(next_shot_number)] 
    end
  }
end

def do_out_of_fence(next_shot_number) 
  return ->(line) {
    return [line, do_in_fence(next_shot_number)] if line =~ /^```/
    if line.sub!(SHOT_NUMBER_PATTERN, "shot(#{next_shot_number})")
      [line, do_out_of_fence(next_shot_number + 1)]
    else
      [line, do_out_of_fence(next_shot_number)]
    end
  }
end

ARGF
  .each_line
  .each_with_object({thing_to_do: do_out_of_fence(1)})
  .map { |line, state|
    line, thing_to_do = state[:thing_to_do].call(line)
    state[:thing_to_do] = thing_to_do
    line
  }
  .each(&method(:puts))


