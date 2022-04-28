require_relative './states'
require_relative './actions'

class Game
  include States

  def initialize(menu, file_manager, input)
    @menu = menu
    @file_manager = file_manager
    @input = input
  end

  def start
    config = @file_manager.load_cfg
    state = RENDER_MENU
    player = Player.new
    error = nil

    loop do
      case state
      when RENDER_MENU
        state, player, error = main_menu error
      when GAME
        state, player, error = iterate_game config, player, error
      when EXIT
        return
      end
    end
  end

  def main_menu(error)
    @menu.print_main_menu
    puts error

    input = @input.pressed_key.to_i

    case input
    when 1
      [GAME, Player.new]
    when 2
      saved_game = @file_manager.load_game
      if saved_game.nil?
        [RENDER_MENU, Player.new, 'No saves yet']
      else
        [GAME, Player.new(saved_game), nil]
      end
    when 3
      EXIT
    else
      RENDER_MENU
    end
  end

  def iterate_game(config, player, error)
    @menu.render_game_menu player, error
    input = @input.pressed_key

    state = reserved_key input, player
    return state unless state.nil?

    input = input.to_i - 1
    return [GAME, player] if input.negative? || input > config['actions'].length - 1

    error = Actions.new.do_action config['actions'][input], player

    return [RENDER_MENU, player] if check_player_death player

    [GAME, player, error]
  end

  private

  def reserved_key(input, player)
    case input
    when 'q'
      EXIT
    when 'm'
      [RENDER_MENU, player]
    when 's'
      @file_manager.save player
      @menu.print_saved
      @input.pressed_key
      nil
    end
  end

  def check_player_death(player)
    return unless player.dead?

    @menu.print_game_over
    @input.pressed_key
  end
end
