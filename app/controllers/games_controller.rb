require 'open-uri'
require 'json'

class GamesController < ApplicationController

  def new
    @letters = ('a'..'z').to_a.sample(10)
  end

  def score
    @letters = params[:letters].split
    @attempt = params[:attempt]
   if @attempt.chars.all? { |letter| @attempt.count(letter) <= @letters.count(letter) }
     if english_word?(@attempt)
       @score = "Well done"
     else
        @score = "Not an English word"
     end
   else
       @score = "Not in the grid"
   end
  end
end

def english_word?(word)
  response = open("https://wagon-dictionary.herokuapp.com/#{word}")
  json = JSON.parse(response.read)
  return json['found']
end
