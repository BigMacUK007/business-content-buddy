# Business Content Buddy

<div align="center">

**A calm, guided space for business owners to turn their weekly experiences into consistent, authority-building content — without the overwhelm.**

[![Ruby on Rails](https://img.shields.io/badge/Rails-8.0-red.svg)](https://rubyonrails.org/)
[![Ruby Version](https://img.shields.io/badge/ruby-3.3.0-red.svg)](https://www.ruby-lang.org/)
[![PostgreSQL](https://img.shields.io/badge/PostgreSQL-14+-blue.svg)](https://www.postgresql.org/)
[![License](https://img.shields.io/badge/License-All%20Rights%20Reserved-lightgrey.svg)](LICENSE)

[Features](#features) • [Tech Stack](#tech-stack) • [Getting Started](#getting-started) • [Documentation](#documentation) • [Roadmap](#development-roadmap)

</div>

---

## Overview

Business Content Buddy is a Rails 8 application that helps founders, consultants, and small business owners publish consistent, high-quality social content using an AI-assisted weekly framework. The app transforms your insights and experiences into ready-to-post content that builds authority, trust, and engagement.

### Why Business Content Buddy?

- **Structured Framework**: 7-day content system aligned with proven post types
- **Reduce Overwhelm**: Guided workflows that make content creation feel manageable
- **Build Authority**: Consistent posting that establishes your expertise
- **AI-Assisted**: Smart tools to tighten copy and surface insights
- **Track Progress**: Visual boards and streak tracking to maintain momentum

---

## Features

### Core Features (MVP)

#### 📅 **Weekly Planner (7-Day Board)**
- Visual 7-column board (Monday-Sunday)
- Each day labeled with system theme (Authority, Insight, Tactical, Trend, Proof, Conversation, Vision)
- Post cards showing status: Idea → Draft → Shipped
- "Ship" button to mark posts as published
- Weekly streak tracking

#### 📝 **Journal Capture**
- Quick text entry for capturing insights
- Tag entries: Pain, Lesson, Framework, Trend, Proof
- Convert journal entries to posts with templates

#### 🤖 **Post Templates & AI Assistance** (Ready for integration)
- Daily post type templates
- AI-powered copy tightening (OpenAI integration ready)
- Platform-specific formatting (LinkedIn vs X)

#### 🏆 **Proof Bank**
- Store wins, stats, screenshots, testimonials
- Link proof items to Friday posts
- Quick access from dashboard

#### 📊 **Weekly Review & Analytics** (Structure ready)
- Review checklist
- Consistency streaks
- Engagement tracking

---

## Tech Stack

| Category | Technology |
|----------|-----------|
| **Framework** | Ruby on Rails 8 |
| **Frontend** | TailwindCSS + Hotwire (Turbo + Stimulus) |
| **Database** | PostgreSQL |
| **Authentication** | Devise |
| **Background Jobs** | Sidekiq |
| **AI Integration** | OpenAI API (ruby-openai gem) |
| **Deployment** | Render / Kamal / Docker |

---

## Getting Started

### Prerequisites

- Ruby 3.3.0
- PostgreSQL 14+
- Node.js 18+ (for asset compilation)
- Docker & Docker Compose (for containerized setup)

### Quick Start with Docker (Recommended)

1. **Clone the repository:**
   ```bash
   git clone https://github.com/BigMacUK007/business-content-buddy.git
   cd business-content-buddy
   ```

2. **Copy environment file:**
   ```bash
   cp .env.example .env
   # Edit .env and add your RAILS_MASTER_KEY
   ```

3. **Start with Docker Compose:**
   ```bash
   docker-compose up --build
   ```

4. **Set up the database** (in another terminal):
   ```bash
   docker-compose exec web rails db:create db:migrate
   ```

5. **Visit** `http://localhost:3000`

**Or use the Makefile for one-command setup:**
```bash
make setup  # Complete setup in one command
```

### Local Installation

1. **Clone and install dependencies:**
   ```bash
   git clone https://github.com/BigMacUK007/business-content-buddy.git
   cd business-content-buddy
   bundle install
   ```

2. **Set up the database:**
   ```bash
   rails db:create
   rails db:migrate
   ```

3. **Start the development server:**
   ```bash
   bin/dev
   ```

4. **Visit** `http://localhost:3000`

---

## Documentation

- **[Setup Guide](SETUP_GUIDE.md)** - Detailed local development setup
- **[Docker Setup](DOCKER_SETUP.md)** - Comprehensive Docker guide
- **[Deployment Guide](#deployment-to-render)** - Deploy to production

---

## Environment Variables

Create a `.env` file or set the following environment variables:

```bash
RAILS_MASTER_KEY=<your_master_key>
OPENAI_API_KEY=<your_openai_api_key>
DATABASE_URL=<your_database_url>  # For production
```

---

## Database Schema

### Core Models

| Model | Description | Key Fields |
|-------|-------------|-----------|
| **User** | Authentication and user profile | `name`, `email`, `content_pillars`, `target_audience`, `writing_tone` |
| **Post** | Content posts with status tracking | `title`, `content`, `post_type`, `day_of_week`, `status`, `platform` |
| **JournalEntry** | Quick idea capture | `content`, `audio_url`, `transcription`, `entry_type` |
| **ProofItem** | Wins and testimonials | `title`, `description`, `proof_type`, `value`, `attachment_url` |
| **WeeklyReview** | Weekly reflection and analytics | `week_start`, `posts_count`, `engagement_stats`, `insights` |

#### Post Statuses
- `idea` - Initial concept
- `draft` - Being written
- `shipped` - Published

#### Entry Types
- Pain, Lesson, Framework, Trend, Proof

#### Proof Types
- Testimonial, Metric, Screenshot, Win, Stat, Link

---

## Deployment to Render

This app is configured for easy deployment to Render:

1. Push your code to GitHub
2. Create a new Web Service on Render
3. Connect your GitHub repository
4. Render will automatically detect the `render.yaml` configuration
5. Set the following environment variables in Render:
   - `RAILS_MASTER_KEY` (from `config/master.key`)
   - `OPENAI_API_KEY` (your OpenAI API key)

The build and deployment will happen automatically.

### Alternative Deployment with Kamal

The project includes Kamal configuration for Docker-based deployment:

```bash
kamal setup
kamal deploy
```

---

## Development Roadmap

### ✅ Completed (MVP)
- Rails 8 setup with Hotwire and Tailwind
- User authentication with Devise
- Core models (User, Post, JournalEntry, ProofItem, WeeklyReview)
- Weekly planner dashboard
- Post creation and management
- Tagging system
- Render deployment configuration
- Docker containerization with docker-compose

### 🚧 In Progress
- Journal entry views and conversion to posts
- Proof bank views and management
- Weekly review flow
- OpenAI integration for copy tightening

### 📋 Next Steps
- Voice note transcription (Whisper API)
- Post templates system
- Analytics and charts (Chartkick)
- Sidekiq background jobs setup

### 🔮 Future Enhancements
- AI Trend Scanner
- Collaboration/ghostwriting mode
- Topic heatmap
- AI Accountability Partner
- Platform API integrations (LinkedIn/X)
- Native mobile app

---

## Project Structure

```
business-content-buddy/
├── app/
│   ├── controllers/       # Application controllers
│   ├── models/           # ActiveRecord models
│   ├── views/            # ERB templates
│   └── assets/           # Stylesheets and images
├── config/
│   ├── routes.rb         # Application routes
│   ├── database.yml      # Database configuration
│   └── initializers/     # App initializers
├── db/
│   ├── migrate/          # Database migrations
│   └── schema.rb         # Database schema
├── docker-compose.yml    # Docker Compose configuration
├── Dockerfile            # Production Docker image
├── Dockerfile.dev        # Development Docker image
├── Makefile             # Common development tasks
└── render.yaml          # Render deployment config
```

---

## Common Commands

### Development
```bash
bin/dev                 # Start Rails server + Tailwind watcher
rails console          # Open Rails console
rails routes           # View all routes
```

### Database
```bash
rails db:migrate       # Run migrations
rails db:rollback      # Rollback last migration
rails db:seed          # Seed database
```

### Docker
```bash
make setup            # Complete Docker setup
make up               # Start containers
make down             # Stop containers
make logs             # View logs
make console          # Rails console in container
```

### Code Quality
```bash
bin/rubocop           # Run linter
rails tailwindcss:build  # Compile Tailwind CSS
```

---

## Contributing

This is a personal project, but suggestions and feedback are welcome!

1. Fork the repository
2. Create a feature branch (`git checkout -b feature/amazing-feature`)
3. Commit your changes (`git commit -m 'Add some amazing feature'`)
4. Push to the branch (`git push origin feature/amazing-feature`)
5. Open a Pull Request

---

## License

Copyright © 2025 Ben Macdonald. All rights reserved.

This project is proprietary software. Unauthorized copying, modification, distribution, or use of this software is strictly prohibited.

---

## Support

For questions or support:
- Open an issue on [GitHub Issues](https://github.com/BigMacUK007/business-content-buddy/issues)
- Check the [Setup Guide](SETUP_GUIDE.md) for troubleshooting

---

## Acknowledgments

Built with:
- [Ruby on Rails](https://rubyonrails.org/) - Web framework
- [TailwindCSS](https://tailwindcss.com/) - Utility-first CSS
- [Hotwire](https://hotwired.dev/) - Modern web interactivity
- [Devise](https://github.com/heartcombo/devise) - Authentication
- [OpenAI](https://openai.com/) - AI assistance

---

<div align="center">

**North Star**: *"A calm, guided space for business owners to turn their weekly experiences into consistent, authority-building content — without the overwhelm."*

Made with ❤️ by [Ben Macdonald](https://github.com/BigMacUK007)

</div>
