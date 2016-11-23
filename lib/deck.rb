require_relative 'card'

class Deck
  attr_reader :cards

  SUITS = [:spade, :diamond, :club, :heart].freeze
  VALUES = (1..13).to_a.freeze

  def self.create_new_deck
    cards = []

    SUITS.each do |suit|
      VALUES.each do |value|
        cards << Card.new(value, suit)
      end
    end
    cards
  end

  def initialize
    @cards = Deck.create_new_deck
  end

  def take(n = 1)
    @cards.shift(n)
  end

  def return(cards)
    @cards += cards
  end

  def shuffle!
    @cards.shuffle!
    @cards
  end
end
