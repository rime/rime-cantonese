from itertools import product

invalid_chars_in_char_class = {*'()['}

def bracket_expand(s):
  def inner(s):
    t = ''
    depth = 0
    parts = []
    in_char_class = False
    for c in s:
      if in_char_class:
        assert c not in invalid_chars_in_char_class, f'Invalid character "{c}" in character class in "{s}"'
        if c == ']':
          assert t, f'Empty character class in "{s}"'
          parts.append(t)
          t = ''
          in_char_class = False
        else:
          t += c
      elif c == '[':
        if not depth:
          parts.append([t])
          t = ''
          in_char_class = True
        else:
          t += c
      elif c == '(':
        if not depth:
          parts.append([t])
          t = ''
        else:
          t += c
        depth += 1
      elif c == ')':
        depth -= 1
        if not depth:
          parts.append(bracket_expand(t))
          t = ''
        else:
          t += c
      else:
        t += c
    assert not depth, f'Unbalanced bracket in "{s}"'
    parts.append([t])
    return [''.join(part) for part in product(*parts)]

  t = ''
  depth = 0
  parts = []
  for c in s:
    if c == '(':
      depth += 1
      t += c
    elif c == ')':
      depth -= 1
      t += c
    elif not depth and c == '|':
      parts += inner(t)
      t = ''
    else:
      t += c
  assert not depth, f'Unbalanced bracket in "{s}"'
  parts += inner(t)
  return parts
