# HN CLI 🔎

A simple Ruby CLI tool to fetch and display top stories from [Hacker News](https://news.ycombinator.com/) using the official Firebase API.

## 🚀 Purpose

This tool is built for:

- Practicing Ruby scripting and CLI development.
- Exploring APIs with `net/http`.
- Building a clean, modular command-line experience using [`thor`](https://github.com/rails/thor).

## 🛠 Features

- Fetches the top N stories from Hacker News.
- Displays story metadata: title, author, score, URL, and publish time.
- Simple, clean output using `pp`.
- Handles missing URLs gracefully.
- Modular design: logic split into helpers (`client`, `formatter`) for future growth.

## 📦 Requirements

- Ruby 3.4 or newer recommended.
- Gems:
  - `thor`
  - `json`

(Install with `bundle install` if you use a Gemfile)

## 🧪 Usage

### Fetch Top Stories

```bash
./bin/hn.sh top 5
```
🔹 This will print the top 5 stories from Hacker News with relevant information.

## 🧪 Testing

This project uses [RSpec](https://rspec.info/) for tests.

To run all tests:

```bash
bundle exec rspec
```	

### ⚠️ Ruby Version Compatibility
Tests that assert exact CLI output (e.g., via puts) currently assume Ruby 3.4+ formatting for Hashes.

Example difference:

Ruby 3.3: {"Title"=>"Hello"}

Ruby 3.4+: {"Title" => "Hello"}

If you're using Ruby 3.3, some output-based tests (like the top command) may fail due to formatting differences. We recommend running tests under Ruby 3.4 until we improve cross-version formatting consistency.

## 🗂 Directory Structure

```plaintext
hncli/
├── bin/
│   └── hn.sh         # Entry point script
├── lib/
│   └── hncli/
│       ├── cli.rb    # Thor CLI definition
│       ├── client.rb # (future) API client logic
│       └── formatter.rb # (future) Output formatting
├── README.md
├── Gemfile           # Gem dependencies
```

## 🧩 Future Improvements
- Add options like --limit, --raw, or --json.

- Colorized or tabular output.

- Support for other story types: newstories, beststories, etc.

- Caching or pagination support.

- Specs using RSpec or Minitest.

## 📘 Hacker News API Reference: https://github.com/HackerNews/API