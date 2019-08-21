class CodetoolsController < ApplicationController
  before_action :set_drawer
  
  def create
    @codetool = @drawer.codetools.build(codetool_params)
    @codetool.user = current_user

    if @codetool.save
      flash[:notice] = "Codetool has been created"
    else
      flash[:alert] = "Codetool hast not been created"
    end
    redirect_to drawer_path(@drawer)
  end

  private

  def codetool_params
    params.require(:codetool).permit(:title, :content)
  end

  def set_drawer
    @drawer = Drawer.find(params[:drawer_id])
  end
end
