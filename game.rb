require './players.rb'

class Game
  OPERATORS = [:+, :-, :*, :/].freeze

  def initialize(p1, p2)
    @current_player = true
    @p1 = p1
    @p2 = p2
    @game_over = false

    puts "Starting new game.."
  end

  def start
    while !@game_over
      @current_player ? generate_question(@p1) : generate_question(@p2)

      if @game_over
        game_over
      else
        puts "---NEW TURN---"
        @current_player = !@current_player
      end
    end    
  end

  def generate_question(player)
    num1 = rand(1..20)
    num2 = rand(1..20)
    operator = OPERATORS.sample
    answer = num1.send(operator, num2)
   
    puts "#{player.name}: what does #{num1} #{operator} #{num2} equal?"

    input = gets.chomp.to_i

    if input == answer
      puts "#{player.name}: correct!"
    else
      puts "#{player.name}: wrong!"
      player.score -= 1
    end

    display_scores

    @game_over = true if player.score.zero?
  end

  def game_over
    winner = @current_player ? "Player 2" : "Player 1"
    score = @current_player ? @p2.score : @p1.score

    puts "#{winner} wins, score: #{score}/3"
    puts "-<-<-<-GAME OVER->->->-"
  end

  def display_scores
    puts "#{@p1.name}: #{@p1.score}/3 --- #{@p2.name}: #{@p2.score}/3"
  end
end