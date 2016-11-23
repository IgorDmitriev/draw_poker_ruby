require 'card'

describe 'Card' do

  describe '#initialize' do
    subject(:card) { Card.new(10, :spade) }

    it 'should initialize with a value' do
      expect(card.value).to eq(10)
    end

    it 'should initialize with a suit' do
      expect(card.suit).to eq(:spade)
    end

  end



end
