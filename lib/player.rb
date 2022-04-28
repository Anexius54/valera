class Player
  attr_reader :health, :alcohol, :positive, :tiredness
  attr_accessor :money

  def initialize(load_game = {})
    @health = load_game['health'] || 100
    @alcohol = load_game['alcohol'] || 0
    @positive = load_game['positive'] || 0
    @tiredness = load_game['tiredness'] || 0
    @money = load_game['money'] || 0
  end

  def dead?
    @health.zero? || @positive <= -10 || @money.negative? || @tiredness >= 100
  end

  def health=(health)
    @health = validate health, 0, 100
  end

  def alcohol=(alcohol)
    @health -= validate @alcohol - alcohol, 0, @health if @alcohol < alcohol.abs
    @alcohol = validate alcohol, 0, 100
  end

  def positive=(positive)
    @positive = validate positive, -10, 10
  end

  def tiredness=(tiredness)
    @tiredness = validate tiredness, 0, 100
  end

  private

  def validate(value, min, max)
    [[value, max].min, min].max
  end
end
