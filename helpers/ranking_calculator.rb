# encoding: utf-8
class RankingCalculator

  def self.calculate(score_modifier,result,own_rating,opponent_rating)
    result_modifier = 1

    if result == 1
      result_modifier = 0.5
    elsif result == 0
      result_modifier = 0
    end

    puts "Result modifier: #{result_modifier}"
    points = 60 * ( result_modifier - ( 1 / 10**((opponent_rating - own_rating)/400))) * score_modifier

    return own_rating + points
  end

end