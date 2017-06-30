return function(filename, frame_count, frame_time)
  local image = love.graphics.newImage(filename)
  local frames = {}
  local frame_width = image:getWidth() / frame_count
  local frame_height = image:getHeight()
  local step_count = 0

  for i = 1, frame_count do
    table.insert(frames, love.graphics.newQuad(
      frame_width * (i - 1),
      0,
      frame_width,
      frame_height,
      image:getDimensions()
    ))
  end

  return {
    step = function()
      step_count = (step_count + 1) % (frame_time * frame_count)
    end,

    draw = function(x, y)
      local frame_index = 1 + math.floor(step_count / frame_time)
      love.graphics.draw(image, frames[frame_index], x, y)
    end,

    reset = function()
      step_count = 0
    end,

    set_frame = function(n)
      step_count = n
    end
  }
end
