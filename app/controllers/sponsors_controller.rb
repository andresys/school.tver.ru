class SponsorsController < ApplicationController
  def index
    @sponsor = @school.sponsor
  end
end
