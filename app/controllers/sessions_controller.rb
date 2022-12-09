class SessionsController < ApplicationController
  # フィルターをスキップする
  skip_before_action :login_required

  def new
  end

  def create
    user = User.find_by(email: session_params[:email])  # 検索の際に「email:」のように指定する必要がある

    if user&.authenticate(session_params[:password])
      session[:user_id] = user.id
      redirect_to root_url, notice: 'ログインしました。'
    else
      render :new
    end
  end

  def destroy
    # sessionの情報を全て削除する
    reset_session
    redirect_to root_url, notice: 'ログアウトしました。'
  end

  private
  def session_params
    params.require(:session).permit(:email, :password)
  end
end
