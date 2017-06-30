describe('Animation', function()
  local mach = require 'mach'
  local Animation = require 'Animation'

  _G.love = {
    graphics = mach.mock_table({
      newImage = load'',
      newQuad = load'',
      draw = load''
    }, 'love.graphics')
  }

  local function Image(w, h)
    return {
      getWidth = function() return w end,
      getHeight = function() return h end,
      getDimensions = function() return w, h end
    }
  end

  it('should animate all frames by default', function()
    local animation
    local image = Image(15, 8)

    love.graphics.newImage:should_be_called_with('some/sprite.sheet'):and_will_return(image):
      and_also(love.graphics.newQuad:should_be_called_with(0, 0, 5, 8, 15, 8):and_will_return('q1')):
      and_also(love.graphics.newQuad:should_be_called_with(5, 0, 5, 8, 15, 8):and_will_return('q2')):
      and_also(love.graphics.newQuad:should_be_called_with(10, 0, 5, 8, 15, 8):and_will_return('q3')):
      when(function()
        animation = Animation('some/sprite.sheet', 3, 2)
      end)

    love.graphics.draw:should_be_called_with(image, 'q1', 123, 456):multiple_times(2):when(function()
      animation.draw(123, 456)
      animation.step()
      animation.draw(123, 456)
    end)

    love.graphics.draw:should_be_called_with(image, 'q2', 21, 42):multiple_times(2):when(function()
      animation.step()
      animation.draw(21, 42)
      animation.step()
      animation.draw(21, 42)
    end)

    love.graphics.draw:should_be_called_with(image, 'q3', 1, 2):multiple_times(2):when(function()
      animation.step()
      animation.draw(1, 2)
      animation.step()
      animation.draw(1, 2)
    end)

    love.graphics.draw:should_be_called_with(image, 'q1', 1, 2):multiple_times(2):when(function()
      animation.step()
      animation.draw(1, 2)
      animation.step()
      animation.draw(1, 2)
    end)
  end)

  it('should allow the animation to be reset', function()
    local animation
    local image = Image(15, 8)

    love.graphics.newImage:should_be_called_with('some/sprite.sheet'):and_will_return(image):
      and_also(love.graphics.newQuad:should_be_called_with(0, 0, 5, 8, 15, 8):and_will_return('q1')):
      and_also(love.graphics.newQuad:should_be_called_with(5, 0, 5, 8, 15, 8):and_will_return('q2')):
      and_also(love.graphics.newQuad:should_be_called_with(10, 0, 5, 8, 15, 8):and_will_return('q3')):
      when(function()
        animation = Animation('some/sprite.sheet', 3, 2)
      end)

    love.graphics.draw:should_be_called_with(image, 'q1', 123, 456):when(function()
      animation.step()
      animation.step()
      animation.step()
      animation.step()
      animation.reset()
      animation.draw(123, 456)
    end)
  end)

  it('should allow the animation to be set to a specific frame', function()
    local animation
    local image = Image(15, 8)

    love.graphics.newImage:should_be_called_with('some/sprite.sheet'):and_will_return(image):
      and_also(love.graphics.newQuad:should_be_called_with(0, 0, 5, 8, 15, 8):and_will_return('q1')):
      and_also(love.graphics.newQuad:should_be_called_with(5, 0, 5, 8, 15, 8):and_will_return('q2')):
      and_also(love.graphics.newQuad:should_be_called_with(10, 0, 5, 8, 15, 8):and_will_return('q3')):
      when(function()
        animation = Animation('some/sprite.sheet', 3, 2)
      end)

    love.graphics.draw:should_be_called_with(image, 'q2', 123, 456):multiple_times(2):when(function()
      animation.set_frame(2)
      animation.draw(123, 456)
      animation.step()
      animation.draw(123, 456)
    end)
  end)
end)
