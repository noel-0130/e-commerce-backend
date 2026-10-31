# E-Commerce Backend (Ruby on Rails API)

A RESTful API for the E-Commerce application with user authentication, product management, cart, orders, and email verification.

## Tech Stack
- Ruby on Rails 8 (API only)
- PostgreSQL
- ActionMailer with Gmail API
- BCrypt for password hashing
- Rack CORS

## Features
- User registration & login (email + password, Google OAuth)
- Email verification
- Product catalog, categories, and brands
- Shopping cart
- Orders & checkout
- Admin management
- Session-based authentication

## Setup

### 1. Clone the repo
```bash
git clone https://github.com/noel-0130/e-commerce-backend.git
cd e-commerce-backend
```

### 2. Install dependencies
```bash
bundle install
```

### 3. Setup environment variables
Copy `.env.example` to `.env`, `.env.development`, or `.env.production` depending on your environment.

```bash
cp .env.example .env.development
```

Fill in the required values.

### 4. Setup database
```bash
bin/rails db:create db:migrate db:seed
```

### 5. Run the server
```bash
bin/rails server -b 0.0.0.0 -p 3000
```

The API will be available at `http://localhost:3000`

## Environment Files
- `.env.development` - used in development (`RAILS_ENV=development`)
- `.env.production` - used in production (`RAILS_ENV=production`)
- `.env` - fallback

## Links
- Frontend: [https://github.com/noel-0130/e-commerce-frontend](https://github.com/noel-0130/e-commerce-frontend)
- Live Site: [https://noel-llosa.vercel.app/](https://noel-llosa.vercel.app/)
