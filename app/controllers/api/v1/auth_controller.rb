require "googleauth"

class Api::V1::AuthController < ApplicationController
  def google
    token = params[:credential]

    if token.blank?
      return render json: {
        error: "Google credential is required"
      }, status: :bad_request
    end

    begin
      payload = Google::Auth::IDTokens.verify_oidc(
        token,
        aud: ENV.fetch("GOOGLE_CLIENT_ID")
      )
    rescue StandardError => e
      Rails.logger.warn("Google token verification failed: #{e.class}")

      return render json: {
        error: "Invalid Google token"
      }, status: :unauthorized
    end

    email = payload["email"]
    name = payload["name"]
    google_uid = payload["sub"]

    if email.blank? || name.blank? || google_uid.blank?
      return render json: {
        error: "Required Google account information is missing"
      }, status: :unprocessable_entity
    end

    unless payload["email_verified"] == true
      return render json: {
        error: "Google email is not verified"
      }, status: :unauthorized
    end

    user = User.find_or_initialize_by(google_uid: google_uid)

    if user.new_record? && User.exists?(email: email)
      return render json: {
        error: "An account with this email already exists"
      }, status: :conflict
    end

    user.email = email
    user.name = name

    unless user.save
      return render json: {
        errors: user.errors.full_messages
      }, status: :unprocessable_entity
    end

    reset_session
    session[:user_id] = user.id

    render json: {
      message: "Google login successful",
      user: {
        id: user.id,
        email: user.email,
        name: user.name
      }
    }, status: :ok
  end

  def me
    user = User.find_by(id: session[:user_id])

    unless user
      return render json: {
        error: "Not authenticated"
      }, status: :unauthorized
    end

    render json: {
      user: {
        id: user.id,
        email: user.email,
        name: user.name
      }
    }, status: :ok
  end

  def logout
    reset_session

    render json: {
      message: "Logged out successfully"
    }, status: :ok
  end

  def register
    email = params[:ebundle install
bin/rails db:migratemail].to_s.strip.downcase

    if User.exists?(email: email)
      return render json: {
        error: "An account with this email already exists"
      }, status: :conflict
    end

    user = User.new(
      name: params[:name].to_s.strip,
      email: email,
      password: params[:password].to_s
    )

    unless user.save
      return render json: {
        errors: user.errors.full_messages
      }, status: :unprocessable_entity
    end

    reset_session
    session[:user_id] = user.id

    render json: {
      message: "Registration successful",
      user: { id: user.id, email: user.email, name: user.name }
    }, status: :created
  end

  def login
    user = User.find_by(email: params[:email].to_s.strip.downcase)

    unless user&.password_digest.present? && user.authenticate(params[:password].to_s)
      return render json: {
        error: "Invalid email or password"
      }, status: :unauthorized
    end

    reset_session
    session[:user_id] = user.id

    render json: {
      message: "Login successful",
      user: { id: user.id, email: user.email, name: user.name }
    }, status: :ok
  end
end