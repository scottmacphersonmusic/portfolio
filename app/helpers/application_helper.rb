module ApplicationHelper
  # translate Rails flash levels to appropriate Zurb Foundation css classes
  def flash_class(level)
    level == :notice ? "info" : level.to_s
  end
end
