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

- Ruby 3.x or newer recommended.
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