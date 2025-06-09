require 'spec_helper'
require 'net/http'

RSpec.describe "Hncli CLI top command" do
  let(:cli) { Hncli::CLI.new }

  # Define the Hacker News API endpoints we'll be mocking
  let(:stories_url) { "https://hacker-news.firebaseio.com/v0/topstories.json" }
  let(:story_id) { 123 }
  let(:story_url) { "https://hacker-news.firebaseio.com/v0/item/#{story_id}.json" }

  before do
    # ---------------------
    # Arrange (Mocks)
    # ---------------------

    # Stub: GET /v0/topstories.json
    # This simulates getting the top story IDs, e.g., [123]
    top_response = instance_double(Net::HTTPResponse, body: [story_id].to_json)
    allow(Net::HTTP).to receive(:get_response).with(URI(stories_url)).and_return(top_response)

    # Stub: GET /v0/item/123.json
    # This simulates getting a single story by ID
    story_response = instance_double(Net::HTTPResponse, body: {
      title: "Integration Test Story",
      by: "int_tester",
      score: 123,
      url: "https://example.com/test-story",
      time: Time.at(1749480163).to_i  # Fixed timestamp for predictable output
    }.to_json)
    allow(Net::HTTP).to receive(:get_response).with(URI(story_url)).and_return(story_response)
  end

  it "prints the top story with all relevant fields" do
    # ---------------------
    # Arrange (Expectation)
    # ---------------------
    expected_output = <<~OUT
      ------------------------------------------------------------

      {"Title" => "Integration Test Story",
       "Author" => "int_tester",
       "Score" => 123,
       "URL" => "https://example.com/test-story",
       "Published at" => 2025-06-09 16:42:43 +0200}

    OUT

    # ---------------------
    # Act + Assert
    # ---------------------
    expect {
      cli.top("1")  # Act
    }.to output(expected_output).to_stdout  # Assert
  end
end
