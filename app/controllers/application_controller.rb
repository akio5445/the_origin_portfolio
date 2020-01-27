class ApplicationController < ActionController::Base
  include SessionsHelper
  before_action :logged_in_user

  class Forbidden < ActionController::ActionControllerError; end
  class IpAddressRejected < ActionController::ActionControllerError; end

  rescue_from StandardError, with: :rescue500
  rescue_from ApplicationController::Forbidden, with: :rescue403
  rescue_from ApplicationController::IpAddressRejected, with: :rescue403


  private def rescue403(e)
    @exception = e
    render "errors/forbidden", status: 403
    # 403は要求されらリソースがwebサイトに存在するがなんらかの理由でアクセス拒否された時
  end

  private def rescue500(e)
    render "errors/internal_server_error", status: 500
    #　500は何らかのエラーが発生してる時
  end
  # ActionController::ActionControllerError < StandardError < Exception
end
