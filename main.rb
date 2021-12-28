require 'ruby2d'
require 'pry'
require './ball'

set({ 
  title: "Elastic Collisions", 
  width: 800,
  height: 600,
  background: 'white'
})

@balls = []
50.times do
  @balls << Ball.new
end

def move_ball(ball)
  calculate_wall_collisions(ball)
  detect_ball_collisions(ball)
  ball.update_position
end

def detect_ball_collisions(current_ball)
  current_ball.circle.color = 'green'
  @balls.each do |ball|
    if balls_collide?(current_ball, ball) 
      current_ball.circle.color = 'red'
    end
  end

end

# Two balls collide if the distance between both centers is lower or equal the sum of their radiuses
def balls_collide?(b1, b2)
  return false if b1 == b2

  distance = Math.sqrt((b2.x - b1.x)**2 + (b2.y - b1.y)**2)
  # binding.pry
  distance <= (b1.radius + b2.radius)
  # return sqrtf(pow(p2->GetX() - p1->GetX(), 2) + pow(p2->GetY() - p1->GetY(), 2));
end

def calculate_wall_collisions(ball)
  #right wall
  if (ball.x + ball.radius) == Window.width
    ball.speed_x *= -1
  end
  # left wall
  if (ball.x - ball.radius) == 0
    ball.speed_x *= -1
  end
  # upper wall
  if (ball.y - ball.radius) == 0
    ball.speed_y *= -1
  end
  # bottom wall
  if (ball.y + ball.radius) == Window.height
    ball.speed_y *= -1
  end
end


update do 
  @balls.each { |ball| move_ball(ball) }
end

show