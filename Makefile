.PHONY: help build up down restart logs shell console db-create db-migrate db-seed db-reset clean

help: ## Show this help message
	@echo 'Usage: make [target]'
	@echo ''
	@echo 'Available targets:'
	@awk 'BEGIN {FS = ":.*?## "} /^[a-zA-Z_-]+:.*?## / {printf "  %-15s %s\n", $$1, $$2}' $(MAKEFILE_LIST)

build: ## Build Docker images
	docker-compose build

up: ## Start all services
	docker-compose up

up-d: ## Start all services in detached mode
	docker-compose up -d

down: ## Stop all services
	docker-compose down

restart: ## Restart all services
	docker-compose restart

logs: ## View logs from all services
	docker-compose logs -f

logs-web: ## View logs from web service
	docker-compose logs -f web

shell: ## Open bash shell in web container
	docker-compose exec web bash

console: ## Open Rails console
	docker-compose exec web rails console

db-create: ## Create database
	docker-compose exec web rails db:create

db-migrate: ## Run database migrations
	docker-compose exec web rails db:migrate

db-seed: ## Seed database
	docker-compose exec web rails db:seed

db-reset: ## Reset database (drop, create, migrate, seed)
	docker-compose exec web rails db:drop db:create db:migrate db:seed

db-rollback: ## Rollback last migration
	docker-compose exec web rails db:rollback

test: ## Run tests
	docker-compose exec web rails test

clean: ## Remove all containers, volumes, and images
	docker-compose down -v
	docker system prune -f

setup: build up-d db-create db-migrate ## Complete setup (build, start, create DB, migrate)
	@echo "Setup complete! Visit http://localhost:3000"

.DEFAULT_GOAL := help

