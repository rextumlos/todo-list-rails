class ApplicationController < ActionController::Base
  before_action :set_timezone

  # TODO: Create a sub-setting to set timezone
  def set_timezone
    if current_user && current_user.time_zone
      Time.zone = current_user.time_zone
    end
  end
end
