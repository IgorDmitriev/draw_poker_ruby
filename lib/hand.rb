require 'byebug'

class Hand
  attr_reader :cards
  def initialize(cards)
    @cards = cards
  end

  def display
    puts @cards.map(&:to_s).join(" | ")
  end

  def discard(positions)
    discarded = []
    positions.sort.reverse.each do |pos|
      discarded << @cards.delete_at(pos)
    end
    discarded
  end

  def take(cards)
    @cards += cards
  end

  def eval_hand
    score = []
    score << straight_flush
    score << four_of_a_kind
    score << full_house
    score << flush
    score << straight
    score << three_of_a_kind
    score << two_pair
    score << one_pair
    score << high_card
    score.max
  end

  def ==(other)
    eval_hand <=> other.eval_hand
  end

  def straight_flush
    flush + straight == 110 ? 90 : 0
  end

  def four_of_a_kind
    values = @cards.map(&:value)
    values.any? { |value| values.count(value) == 4 } ? 80 : 0
  end

  def full_house
    three_of_a_kind + one_pair == 60 ? 70 : 0
  end

  def flush
    @cards.map(&:suit).uniq.size == 1 ? 60 : 0
  end

  def straight
    values = @cards.map(&:value).sort
    values.each_cons(2).all? { |x, y| y - x == 1 } ? 50 : 0
  end

  def three_of_a_kind
    values = @cards.map(&:value)
    values.any? { |value| values.count(value) == 3 } ? 40 : 0
  end

  def two_pair
    values = @cards.map(&:value)
    counts = values.map { |value| values.count(value) }
    counts.count(2) == 4 ? 30 : 0
  end

  def one_pair
    values = @cards.map(&:value)
    values.any? { |value| values.count(value) == 2 } ? 20 : 0
  end

  def high_card
    values = @cards.map(&:value).sort
    values.first == 1 ? 14 : values.last
  end


end
