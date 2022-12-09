class ApplicationController < ActionController::Base
  # 全てのビューから使える様にする
  helper_method :current_user
  # フィルター
  before_action :login_required

  private

  # 全てのコントローラで使える様にする
  def current_user
    @current_user ||= User.find_by(id: session[:user_id]) if session[:user_id]
  end

  # ログインしていなければタスク管理を利用できなくする
  def login_required
    redirect_to login_url unless current_user
  end
end
