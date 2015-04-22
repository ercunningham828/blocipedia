class WelcomeController < ApplicationController
  def index
    @tenwikis=Wiki.first(10)
  end
  def about
  end
end
