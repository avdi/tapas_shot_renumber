shot_number_pattern = /
(?<=\<!--\s) # Must be preceded by '<!--'
shot\(\d*\)  # e.g. 'shot(23)' or 'shot()'
(?=\s.*-->)  # must be followed by '-->'
/x

ARGF
  .each_line
  .each_with_object({shot_number: 0, in_fenced: false})
  .map { |line, state|
    state[:in_fenced] ^= (line =~ /^```/)
    if state[:in_fenced] then 
      line 
    else 
      line.sub(shot_number_pattern) {
        "shot(#{state[:shot_number] += 1})"
      }
    end
  }
  .each(&method(:puts))


