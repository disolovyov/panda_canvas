require_relative '../lib/panda_canvas'

PandaCanvas.draw do

  def pix3d(x, y, z, color=:white)
    yy = 480 / 2 - z + x / 2 + y / 2
    xx = 640 / 2 + (x - y) * (3 ** 0.5) / 2
    pixel xx, yy, :color => color
  end

  R = 150.0
  r = 50.0

  u = Math::PI
  while u < Math::PI * 3 do
    t = 0
    while t < Math::PI * 2
      x = (R + r * Math.cos(u)) * Math.sin(t)
      y = (R + r * Math.cos(u)) * Math.cos(t)
      z = r * Math.sin(u)
      pix3d x, y, z, [x * 2 / (R + r), y * 2 / (R + r), 1, (z + r) / r / 2]
      t += 0.05
    end
    flush
    u += 0.05
  end

end
