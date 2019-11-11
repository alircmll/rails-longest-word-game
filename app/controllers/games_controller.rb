require 'open-uri'
require 'json'

class GamesController < ApplicationController
  def new
    @letters = [* 'A'..'Z'].sample(10)
  end

  def score
    @word = params[:word]
    @result = english_word?(@word)
    @test = include?(@word, @letters)
      if @result == false
        @result = "Sorry but #{@word} is not an English word"
      else
        @result = "congratulations"
     end

     if @test == false
        @test = "Sorry but #{@word} can't be build from #{@letters}"
      end
  end

  def english_word?(word)
    url = "https://wagon-dictionary.herokuapp.com/#{word}"
    response = open(url).read
    @words = JSON.parse(response)
     @words["found"]
  end

  def include?(word, letters)
    word.split("").include?(letters)
  end
end
