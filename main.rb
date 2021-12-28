require 'ruby2d'
require 'pry'

set({ 
  title: "Elastic Collisions", 
  width: 800,
  height: 600
})

Circle.new(
  x: rand(Window.width), y: rand(Window.height),
  radius: 20,
  sectors: 32,
  color: 'red',
  z: 10
)

show