require_relative './file_manager'
require 'json'
require 'io/console'

class Actions
  def change_attribute(name, value, player)
    player.send "#{name}=", player.send(name) + value
  end

  def change_attributes(action, player)
    action['result'].each do |effect|
      change_attribute effect['name'], effect['value'], player
      next unless effect.include? 'condition'

      check_additional_effect player, effect
    end
  end

  def do_action(action, player)
    unless action['conditions'].size.zero?
      action['conditions'].each do |condition|
        unless player.send(condition['name']).between? condition['min'], condition['max']
          return "\nParameter #{condition['name']} must be less then #{condition['max']}\n"
        end
      end
    end
    change_attributes action, player
    nil
  end

  private

  def check_additional_effect(player, effect)
    unless player.send(effect['condition']['name']).between? effect['condition']['min'], effect['condition']['max']
      return
    end

    change_attribute effect['name'], effect['condition']['value'], player
  end
end
