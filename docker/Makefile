.PHONY: install install-dev test run build docker-build docker-test docker-run lint format clean

install:
	pip install .

install-dev:
	pip install ".[test]"

test:
	pytest tests/ -v

run:
	uvicorn src.main:app --reload --host 0.0.0.0 --port 8029

build:
	docker build -t app:latest .

docker-build:
	docker-compose build

docker-test:
	docker-compose run --rm tests

docker-run:
	docker-compose up app db

docker-run-detached:
	docker-compose up -d app db

docker-down:
	docker-compose down -v

docker-logs:
	docker-compose logs -f app

format:
	black src/ tests/
	isort src/ tests/

lint:
	flake8 src/ tests/
	mypy src/

clean:
	find . -type f -name "*.pyc" -delete
	find . -type d -name "__pycache__" -delete
	rm -rf .pytest_cache .coverage htmlcov dist build *.egg-info

check: lint test

dev: install-dev format lint test run

prod: clean build docker-test