class SessionsController < ApplicationController
  def google_callback
    auth = request.env["omniauth.auth"]

    user = User.find_or_initialize_by(
      google_uid: auth.dig("uid")
    )

    user.email = auth.dig("info", "email")
    user.name = auth.dig("info", "name")

    unless user.save
      return render json: {
        errors: user.errors.full_messages
      }, status: :unprocessable_entity
    end

    reset_session
    session[:user_id] = user.id

    render json: {
      message: "Login successful",
      user: {
        id: user.id,
        name: user.name,
        email: user.email
      }
    }, status: :ok
  end

  def show
    user = current_user

    unless user
      return render json: {
        error: "Not authenticated"
      }, status: :unauthorized
    end

    render json: {
      id: user.id,
      name: user.name,
      email: user.email
    }
  end

  def destroy
    reset_session

    render json: {
      message: "Logged out successfully"
    }
  end

  def failure
    render json: {
      error: "Google authentication failed"
    }, status: :unauthorized
  end

  private

  def current_user
    User.find_by(id: session[:user_id])
  end
end