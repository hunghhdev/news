class SessionsController < ApplicationController
  def new; end

  def create
    user = User.find_by email: account[:email].downcase

    if user && user.authenticate(account[:password])
      authenticated user
    else
      flash.now[:danger] = t ".errors"
      render :new
    end
  end

  def destroy
    log_out if logged_in?
    redirect_to root_url
  end

  private

  def authenticated user
    log_in user
    account[:remember_me] == "1" ? remember(user) : forget(user)
    redirect_to user
  end
end
