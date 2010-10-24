require_relative '../lib/panda_canvas'

PandaCanvas.animate do

  x = frame % (width / 10) * 10
  line x, 0, x, height, :color => :white
  font 48
  text_rel(frame, 320, 240, 0.5, 0.5)

end