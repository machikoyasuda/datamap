class SiteController < ApplicationController
  def index
    @lines = Line.all
  end
end
