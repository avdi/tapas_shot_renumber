SHOT_NUMBER_PATTERN = /
(?<=\<!--\s) # Must be preceded by '<!--'
shot\(\d*\)  # e.g. 'shot(23)' or 'shot()'
(?=\s.*-->)  # must be followed by '-->'
/x

def do_in_fence(line, state)
  state[:in_fenced] = false if (line =~ /^```/)
  line 
end

def do_out_of_fence(line, state)
  state[:in_fenced] = true if (line =~ /^```/)
  line.sub(SHOT_NUMBER_PATTERN) {
    "shot(#{state[:shot_number] += 1})"
  }
end

ARGF
  .each_line
  .each_with_object({shot_number: 0, in_fenced: false})
  .map { |line, state|
    if state[:in_fenced] then 
      do_in_fence(line, state)
    else 
      do_out_of_fence(line, state)
    end
  }
  .each(&method(:puts))


