# frozen_string_literal: true

class Users::SessionsController < Devise::SessionsController
  skip_before_action :authenticate_user!

  # GET /resource/sign_in
  # def new
  #   super
  # end

  # POST /resource/sign_in
  # def create
  #   super
  # end

  # DELETE /resource/sign_out
  # def destroy
  #   super
  # end

  def new_guest
    user = User.guest
    sign_in user
    redirect_to user_path(user), notice: 'ゲストユーザーとしてログインしました。'
  end

end
