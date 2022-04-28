require_relative './player'
require 'json'

class Menu
  def initialize(clear_screen = "\e[H\e[2J")
    @file_manager = FileManager.new
    @clear_screen = clear_screen
  end

  def render_game_menu(player, error)
    puts @clear_screen
    print_statuses player
    print_actions
    print_additional_actions
    print_error error if error
  end

  def print_statuses(player)
    puts 'Valera parameters:'
    puts "[HP]: #{player.health}"
    puts "[Mana]: #{player.alcohol}"
    puts "[Positive]: #{player.positive}"
    puts "[Tiredness]: #{player.tiredness}"
    puts "[Money]: #{player.money}$\n\n"
  end

  def print_main_menu
    puts @clear_screen
    puts "Marginal Valera\n\n"
    puts '[1] - Start new Game'
    puts '[2] - Continue Game'
    puts "[3] - Exit\n\n"
    puts 'Choose action: '
  end

  def print_actions
    config = @file_manager.load_cfg

    action_number = 1
    config['actions'].each do |action|
      puts "#{action_number} - #{action['name']}"
      action_number += 1
    end
  end

  def print_additional_actions
    puts "\ns - Save Game"
    puts 'm - Exit to Menu'
    puts "q - Exit Game\n\n"
    puts 'Choose action: '
  end

  def print_saved
    puts "\nGame Saved!"
    puts 'Press any button:'
  end

  def print_error(error)
    puts error
  end

  def print_game_over
    puts "\nGame Over!"
    puts 'Press any button:'
  end
end
