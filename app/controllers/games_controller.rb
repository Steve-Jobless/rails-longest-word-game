require 'open-uri'
class GamesController < ApplicationController
  def new
    @letters = (10.times.map { [*'A'..'Z'].sample })
  end

  def score
    @word = params[:word]
    url = "https://wagon-dictionary.herokuapp.com/#{@word}"
    word_serialized = URI.open(url).read
    word = JSON.parse(word_serialized)
    @word_found = word["found"]
    @letters = params[:letters].split
    @part_of = is_in_grid?(@letters.sort, @word.upcase.chars)
  end

  private
  def is_in_grid?(grid_letters, player_letters)
    # grid_letters = @letters.sort
    # player_letters = @word.upcase.chars
    player_letters.all? { |letter| grid_letters.include? letter }
  end
end
