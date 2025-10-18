# Setup Guide for Business Content Buddy

This guide will help you get the Business Content Buddy application running on your local machine for development and testing.

## Prerequisites

Before you begin, ensure you have the following installed:

- **Ruby 3.3.0** (use rbenv or rvm)
- **PostgreSQL 12+**
- **Node.js 18+** (for asset compilation)
- **Git**

## Step 1: Clone the Repository

```bash
git clone https://github.com/BigMacUK007/business-content-buddy.git
cd business-content-buddy
```

## Step 2: Install Ruby Dependencies

```bash
bundle install
```

If you encounter any issues with native extensions (like pg gem), ensure you have PostgreSQL development headers installed:

**macOS:**
```bash
brew install postgresql
```

**Ubuntu/Debian:**
```bash
sudo apt-get install postgresql postgresql-contrib libpq-dev
```

## Step 3: Set Up the Database

### Configure Database Connection

The app is configured to use PostgreSQL. Update `config/database.yml` if needed with your local PostgreSQL credentials.

Default development configuration:
```yaml
development:
  adapter: postgresql
  encoding: unicode
  database: business_content_buddy_development
  pool: 5
  username: postgres  # Update if different
  password:           # Add your password if needed
  host: localhost
```

### Create and Migrate Database

```bash
rails db:create
rails db:migrate
```

### (Optional) Seed Sample Data

```bash
rails db:seed
```

## Step 4: Install JavaScript Dependencies

The app uses importmap, so no separate npm install is needed. However, ensure Tailwind CSS is properly set up:

```bash
rails tailwindcss:install
```

## Step 5: Environment Variables

Create a `.env` file in the root directory (optional for local development):

```bash
# .env
OPENAI_API_KEY=your_openai_api_key_here
```

**Note:** The `RAILS_MASTER_KEY` is already in `config/master.key` (if it exists). If not, Rails will generate one automatically.

## Step 6: Start the Development Server

Use the Procfile.dev to start both Rails and Tailwind CSS watcher:

```bash
bin/dev
```

This will start:
- Rails server on `http://localhost:3000`
- Tailwind CSS watcher for live style updates

**Alternative:** Start Rails server only:
```bash
rails server
```

## Step 7: Create Your First User

1. Visit `http://localhost:3000`
2. Click "Sign up"
3. Enter your details:
   - Name
   - Email
   - Password
4. You'll be redirected to the dashboard

## Project Structure

```
business-content-buddy/
├── app/
│   ├── controllers/       # Application controllers
│   │   ├── dashboard_controller.rb
│   │   ├── posts_controller.rb
│   │   ├── journal_entries_controller.rb
│   │   ├── proof_items_controller.rb
│   │   └── weekly_reviews_controller.rb
│   ├── models/           # ActiveRecord models
│   │   ├── user.rb
│   │   ├── post.rb
│   │   ├── journal_entry.rb
│   │   ├── proof_item.rb
│   │   └── weekly_review.rb
│   ├── views/            # ERB templates
│   │   ├── dashboard/
│   │   ├── posts/
│   │   └── layouts/
│   └── assets/           # Stylesheets and images
├── config/
│   ├── routes.rb         # Application routes
│   ├── database.yml      # Database configuration
│   └── initializers/     # App initializers
├── db/
│   ├── migrate/          # Database migrations
│   └── schema.rb         # Database schema
└── public/               # Static files
```

## Common Development Tasks

### Run Migrations

```bash
rails db:migrate
```

### Rollback Migration

```bash
rails db:rollback
```

### Open Rails Console

```bash
rails console
```

### Check Routes

```bash
rails routes
```

### Run Linter (RuboCop)

```bash
bin/rubocop
```

### Compile Tailwind CSS

```bash
rails tailwindcss:build
```

## Testing the Application

### Create a Test Post

1. Log in to the dashboard
2. Click "+ Add Post" under any day
3. Fill in the form:
   - Title: "My first authority post"
   - Day of Week: Monday
   - Post Type: Authority
   - Content: Your post content
   - Platform: LinkedIn
4. Click "Create Post"
5. You'll see it appear on the dashboard
6. Click "Ship" to mark it as published

### Test the Weekly Planner

The dashboard shows a 7-column board representing Monday through Sunday. Each column:
- Shows the day name and post type theme
- Displays posts for that day
- Has an "+ Add Post" button
- Shows post status (draft/shipped)

### Test Streak Tracking

The streak counter appears at the top of the dashboard. It counts consecutive weeks where you've shipped at least 4 posts.

## Troubleshooting

### Database Connection Issues

If you see `PG::ConnectionBad`:
1. Ensure PostgreSQL is running: `pg_ctl status`
2. Check your database.yml credentials
3. Try: `rails db:create`

### Asset Compilation Issues

If styles aren't loading:
```bash
rails tailwindcss:build
rails assets:precompile
```

### Port Already in Use

If port 3000 is taken:
```bash
rails server -p 3001
```

### Missing Dependencies

```bash
bundle install
bundle update
```

## Next Steps for Development

### Implement Missing Features

1. **Journal Entry Views**
   - Create index, new, and create views
   - Add "Convert to Post" functionality

2. **Proof Bank Views**
   - Build CRUD interface for proof items
   - Add file upload support

3. **Weekly Review Flow**
   - Create review form
   - Add analytics charts (Chartkick)

4. **AI Integration**
   - Implement OpenAI API calls for copy tightening
   - Add Whisper API for voice transcription

5. **Background Jobs**
   - Set up Sidekiq for async processing
   - Add Redis dependency

### Recommended Gems to Add

```ruby
# For file uploads
gem 'aws-sdk-s3'

# For background processing
gem 'redis'

# For testing
gem 'rspec-rails'
gem 'factory_bot_rails'
gem 'faker'
```

## Deployment to Render

When you're ready to deploy:

1. Push your code to GitHub
2. Go to [Render Dashboard](https://dashboard.render.com)
3. Create a new Web Service
4. Connect your GitHub repository
5. Render will detect `render.yaml` automatically
6. Set environment variables:
   - `RAILS_MASTER_KEY` (from `config/master.key`)
   - `OPENAI_API_KEY`
7. Deploy!

## Getting Help

- Check the [README.md](README.md) for project overview
- Review the PRD in the original requirements document
- Open an issue on GitHub for bugs or questions

## Development Tips

1. **Use Rails Console**: `rails console` is your friend for testing models and queries
2. **Check Logs**: `tail -f log/development.log` to see what's happening
3. **Use Pry**: Add `binding.pry` in your code for debugging
4. **Commit Often**: Make small, focused commits with clear messages
5. **Test in Browser**: Use Chrome DevTools to inspect Turbo/Stimulus behavior

---

Happy coding! 🚀

**Remember the North Star**: "A calm, guided space for business owners to turn their weekly experiences into consistent, authority-building content — without the overwhelm."

