class CasesController < ApplicationController

  def index
  end

  def new
    @case = Case.new
  end

  def create
    @case = Case.new(case_params)
    @case.save
    flash[:success] = "Case has been created"
    redirect_to cases_path
  end

  private

  def case_params
    params.require(:case).permit(:title, :description)
  end
end
