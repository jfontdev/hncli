require 'thor'
require_relative 'client'
require_relative 'formatter'

module Hncli
  class CLI < Thor
    desc "top","Show top 10 Hacker News stories"
    def top
      puts "Fetching top stories..."
    end
  end
end
