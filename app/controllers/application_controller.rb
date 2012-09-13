class ApplicationController < ActionController::Base
  protect_from_forgery

  # Including spreadsheet to all the controllers
  require 'spreadsheet' 
end
