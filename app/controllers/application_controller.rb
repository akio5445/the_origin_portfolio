class ApplicationController < ActionController::Base
  include SessionsHelper
  before_action :logged_in_user

  class Forbidden < ActionController::ActionControllerError; end
  class IpAddressRejected < ActionController::ActionControllerError; end
  # エラーの表示をプロダクト環境のみ変更する
  # concerns/error_handlers参照views/errors参照
  include ErrorHandlers unless Rails.env.development?
  # include ErrorHandlers if Rails.env.productionと同じ
end
