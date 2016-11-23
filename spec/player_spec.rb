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

  describe "#discard_prompt" do

  end

  describe "#get_action" do

  end

end
