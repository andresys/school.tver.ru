class MediaLinksController < ApplicationController
  def index
    @media_link = @school.media_link
  end
end
