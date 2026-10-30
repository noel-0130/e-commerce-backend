# TechHub — E-commerce Backend API 1

Backend API for TechHub, an e-commerce platform built with Ruby on Rails and PostgreSQL.

🌐 **Frontend Website:** https://noel-llosa.vercel.app/  
📦 **Frontend Repository:** https://github.com/noel-0130/e-commerce-frontend

## Features

- User registration
- Email and password authentication
- Google OAuth authentication
- Email verification
- Resend verification email
- Session-based authentication
- Product management
- Shopping cart management
- Checkout
- Cash on Delivery (COD)
- Order management
- Stock management
- PostgreSQL database
- Gmail API email delivery

## Tech Stack

- Ruby 3.4.9
- Ruby on Rails 8.1.4
- PostgreSQL
- Puma
- Active Record
- BCrypt
- Google Auth
- Rack CORS
- Active Record Session Store
- Gmail API

## Installation

### 1. Clone the Repository

```bash
git clone https://github.com/noel-0130/e-commerce-backend.git
cd e-commerce-backend
```

### 2. Install Dependencies

```bash
bundle install
```

### 3. Configure Environment Variables

Create a `.env` file in the project root.

```env
FRONTEND_URL=http://localhost:5173
API_URL=http://localhost:3000

GOOGLE_CLIENT_ID=your_google_client_id

DATABASE_URL=your_database_url

GMAIL_CLIENT_ID=your_gmail_client_id
GMAIL_CLIENT_SECRET=your_gmail_client_secret
GMAIL_REFRESH_TOKEN=your_gmail_refresh_token
GMAIL_SENDER_EMAIL=your_email@gmail.com
```

Replace the placeholder values with your actual credentials.

**Important:** Never commit your `.env` file or expose your private credentials.

### 4. Prepare the Database

```bash
bin/rails db:prepare
```

### 5. Seed the Database

```bash
bin/rails db:seed
```

### 6. Start the Rails Server

```bash
bin/rails server
```

The backend API will run at:

http://localhost:3000

## API Endpoints

### Authentication

| Method | Endpoint | Description |
|---|---|---|
| POST | `/register` | Register a new user |
| POST | `/login` | User login |
| DELETE | `/logout` | User logout |
| GET | `/me` | Get authenticated user |
| POST | `/google_login` | Google authentication |
| GET | `/verify_email` | Verify email address |

### Products

Product endpoints are used to retrieve and manage product information.

### Cart

Cart endpoints are used to manage shopping cart items.

### Orders

Order endpoints are used for checkout and order management.

## Frontend Integration

This backend is connected to the TechHub frontend.

Frontend repository:

https://github.com/noel-0130/e-commerce-frontend

Live website:

https://noel-llosa.vercel.app/

## Security

- Password hashing with BCrypt
- Session-based authentication
- HTTP-only session cookies
- Secure cookies in production
- CORS configuration
- Email verification
- Environment variables for sensitive credentials

## Deployment

The backend requires a configured PostgreSQL database and production environment variables.

Make sure the frontend URL is allowed in the backend CORS configuration.

## Author

Noel A. Llosa