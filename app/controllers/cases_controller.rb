class CasesController < ApplicationController

  def index
  end

  def new
    @case = Case.new
  end

  def create
    @case = Case.new(case_params)
    if @case.save
      flash[:success] = "Case has been created"
      redirect_to cases_path
    else
      flash[:danger] = "Case has not been created"
      render :new
    end
  end

  private

  def case_params
    params.require(:case).permit(:title, :description)
  end
end
