require 'rspec'
require_relative '../lib/actions'

describe Actions do
  let(:action) { Actions.new }
  let(:player) { Player.new({ 'health' => 100, 'alcohol' => 0, 'positive' => 0, 'tiredness' => 0, 'money' => 300 }) }
  let(:config) { FileManager.new.load_cfg }

  context 'when Valera works' do
    it 'change attributes' do
      action.do_action(config['actions'][0], player)
      expect(player.money).to eq 400
      expect(player.positive).to eq(-5)
    end
  end

  context 'when Valera contemplates nature' do
    it 'change attributes' do
      action.do_action(config['actions'][1], player)
      expect(player.tiredness).to eq 10
      expect(player.positive).to eq 1
    end
  end

  context 'when Valera  drinks and watches TV series' do
    it 'change attributes' do
      action.do_action(config['actions'][2], player)
      expect(player.alcohol).to eq 30
      expect(player.positive).to eq(-1)
      expect(player.health).to eq 95
    end
  end

  context 'when Valera  went to the bar' do
    it 'change attributes' do
      action.do_action(config['actions'][3], player)
      expect(player.alcohol).to eq 60
      expect(player.positive).to eq 1
      expect(player.tiredness).to eq 40
      expect(player.health).to eq 90
    end
  end

  context 'when Valera  drinking with marginal friends' do
    it 'change attributes' do
      action.do_action(config['actions'][4], player)
      expect(player.alcohol).to eq 90
      expect(player.positive).to eq 5
      expect(player.tiredness).to eq 80
      expect(player.health).to eq 20
    end
  end

  context 'when Valera Sing in the subways' do
    it 'change attributes' do
      action.do_action(config['actions'][5], player)
      expect(player.alcohol).to eq 10
      expect(player.positive).to eq 1
      expect(player.tiredness).to eq 20
      expect(player.money).to eq 310
    end
  end

  it 'change attributes when alcohol [30..60]' do
    player.alcohol = 40
    action.do_action(config['actions'][5], player)
    expect(player.money).to eq 360
  end

  context 'when Valera slept' do
    it 'change attributes' do
      action.do_action(config['actions'][6], player)
      expect(player.alcohol).to eq 0
      expect(player.tiredness).to eq 0
    end

    it 'change happy when alcohol >= 70' do
      player.alcohol = 80
      player.positive = 10
      action.do_action(config['actions'][6], player)
      expect(player.alcohol).to eq 30
      expect(player.positive).to eq 7
    end
  end
end
