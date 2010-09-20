require File.expand_path('../../lib/panda_canvas', __FILE__)

PandaCanvas.draw do

  def pix3d(x, y, z)
    yy = 480 / 2 - z + x / 2 + y / 2
    xx = 640 / 2 + (x - y) * (3 ** 0.5) / 2
    pixel xx.to_i, yy.to_i, :color => :white
  end

  R = 100
  r = 30

  u = 0
  while u < 6.28 do
    t = 0
    while t < 6.28
      x = (R + r * Math.cos(u)) * Math.sin(t)
      y = (R + r * Math.cos(u)) * Math.cos(t)
      z = r * Math.sin(u)
      pix3d x, y, z
      t += 0.1
    end
    flush
    u += 0.1
  end

end