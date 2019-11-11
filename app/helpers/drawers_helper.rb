module DrawersHelper
  def persisted_codetools(codetools)
    codetools.reject{ |codetool| codetool.new_record? }
  end

  def check_active_link(drawer_id)
    'active' if params[:drawer_id].to_i == drawer_id
  end
end
