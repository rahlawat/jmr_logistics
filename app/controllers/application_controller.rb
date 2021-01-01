class ApplicationController < ActionController::Base
  respond_to :html, :pdf
  protect_from_forgery with: :exception
end
