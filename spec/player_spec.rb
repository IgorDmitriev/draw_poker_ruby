require 'player'

describe "Player" do
  # let(:hand) { double('hand', discard: )}
  # let(:pot)
  subject(:player) { Player.new('name', 100) }

  describe "#initialize" do
    it 'should have a name' do
      expect(player.name).to eq('name')
    end

    it 'should have a pot' do
      expect(player.pot).to eq(100)
    end

  end

  describe "#bet_money" do
    it 'should decrease pot' do
      expect(player.bet_money(10)).to eq(10)
      expect(player.pot).to eq(90)
    end

    it 'should raise error if not enough money' do
      expect { player.bet_money(110) }.to raise_error('Not enough money')
    end

    it 'should raise error if not enough money' do
      expect { player.bet_money(-110) }.to raise_error("Can't bet negative amounts")
    end
  end

  describe "#get_money" do
    it 'should increase pot' do
      expect(player.get_money(10)).to eq(10)
      expect(player.pot).to eq(110)
    end
  end


  describe "#discard_prompt" do
    context '#valid_prompt shoudl raise error if' do
      it 'more then 3 indecies' do
        expect { player.valid_prompt?("0,2,3,4") }.to raise_error('Too many cards')
      end

      it 'prompt has duplicates' do
        expect { player.valid_prompt?("0,0,1") }.to raise_error('no duplicates')
      end

      it 'wrong input' do
        expect { player.valid_prompt?("s") }.to raise_error(ArgumentError)
      end

      it 'indices are not valid' do
        expect { player.valid_prompt?("-1,9") }.to raise_error("can't find this one")
      end

      it 'should return array with valid input' do
        expect(player.valid_prompt?("0,2,3")).to be_instance_of(Array)
      end
    end
  end
end
