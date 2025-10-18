# Docker Setup Guide for Business Content Buddy

This guide will help you run the Business Content Buddy application using Docker and Docker Compose.

## Prerequisites

- **Docker** (version 20.10 or higher)
- **Docker Compose** (version 2.0 or higher)

### Install Docker

**macOS:**
- Download and install [Docker Desktop for Mac](https://www.docker.com/products/docker-desktop)

**Windows:**
- Download and install [Docker Desktop for Windows](https://www.docker.com/products/docker-desktop)

**Linux (Ubuntu/Debian):**
```bash
curl -fsSL https://get.docker.com -o get-docker.sh
sudo sh get-docker.sh
sudo usermod -aG docker $USER
```

## Quick Start

### 1. Clone the Repository

```bash
git clone https://github.com/BigMacUK007/business-content-buddy.git
cd business-content-buddy
```

### 2. Set Up Environment Variables

Copy the example environment file:

```bash
cp .env.example .env
```

Edit `.env` and add your configuration:

```bash
# Required: Get this from config/master.key
RAILS_MASTER_KEY=your_actual_master_key

# Optional: For AI features
OPENAI_API_KEY=your_openai_api_key
```

### 3. Build and Start the Containers

```bash
docker-compose up --build
```

This will:
- Build the Docker images
- Start PostgreSQL database
- Start Redis (for background jobs)
- Start the Rails application
- Start Sidekiq (background job processor)
- Start Tailwind CSS watcher

### 4. Set Up the Database

In a new terminal, run:

```bash
docker-compose exec web rails db:create db:migrate
```

### 5. Access the Application

Open your browser and visit:
- **Application**: http://localhost:3000
- **Database**: localhost:5432 (use any PostgreSQL client)
- **Redis**: localhost:6379

## Docker Compose Services

The `docker-compose.yml` file defines the following services:

### 1. **db** (PostgreSQL)
- Image: `postgres:15`
- Port: `5432`
- Database: `business_content_buddy_development`
- Credentials: `postgres/password`

### 2. **redis** (Redis)
- Image: `redis:7-alpine`
- Port: `6379`
- Used for: Sidekiq background jobs, caching

### 3. **web** (Rails Application)
- Port: `3000`
- Command: Rails server
- Depends on: db, redis

### 4. **sidekiq** (Background Jobs)
- Command: Sidekiq worker
- Depends on: db, redis
- Processes: AI calls, email sending, etc.

### 5. **tailwind** (CSS Watcher)
- Command: Tailwind CSS watcher
- Watches for CSS changes and recompiles

## Common Docker Commands

### Start Services

```bash
# Start all services in foreground
docker-compose up

# Start all services in background (detached mode)
docker-compose up -d

# Start specific service
docker-compose up web
```

### Stop Services

```bash
# Stop all services
docker-compose down

# Stop and remove volumes (WARNING: deletes database data)
docker-compose down -v
```

### View Logs

```bash
# View all logs
docker-compose logs

# View logs for specific service
docker-compose logs web

# Follow logs in real-time
docker-compose logs -f web
```

### Execute Commands in Containers

```bash
# Open Rails console
docker-compose exec web rails console

# Run migrations
docker-compose exec web rails db:migrate

# Run seeds
docker-compose exec web rails db:seed

# Open bash shell
docker-compose exec web bash
```

### Rebuild Containers

```bash
# Rebuild all containers
docker-compose build

# Rebuild specific service
docker-compose build web

# Rebuild and restart
docker-compose up --build
```

## Development Workflow

### 1. Code Changes

Your local code is mounted into the container via volumes. Changes to Ruby files will be reflected immediately (with Rails auto-reloading).

### 2. Adding Gems

When you add a new gem to the Gemfile:

```bash
# Rebuild the container
docker-compose build web

# Restart services
docker-compose up
```

### 3. Database Changes

```bash
# Create a new migration
docker-compose exec web rails generate migration AddFieldToModel

# Run migrations
docker-compose exec web rails db:migrate

# Rollback migration
docker-compose exec web rails db:rollback
```

### 4. Running Tests

```bash
# Run all tests
docker-compose exec web rails test

# Run specific test
docker-compose exec web rails test test/models/user_test.rb
```

### 5. Asset Changes

Tailwind CSS changes are automatically watched and recompiled by the `tailwind` service.

## Troubleshooting

### Port Already in Use

If you see "port already in use" errors:

```bash
# Check what's using the port
lsof -i :3000

# Kill the process or change the port in docker-compose.yml
```

### Database Connection Issues

```bash
# Check if database is running
docker-compose ps

# Restart database
docker-compose restart db

# Check database logs
docker-compose logs db
```

### Permission Issues

```bash
# Fix file permissions
sudo chown -R $USER:$USER .

# Or run as root (not recommended)
docker-compose exec -u root web bash
```

### Container Won't Start

```bash
# View detailed logs
docker-compose logs web

# Remove old containers and volumes
docker-compose down -v

# Rebuild from scratch
docker-compose build --no-cache
docker-compose up
```

### Bundle Install Fails

```bash
# Clear bundle cache
docker-compose down
docker volume rm business-content-buddy_bundle_cache
docker-compose build --no-cache
docker-compose up
```

## Production Deployment with Docker

For production deployment, use the main `Dockerfile`:

### Build Production Image

```bash
docker build -t business-content-buddy:latest .
```

### Run Production Container

```bash
docker run -d \
  -p 80:80 \
  -e RAILS_MASTER_KEY=your_master_key \
  -e DATABASE_URL=your_production_db_url \
  -e OPENAI_API_KEY=your_api_key \
  --name business-content-buddy \
  business-content-buddy:latest
```

### Using Docker Compose for Production

Create a `docker-compose.prod.yml`:

```yaml
version: '3.8'

services:
  web:
    build:
      context: .
      dockerfile: Dockerfile
    ports:
      - "80:80"
    environment:
      RAILS_MASTER_KEY: ${RAILS_MASTER_KEY}
      DATABASE_URL: ${DATABASE_URL}
      OPENAI_API_KEY: ${OPENAI_API_KEY}
      RAILS_ENV: production
    depends_on:
      - db
      - redis

  db:
    image: postgres:15
    environment:
      POSTGRES_PASSWORD: ${POSTGRES_PASSWORD}
    volumes:
      - postgres_data:/var/lib/postgresql/data

  redis:
    image: redis:7-alpine
    volumes:
      - redis_data:/data

volumes:
  postgres_data:
  redis_data:
```

Run with:

```bash
docker-compose -f docker-compose.prod.yml up -d
```

## Docker vs Local Development

### Advantages of Docker

✅ **Consistent Environment**: Same setup across all machines
✅ **Easy Setup**: No need to install Ruby, PostgreSQL, Redis locally
✅ **Isolation**: Doesn't interfere with other projects
✅ **Production Parity**: Development matches production environment
✅ **Easy Cleanup**: Remove everything with one command

### Disadvantages of Docker

❌ **Performance**: Slightly slower on macOS/Windows (file system overhead)
❌ **Complexity**: Additional layer to understand
❌ **Resource Usage**: Uses more RAM and disk space
❌ **Debugging**: Can be harder to debug issues inside containers

## Best Practices

1. **Use .env files**: Never commit sensitive data
2. **Volume mounts**: Use volumes for persistent data
3. **Health checks**: Ensure services are ready before starting dependent services
4. **Logs**: Regularly check logs for issues
5. **Updates**: Keep Docker images updated
6. **Cleanup**: Regularly clean up unused containers and images

```bash
# Remove unused containers
docker system prune

# Remove unused volumes
docker volume prune

# Remove unused images
docker image prune
```

## Additional Resources

- [Docker Documentation](https://docs.docker.com/)
- [Docker Compose Documentation](https://docs.docker.com/compose/)
- [Rails Docker Guide](https://guides.rubyonrails.org/getting_started_with_devcontainer.html)
- [PostgreSQL Docker Hub](https://hub.docker.com/_/postgres)
- [Redis Docker Hub](https://hub.docker.com/_/redis)

## Getting Help

If you encounter issues:

1. Check the logs: `docker-compose logs`
2. Verify services are running: `docker-compose ps`
3. Try rebuilding: `docker-compose build --no-cache`
4. Check Docker resources: Ensure Docker has enough memory/CPU allocated

---

**Happy Dockerizing! 🐳**

