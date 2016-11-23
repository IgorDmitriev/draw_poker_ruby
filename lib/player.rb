class Player
  attr_reader :name, :pot

  def initialize(name, pot)
    @name = name
    @pot = pot
    @hand = nil
  end

  def bet_money(amount)
  end

  def lose_money(amount)

  def take_hand(hand)
  end

  def return_hand(hand)
  end
end
