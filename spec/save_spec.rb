require_relative './spec_helper'
require_relative '../lib/file_manager'
require_relative '../lib/player'

RSpec.describe FileManager do
  describe 'Save and load file' do
    let(:player_expected) { Player.new }
    let(:file_manager) { FileManager.new }

    it 'Save and load file' do
      file_manager.save(player_expected)
      saved_game = file_manager.load_game
      player_loaded = Player.new(saved_game)
      expect(player_loaded) == player_expected
    end
  end

  describe 'Config file' do
    let(:file_manager) { FileManager.new }

    it 'Exist config' do
      expect(file_manager.load_cfg.size).to eq(1)
    end
  end
end
