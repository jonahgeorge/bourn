class PagesController < ApplicationController
  skip_before_action :require_email_confirmation

  def about
  end

  def policies
  end
end
