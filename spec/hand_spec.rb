require 'hand'

describe 'Hand' do
  describe '#initialize' do
    let(:ace_diamond) { double("ace_diamond", value: 1, suit: :diamond) }
    let(:deuce_diamond) { double("deuce_diamond", value: 2, suit: :diamond) }
    let(:three_diamond) { double("three_diamond", value: 3, suit: :diamond) }
    let(:four_diamond) { double("four_diamond", value: 4, suit: :diamond) }
    let(:five_diamond) { double("five_diamond", value: 5, suit: :diamond) }
    let(:king_diamond) { double("king_diamond", value: 13, suit: :diamond) }
    let(:queen_diamond) { double("queen_diamond", value: 12, suit: :diamond) }
    let(:jack_diamond) { double("jack_diamond", value: 11, suit: :diamond) }
    let(:ten_diamond) { double("ten_diamond", value: 10, suit: :diamond) }

    let(:ace_club) { double("ace_club", value: 1, suit: :club) }
    let(:deuce_club) { double("deuce_club", value: 2, suit: :club) }
    let(:three_club) { double("three_club", value: 3, suit: :club) }
    let(:four_club) { double("four_club", value: 4, suit: :club) }
    let(:five_club) { double("five_club", value: 5, suit: :club) }
    let(:king_club) { double("king_club", value: 13, suit: :club) }
    let(:queen_club) { double("queen_club", value: 12, suit: :club) }
    let(:jack_club) { double("jack_club", value: 11, suit: :club) }
    let(:ten_club) { double("ten_club", value: 10, suit: :club) }

    let(:ace_heart) { double("ace_heart", value: 1, suit: :heart) }
    let(:deuce_heart) { double("deuce_heart", value: 2, suit: :heart) }
    let(:three_heart) { double("three_heart", value: 3, suit: :heart) }
    let(:four_heart) { double("four_heart", value: 4, suit: :heart) }
    let(:five_heart) { double("five_heart", value: 5, suit: :heart) }
    let(:king_heart) { double("king_heart", value: 13, suit: :heart) }
    let(:queen_heart) { double("queen_heart", value: 12, suit: :heart) }
    let(:jack_heart) { double("jack_heart", value: 11, suit: :heart) }
    let(:ten_heart) { double("ten_heart", value: 10, suit: :heart) }

    let(:ace_spade) { double("ace_spade", value: 1, suit: :spade) }
    let(:deuce_spade) { double("deuce_spade", value: 2, suit: :spade) }
    let(:three_spade) { double("three_spade", value: 3, suit: :spade) }
    let(:four_spade) { double("four_spade", value: 4, suit: :spade) }
    let(:five_spade) { double("five_spade", value: 5, suit: :spade) }
    let(:king_spade) { double("king_spade", value: 13, suit: :spade) }
    let(:queen_spade) { double("queen_spade", value: 12, suit: :spade) }
    let(:jack_spade) { double("jack_spade", value: 11, suit: :spade) }
    let(:ten_spade) { double("ten_spade", value: 10, suit: :spade) }

    let(:flush) { Hand.new([ace_spade, deuce_spade, ten_spade, four_spade, five_spade]) }
    let(:straight) { Hand.new([ace_spade, deuce_spade, three_diamond, four_spade, five_spade]) }
    let(:straight_flush) { Hand.new([ace_spade, deuce_spade, three_spade, four_spade, five_spade]) }
    let(:four_of_a_kind) { Hand.new([ace_spade, ace_club, ace_diamond, ace_heart, five_spade]) }
    let(:three_of_a_kind) { Hand.new([ace_spade, ace_club, ace_diamond, four_spade, five_spade]) }
    let(:two_pair) { Hand.new([ace_spade, four_diamond, ace_diamond, four_spade, five_spade]) }
    let(:one_pair) { Hand.new([ace_spade, deuce_spade, ace_diamond, four_spade, five_spade]) }
    let(:high_card) { Hand.new([ace_spade, king_spade, three_diamond, four_spade, five_spade]) }
    let(:full_house) { Hand.new([ace_spade, ace_club, ace_diamond, five_diamond, five_spade]) }

    let(:five_cards) { [1, 2, 3, 4, 5] }
    let(:discard_positions) { [0, 1, 3] }
    let(:cards) { [1, 2] }
    subject(:hand) { Hand.new(five_cards) }

    context 'should initialize' do
      it 'returns class of itself' do
        expect(hand).to be_instance_of(Hand)
      end

      it 'holds 5 cards' do
        expect(hand.cards.size).to be(5)
        expect(hand.cards).to be_instance_of(Array)
      end
    end

    context 'should receive and discard cards' do
      it 'should leave 2 cards in hand after discarding 3' do
        hand.discard(discard_positions)
        expect(hand.cards.size).to eq(2)
      end

      it 'should leave 5 cards in hand after discarding 3 and taking 2' do
        hand.discard(discard_positions)
        hand.take(cards)
        expect(hand.cards.size).to eq(4)
      end
    end

    context 'should score different types of hand' do
      it 'should score flush' do
        expect(flush.eval_hand).to eq(60)
      end

      it 'should score straight' do
        expect(straight.eval_hand).to eq(50)
      end

      it 'should score straight_flush' do
        expect(straight_flush.eval_hand).to eq(90)
      end

      it 'should score four of a kind' do
        expect(four_of_a_kind.eval_hand).to eq(80)
      end

      it 'should score three of a king' do
        expect(three_of_a_kind.eval_hand).to eq(40)
      end

      it 'should score one pair' do
        expect(one_pair.eval_hand).to eq(20)
      end

      it 'should score two pair' do
        expect(two_pair.eval_hand).to eq(30)
      end

      it 'should score full house' do
        expect(full_house.eval_hand).to eq(70)
      end

      it 'should score hight card' do
        expect(high_card.eval_hand).to eq(14)
      end


    end

    context 'should compare hands' do

      it 'should define evaluate lost' do
        result = (one_pair == full_house)
        expect(result).to eq(-1)
      end

      it 'should define evaluate draw' do
        result = (full_house == full_house)
        expect(result).to eq(0)
      end

      it 'should define evaluate win' do
        result = (straight_flush == full_house)
        expect(result).to eq(1)
      end
    end
  end
end
