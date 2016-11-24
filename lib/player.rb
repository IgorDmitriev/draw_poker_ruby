class Player
  attr_reader :name, :pot, :hand

  def initialize(name, pot)
    @name = name
    @pot = pot
    @hand = nil
  end

  def discard_prompt
    puts "What cards to discard? idx,idx.."
    valid_prompt?(gets.chomp)
  rescue => e
    puts e.message
    retry
  end

  def valid_prompt?(user_input)
    split = user_input.split(",").map { |x| Integer(x) }
    raise "Too many cards" if split.length > 3
    raise "no duplicates" unless split.uniq.length == split.length
    raise "can't find this one" unless split.all? { |idx| idx.between?(0,4) }
    split
  end

  def get_action
    puts "What do you want to do?"
    puts "F:old / R:aise / C:heck"
    input = gets.chomp.downcase
    case input
    when "f"
      :fold
    when "r"
      amount_prompt
    when "c"
      :check
    end
  end

  def amount_prompt
    puts "What amount?"
    bet_money(Integer(gets.chomp))
  rescue => e
    puts e.message
    retry
  end

  def bet_money(amount)
    raise "Can't bet negative amounts" if amount < 0
    raise 'Not enough money' if amount > @pot
    @pot -= amount
    amount
  rescue => e
    puts e.message
    retry
  end

  def get_money(amount)
    @pot += amount
    amount
  end

  def take_hand(hand)
    @hand = hand
  end

  def return_hand
    cards = @hand.cards
    @hand = nil
    cards
  end
end
