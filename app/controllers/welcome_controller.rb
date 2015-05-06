class WelcomeController < ApplicationController
  def index
    @tenwikis=Wiki.where(:private=>false).first(10)
  end
  def about
  end
end
