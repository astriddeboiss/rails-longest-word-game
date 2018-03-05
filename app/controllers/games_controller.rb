require 'open-uri'
require 'json'

class GamesController < ApplicationController

  def new
    @letters = ('a'..'z').to_a.sample(10)
  end

  def score
    @attempt = params[:attempt]
   if @attempt.chars.all? { |letter| @attemps.count(letter) <= @letters.count(letter) }
     if english_word?(attempt)
       "well done"
     else
       "not an english word"
     end
   else
      "not in the grid"
   end
  end


def run_game(attempt)
  score_and_message = score_and_message(attempt, grid, result[:time])
  result[:score] = score_and_message.first
  result[:message] = score_and_message.last
  result
end



def english_word?(word)
  response = open("https://wagon-dictionary.herokuapp.com/#{word}")
  json = JSON.parse(response.read)
  return json['found']
end
