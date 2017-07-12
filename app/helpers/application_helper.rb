module ApplicationHelper
  def flash_class(level)
    case level.to_sym
      when :notice then "alert alert-success"
      when :info then "alert alert-info"
      when :warning then "alert alert-warning"
      when :alert then "alert alert-danger"
      when :error then "alert alert-danger"
    end
  end
end
