class SessionsController < ApplicationController
  def new
  end
  
  def create
    user = User.find_by(email: params[:session][:email].downcase)
    if user && user.authenticate(params[:session][:password])
      if user.activated?
        log_in user          #ユーザーのブラウザ内の一時cookiesに暗号化済みのユーザーIDが自動で作成される？
                              #ブラウザを閉じてsession[:user_id]がなくても。ログイン継続できる
        params[:session][:remember_me] == '1' ? remember(user) : forget(user)  # remember user
        redirect_back_or user      # redirect_to user(ユーザーログイン後にユーザー情報のページにリダイレクトする) userはuser_url(user.id）を指している
      else
        message  = "Account not activated. "
        message += "Check your email for the activation link."
        flash[:warning] = message
        redirect_to root_url
      end
    else                    
      flash.now[:danger] = 'Invalid email/password combination'
      render 'new'
    end
  end

  def destroy
    log_out if logged_in?
    redirect_to root_url
  end
end
