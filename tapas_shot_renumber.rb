SHOT_NUMBER_PATTERN = /
(?<=\<!--\s) # Must be preceded by '<!--'
shot\(\d*\)  # e.g. 'shot(23)' or 'shot()'
(?=\s.*-->)  # must be followed by '-->'
/x

def do_in_fence(line, state)
  state[:thing_to_do] = method(:do_out_of_fence) if (line =~ /^```/)
  line 
end

def do_out_of_fence(line, state)
  state[:thing_to_do] = method(:do_in_fence) if (line =~ /^```/)
  line.sub(SHOT_NUMBER_PATTERN) {
    "shot(#{state[:shot_number] += 1})"
  }
end

ARGF
  .each_line
  .each_with_object({shot_number: 0, thing_to_do: method(:do_out_of_fence)})
  .map { |line, state|
    state[:thing_to_do].call(line, state)
  }
  .each(&method(:puts))


