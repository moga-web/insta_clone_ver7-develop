class UserSessionsController < ApplicationController
  def new; end

  def create; end

  def destroy
    logout
    redirect_to login_path, success: 'ログアウトしました', status: :see_other
  end
end
