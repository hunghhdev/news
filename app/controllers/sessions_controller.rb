class SessionsController < ApplicationController
  def new; end

  def create
    user = User.find_by email: account[:email].downcase

    if user && user.authenticate(account[:password])
      log_in user
      redirect_to user
    else
      flash.now[:danger] = t ".errors"
      render :new
    end
  end

  def destroy
    log_out
    redirect_to root_url
  end
end
