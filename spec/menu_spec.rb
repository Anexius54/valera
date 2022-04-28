require 'rspec'
require_relative '../lib/menu'
require_relative '../lib/file_manager'
require_relative '../lib/player'

describe Menu do
  let('menu') { Menu.new }

  context '#render' do
    it 'print statuses' do
      expect do
        menu.print_statuses(Player.new)
      end.to output("Valera parameters:\n[HP]: 100\n[Mana]: 0\n[Positive]: 0\n[Tiredness]: 0\n[Money]: 0$\n\n")
        .to_stdout
    end

    it 'main menu' do
      expect do
        menu.print_main_menu
      end
        .to output(
          "\e[H\e[2J\nMarginal Valera\n\n[1] - Start new Game\n[2] - Continue Game\n[3] - Exit\n\nChoose action: \n"
        ).to_stdout
    end

    it 'additional actions' do
      expect do
        menu.print_additional_actions
      end.to output("\ns - Save Game\nm - Exit to Menu\nq - Exit Game\n\nChoose action: \n").to_stdout
    end

    it 'print saved' do
      expect do
        menu.print_saved
      end.to output("\nGame Saved!\nPress any button:\n").to_stdout
    end

    it 'print error' do
      expect do
        menu.print_error('error')
      end.to output("error\n").to_stdout
    end

    it 'print over' do
      expect do
        menu.print_game_over
      end.to output("\nGame Over!\nPress any button:\n").to_stdout
    end
  end
end
