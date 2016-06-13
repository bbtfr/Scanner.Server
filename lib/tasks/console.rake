desc 'Start the console'
task :console do
  require 'pry'
  Pry.start
end
