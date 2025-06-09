require 'thor'
require 'net/http'
require 'json'
require 'pp'
require 'date'
require_relative 'client'
require_relative 'formatter'

module Hncli
  class CLI < Thor
    desc "top","Show top Hacker News stories"
    def top(stories)
      top_stories_URL = "https://hacker-news.firebaseio.com/v0/topstories.json"

      get_stories(top_stories_URL,stories.to_i)
    end

    no_commands do
      def get_json_ids(uri_str,stories)
        parsed_url = URI(uri_str)

        response = Net::HTTP.get_response(parsed_url)

        body = response.body

        parsed_body = JSON.parse(body)

        ids = parsed_body.take(stories)

        return ids
      end


      def get_stories(uri_str, stories)
       ids = get_json_ids(uri_str, stories)

       ids.each do |id|
         base_url = "https://hacker-news.firebaseio.com/v0/item/#{id}.json"

         story_response = Net::HTTP.get_response(URI(base_url))

         story_body = story_response.body

         story_data = JSON.parse(story_body)

         title = story_data["title"]
         author = story_data["by"]
         score = story_data["score"]
         url = story_data["url"] || "(no URL)"
         time =  Time.at(story_data["time"])

         story = {"Title"=>title,"Author" => author, "Score" => score, "URL" => url, "Published at" => time}

         puts "-" * 60
         puts
         pp(story)
         puts
       end
      end
    end
  end
end
