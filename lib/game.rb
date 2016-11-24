#!/usr/bin/env ruby

require_relative 'deck'
require_relative 'hand'
require_relative 'player'
require_relative 'card'

class Game
  def initialize
    @deck = Deck.new
    @deck.shuffle!
    @player_1 = Player.new("Aaron", 100)
    @player_2 = Player.new("Bob", 100)
    @round_pot = 0
    @ante = nil
  end

  def start
    until game_over?
      play_round
    end
  end

  def game_over?
    @player_1.pot <= 0 || @player_2.pot <= 0
  end

  def play_round
    deal_hands
    take_card_changes
    take_bets
    pay_pot
    return_hands
    @deck.shuffle!
  end

  def take_bets
    @round_pot += @player_1.bet_money(5)
    @round_pot += @player_2.bet_money(5)
  end

  def take_card_changes
    puts "#{@player_1.name} has #{@player_1.pot}:"
    @player_1.hand.display
    player_1_input = @player_1.discard_prompt
    @deck.return(@player_1.hand.discard(player_1_input))
    @player_1.hand.take(@deck.take(player_1_input.length))
    @player_1.hand.display
    puts "Next Player.."
    puts
    puts "#{@player_2.name} has #{@player_2.pot}:"
    @player_1.hand.display
    player_2_input = @player_2.discard_prompt
    @deck.return(@player_2.hand.discard(player_2_input))
    @player_2.hand.take(@deck.take(player_2_input.length))
    @player_2.hand.display
  end

  def return_hands
    @deck.return(@player_1.return_hand)
    @deck.return(@player_2.return_hand)
  end

  def deal_hands
    @player_1.take_hand(Hand.new(@deck.take(5)))
    @player_2.take_hand(Hand.new(@deck.take(5)))
  end

  def pay_pot
    case @player_1.hand == @player_2.hand
    when -1
      puts "Player 2 won! The pot was: #{@round_pot}"
      @player_2.get_money(@round_pot)
    when 0
      puts "DRAW! The total pot was returned: #{@round_pot}"
      @player_1.get_money(@round_pot / 2)
      @player_2.get_money(@round_pot / 2)
    when 1
      puts "Player 1 won! The pot was: #{@round_pot}"
      @player_1.get_money(@round_pot)
    end
    @round_pot = 0
  end

  def increase_pot

  end
end

if __FILE__ == $PROGRAM_NAME
  game = Game.new.start
end
