class ApplicationController < ActionController::Base
  include SessionsHelper
  before_action :logged_in_user

  class ApplicationController < ActionController::Base
    rescue_from StandardError, with: :rescue500

    private def rescue500
      render "errors/internal_server_error", status: 500
    end
  end
end
