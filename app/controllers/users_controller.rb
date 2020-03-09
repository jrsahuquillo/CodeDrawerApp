class UsersController < ApplicationController

  def public_codetools
    @user = User.find(params[:id])
    @public_codetools = @user.codetools.where(public: true)
  end

end
