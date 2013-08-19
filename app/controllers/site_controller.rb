class SiteController < ApplicationController
  def index
    # Lines
    @lines = Line.all
  end

  def about
  end

end
