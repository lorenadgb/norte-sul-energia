module ApplicationHelper

  def current_class?(test_path, test_controller_name = nil)
    return 'active' if test_controller_name == 'contacts' && test_path == '/contacts/new'
    return 'active' if test_controller_name == 'calculadora' && test_path == 'calculadora'

    action_name == test_path ? 'active' : ''
  end

  def carousel_item(number, pag)
    number == pag ? 'active' : ''
  end

  def flash_class(level)
    case level
    when :notice then "alert alert-info"
    when :success then "alert alert-success"
    when :error then "alert alert-error"
    when :alert then "alert alert-error"
    end
  end

  def number_to_currency(value)
    if value == 0 or value.blank?
      raw "&ndash;"
    else
      ActionController::Base.helpers.number_to_currency(value)
    end
  end

end
