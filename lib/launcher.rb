require_relative './file_manager'
require_relative './menu'
require_relative './io_adapter'
require_relative './game'

class Launcher
  def launch_game
    menu = Menu.new
    file_manager = FileManager.new
    input = IoAdapter.new

    Game.new(menu, file_manager, input).start
  end
end
