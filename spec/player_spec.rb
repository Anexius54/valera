require_relative './spec_helper'
require_relative '../lib/player'

describe Player do
  let(:player) { Player.new }

  context 'starting characteristics' do
    it { expect(player.health).to eq 100 }
    it { expect(player.alcohol).to eq 0 }
    it { expect(player.positive).to eq 0 }
    it { expect(player.tiredness).to eq 0 }
    it { expect(player.money).to eq 0 }
  end

  describe '#health=' do
    context 'range of health attr = [0, 100]' do
      it 'valid value' do
        player.health = 50
        expect(player.health).to eq 50
      end
      it 'more than upper bound' do
        player.health = 110
        expect(player.health).to eq 100
      end
      it 'less than lower bound' do
        player.health = -10
        expect(player.health).to eq 0
      end
    end
  end

  describe '#mana=' do
    context 'range of mana attr = [0, 100]' do
      it 'valid value' do
        player.alcohol = 50
        expect(player.alcohol).to eq 50
      end
      it 'more than upper bound' do
        player.alcohol = 110
        expect(player.alcohol).to eq 100
      end
      it 'less than lower bound' do
        player.alcohol = -10
        expect(player.alcohol).to eq 0
      end
    end
  end

  describe '#positive=' do
    context 'range of positive attr = [-10, 10]' do
      it 'valid value' do
        player.positive = 5
        expect(player.positive).to eq 5
      end
      it 'more than upper bound' do
        player.positive = 20
        expect(player.positive).to eq 10
      end
      it 'less than lower bound' do
        player.positive = -20
        expect(player.positive).to eq(-10)
      end
    end
  end

  describe '#tiredness=' do
    context 'range of tiredness = [0, 100]' do
      it 'valid value' do
        player.tiredness = 50
        expect(player.tiredness).to eq 50
      end
      it 'more than upper bound' do
        player.tiredness = 110
        expect(player.tiredness).to eq 100
      end
      it 'less than lower bound' do
        player.tiredness = -10
        expect(player.tiredness).to eq 0
      end
    end
  end

  describe '#dead?' do
    context 'Valera is dead' do
      it 'HP = 0' do
        player.health = 0
        expect(player.dead?).to be true
      end
      it 'positive = -10' do
        player.positive = -10
        expect(player.dead?).to be true
      end
      it 'money < 0' do
        player.money = -100
        expect(player.dead?).to be true
      end
      it 'tiredness = 100' do
        player.tiredness = 100
        expect(player.dead?).to be true
      end
    end

    context 'Valera is not dead' do
      it 'HP = 10' do
        player.health = 10
        expect(player.dead?).to be false
      end
      it 'positive = -5' do
        player.positive = -5
        expect(player.dead?).to be false
      end
      it 'money = 100' do
        player.money = 100
        expect(player.dead?).to be false
      end
      it 'tiredness = 90' do
        player.tiredness = 90
        expect(player.dead?).to be false
      end
    end
  end
end
