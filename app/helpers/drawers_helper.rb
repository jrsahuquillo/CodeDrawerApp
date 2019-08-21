module DrawersHelper
  def persisted_codetools(codetools)
    codetools.reject{ |codetool| codetool.new_record? }
  end
end
