require 'panda_canvas'

def rotate(x, y, angle)
  new_x = x * Math.cos(angle) - y * Math.sin(angle)
  new_y = x * Math.sin(angle) + y * Math.cos(angle)
  [new_x, new_y]
end

def fig(item, cx, cy)
  n = frame % $count / $count
  x, y = rotate(0, -$r, $angle * n)
  i = 0.0
  while i < $count
    scale = (frame + i) % $count / $count
    x, y = rotate(x, y, $angle)
    c = [scale, item.to_f / $c_count, 1]
    circle(
      $sx / 2 + cx + x, $sy / 2 + cy + y, (scale + 0.1) * $r / 3,
      :color => c, :filled => true
    )
    i += 1
  end
  rotate(cx, cy, $c_angle * $count / ($c_count / 5.0))
end

$sx = 640
$sy = 480
$count = 20.0
$angle = 2 * Math::PI / $count
$c_angle = 2 * Math::PI / $count / 5.0
$c_count = 7
$r = $sy / 6.0
cx = 0
cy = -($sy / 4)

PandaCanvas.animate($sx, $sy) do
  dcx, dcy = cx, cy
  $c_count.times do |item|
    dcx, dcy = fig(item, dcx, dcy)
  end
  cx, cy = rotate(cx, cy, $c_angle)
end