require 'game'


describe "Game" do
  let(:player_1) { double("player_1") }
  let(:player_2) { double("player_1") }
  subject(:game) { Game.new(player_1, player_2, deck) }

  describe "#initialize" do
    it 'should have a name' do
      expect(player.name).to eq('name')
    end

    it 'should have a pot' do
      expect(player.pot).to eq(100)
    end

  end

end
