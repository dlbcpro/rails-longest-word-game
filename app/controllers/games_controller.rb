require 'open-uri'
require 'json'

class GamesController < ApplicationController
  def new
    @letters = (0...10).map { ('A'..'Z').to_a.sample }
  end

def included?(guess, grid)
  @input_word.chars.all? { |letter| @input_word.count(letter) <= @letters.count(letter) }
end

  def score
    @input_word = params[:input_word]
    if english_word?(@input_word)
      @response = "well done"
    else
      @response = "This is not an english word"
    end
  end

  def english_word?(word)
    response = open("https://wagon-dictionary.herokuapp.com/#{word}")
    json = JSON.parse(response.read)
    return json['found']
  end
end
