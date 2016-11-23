require 'deck'

describe 'Deck' do

  describe '#initialize' do

    subject(:deck) { Deck.new }

    context 'should initialize' do
      it 'with 52 cards' do
        expect(deck.cards.size).to eq(52)
      end

      it 'with 4 suits' do
        suits = deck.cards.map { |card| card.suit }.uniq.size
        expect(suits).to eq(4)
      end

      it 'and each suit has 13 different cards' do
        hash_by_suit = deck.cards.group_by(&:suit)
        suits = hash_by_suit.all? { |_, v| v.size == 13 }
        expect(suits).to be true
      end
    end

    context 'take, return, and shuffle cards' do
      it 'should return array of Card instances' do
        taken_cards = deck.take(4)
        expect(taken_cards).to be_instance_of(Array)
        expect(taken_cards).to all(be_instance_of(Card))
      end

      it 'leave 48 cards in deck after taking 4' do
        deck.take(4)
        expect(deck.cards.size).to eq(48)
      end

      it 'have 52 cards in deck after taking 4 and returning 4' do
        taken_cards = deck.take(4)
        deck.return(taken_cards)
        expect(deck.cards.size).to eq(52)
      end

      it 'shuffles cards' do
        srand(1)
        before_shuffled = deck.cards.dup
        deck.shuffle!
        after_shuffled = deck.cards
        expect(before_shuffled).not_to eq(after_shuffled)
      end

      it 'shuffles returns an array of cards' do
        expect(deck.shuffle!).to be_instance_of(Array)
        expect(deck.shuffle!).to all(be_instance_of(Card))
      end
    end
  end
end
