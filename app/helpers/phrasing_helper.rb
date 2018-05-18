module PhrasingHelper
  # You must implement the can_edit_phrases? method.
  # Example:
  #
  def can_edit_phrases?
    if current_employee
      current_employee.admin
    end
  end

  # def can_edit_phrases?
  #   raise NotImplementedError.new("You must implement the can_edit_phrases? method")
  # end
end
