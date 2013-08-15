class LineController < ApplicationController
  def stats
    # Return JSON
    # Write code to load JSON of the Line with params[:id]
    render json: stats
  end
end
