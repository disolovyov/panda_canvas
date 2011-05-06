require_relative '../lib/panda_canvas'

PandaCanvas.draw do

  def text_circ(s, origin_x, origin_y, r)
    angle = 2 * Math::PI / s.length
    x = 0
    y = -r
    i = 0
    while i < s.length
      new_x = x * Math.cos(angle) - y * Math.sin(angle)
      new_y = x * Math.sin(angle) + y * Math.cos(angle)
      x = new_x
      y = new_y
      text_rel(s[i], x + origin_x, y + origin_y, 0.5, 0.5)
      i += 1
    end
  end

  s1 = 'A WILD PANDA APPEARS '
  s2 = 'the quick brown fox jumps over the lazy dog '

  font 48
  text_circ(s1, 320, 240, 180)
  font 24
  text_circ(s2, 320, 240, 140)

end
