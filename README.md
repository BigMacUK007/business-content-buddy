# Business Content Buddy

A calm, guided space for business owners to turn their weekly experiences into consistent, authority-building content — without the overwhelm.

## Overview

Business Content Buddy is a Rails 8 application that helps founders, consultants, and small business owners publish consistent, high-quality social content using an AI-assisted weekly framework. The app transforms your insights and experiences into ready-to-post content that builds authority, trust, and engagement.

## Features

### Core Features (MVP)

1. **Weekly Planner (7-Day Board)**
   - Visual 7-column board (Monday-Sunday)
   - Each day labeled with system theme (Authority, Insight, Tactical, Trend, Proof, Conversation, Vision)
   - Post cards showing status: Idea → Draft → Shipped
   - "Ship" button to mark posts as published
   - Weekly streak tracking

2. **Journal Capture**
   - Quick text entry for capturing insights
   - Tag entries: Pain, Lesson, Framework, Trend, Proof
   - Convert journal entries to posts with templates

3. **Post Templates & AI Assistance** (Ready for integration)
   - Daily post type templates
   - AI-powered copy tightening (OpenAI integration ready)
   - Platform-specific formatting (LinkedIn vs X)

4. **Proof Bank**
   - Store wins, stats, screenshots, testimonials
   - Link proof items to Friday posts
   - Quick access from dashboard

5. **Weekly Review & Analytics** (Structure ready)
   - Review checklist
   - Consistency streaks
   - Engagement tracking

## Tech Stack

- **Framework**: Ruby on Rails 8
- **Frontend**: TailwindCSS + Hotwire (Turbo + Stimulus)
- **Database**: PostgreSQL
- **Authentication**: Devise
- **Background Jobs**: Sidekiq (configured)
- **AI Integration**: OpenAI API (ruby-openai gem)
- **Deployment**: Render

## Getting Started

### Prerequisites

- Ruby 3.3.0
- PostgreSQL
- Node.js (for asset compilation)

### Local Setup

#### Option 1: Docker (Recommended)

1. Clone the repository:
   ```bash
   git clone https://github.com/BigMacUK007/business-content-buddy.git
   cd business-content-buddy
   ```

2. Copy environment file:
   ```bash
   cp .env.example .env
   # Edit .env and add your RAILS_MASTER_KEY
   ```

3. Start with Docker Compose:
   ```bash
   docker-compose up --build
   ```

4. Set up the database (in another terminal):
   ```bash
   docker-compose exec web rails db:create db:migrate
   ```

5. Visit `http://localhost:3000`

**Or use the Makefile:**
```bash
make setup  # Complete setup in one command
```

See [DOCKER_SETUP.md](DOCKER_SETUP.md) for detailed Docker instructions.

#### Option 2: Local Installation

1. Clone the repository:
   ```bash
   git clone https://github.com/BigMacUK007/business-content-buddy.git
   cd business-content-buddy
   ```

2. Install dependencies:
   ```bash
   bundle install
   ```

3. Set up the database:
   ```bash
   rails db:create
   rails db:migrate
   ```

4. Start the development server:
   ```bash
   bin/dev
   ```

5. Visit `http://localhost:3000`

See [SETUP_GUIDE.md](SETUP_GUIDE.md) for detailed local setup instructions.

### Environment Variables

Create a `.env` file or set the following environment variables:

```
RAILS_MASTER_KEY=<your_master_key>
OPENAI_API_KEY=<your_openai_api_key>
DATABASE_URL=<your_database_url> # For production
```

## Database Schema

### Core Models

- **User**: Authentication and user profile
  - `name`, `email`, `content_pillars`, `target_audience`, `writing_tone`

- **Post**: Content posts with status tracking
  - `title`, `content`, `post_type`, `day_of_week`, `status`, `platform`
  - Status: `idea`, `draft`, `shipped`

- **JournalEntry**: Quick idea capture
  - `content`, `audio_url`, `transcription`, `entry_type`
  - Tagged with: pain, lesson, framework, trend, proof

- **ProofItem**: Wins and testimonials
  - `title`, `description`, `proof_type`, `value`, `attachment_url`
  - Types: testimonial, metric, screenshot, win, stat, link

- **WeeklyReview**: Weekly reflection and analytics
  - `week_start`, `posts_count`, `engagement_stats`, `insights`, `focus_next_week`

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

## Development Roadmap

### Completed (MVP)
- ✅ Rails 8 setup with Hotwire and Tailwind
- ✅ User authentication with Devise
- ✅ Core models (User, Post, JournalEntry, ProofItem, WeeklyReview)
- ✅ Weekly planner dashboard
- ✅ Post creation and management
- ✅ Tagging system
- ✅ Render deployment configuration

### Next Steps
- [ ] Journal entry views and conversion to posts
- [ ] Proof bank views and management
- [ ] Weekly review flow
- [ ] OpenAI integration for copy tightening
- [ ] Voice note transcription (Whisper API)
- [ ] Post templates system
- [ ] Analytics and charts (Chartkick)
- [ ] Sidekiq background jobs setup

### Future Enhancements
- AI Trend Scanner
- Collaboration/ghostwriting mode
- Topic heatmap
- AI Accountability Partner
- Platform API integrations (LinkedIn/X)
- Native mobile app

## Contributing

This is a personal project, but suggestions and feedback are welcome! Please open an issue to discuss proposed changes.

## License

Copyright © 2025 Ben Macdonald. All rights reserved.

## Support

For questions or support, please open an issue on GitHub.

---

**North Star**: "A calm, guided space for business owners to turn their weekly experiences into consistent, authority-building content — without the overwhelm."
