# frozen_string_literal: true
require 'spec_helper'
require 'net/http'

RSpec.describe Hncli::CLI do
  let(:cli) { described_class.new }

  describe '#get_json_ids' do
    it 'fetches and returns the correct number of story IDs' do
      # ---------------------
      # Arrange
      # ---------------------

      sample_ids = [1, 2, 3, 4, 5]
      response_body = sample_ids.to_json

      uri = URI("https://hacker-news.firebaseio.com/v0/topstories.json")

      # Create a mock HTTP response object.
      # This object will respond to `.body` and return our JSON string.
      http_response = instance_double(Net::HTTPResponse, body: response_body)

      # Stub the Net::HTTP.get_response method so that when it is called with
      # the specific URI (topstories URL), it returns our mocked response instead
      # of making a real HTTP call.
      allow(Net::HTTP).to receive(:get_response).with(uri).and_return(http_response)

      # ---------------------
      # Act
      # ---------------------
      ids = cli.send(:get_json_ids, uri.to_s, 3)

      # ---------------------
      # Assert
      # ---------------------
      expect(ids).to eq([1, 2, 3])
    end
  end

  describe '#get_stories' do
    let(:story_id) { 123 }
    let(:story_url) { "https://hacker-news.firebaseio.com/v0/item/#{story_id}.json" }
    let(:stories_url) { "https://hacker-news.firebaseio.com/v0/topstories.json" }

    before do
      # ---------------------
      # Arrange
      # ---------------------

      # Stub the internal method `get_json_ids` on our CLI instance to avoid
      # depending on its actual implementation here. This isolates the test
      # so that get_stories only tests its own logic, not the logic of fetching IDs.
      allow(cli).to receive(:get_json_ids).with(stories_url, 1).and_return([story_id])

      # Create a mocked HTTP response for the individual story fetch.
      # This fake response returns JSON for a story with expected fields.
      story_response = instance_double(Net::HTTPResponse, body: {
        title: "Test Story",
        by: "tester",
        score: 42,
        url: "https://example.com/story",
        time: Time.now.to_i
      }.to_json)

      # Stub Net::HTTP.get_response again, this time for the story details URL.
      # When called with the story's URI, it returns our mocked story response.
      allow(Net::HTTP).to receive(:get_response).with(URI(story_url)).and_return(story_response)
    end

    it "fetches stories and prints their details" do
      # ---------------------
      # Act + Assert
      # ---------------------

      # Here we assert that running get_stories will output the story title to STDOUT.
      expect {
        cli.get_stories(stories_url, 1)
      }.to output(/Test Story/).to_stdout
    end
  end
end
