require './item.rb'
require 'delegate'

class ItemWrapper < SimpleDelegator
  def update
    return if name == "Sulfuras, Hand of Ragnaros"
    age
    update_quality
  end

  def age
    self.sell_in -= 1
  end

  def update_quality
    adjustment = 0
    if name == "Aged Brie"
      adjustment += 1
      if sell_in < 0
        adjustment += 1
      end
    elsif name == "Backstage passes to a TAFKAL80ETC concert"
      adjustment += 1
      if sell_in < 10
        adjustment += 1
      end
      if sell_in < 5
        adjustment += 1
      end
      if sell_in < 0
        adjustment = -quality
      end
    elsif name == "Conjured Mana Cake"
      adjustment -= 2
      if sell_in < 0
        adjustment -= 2
      end
    else
      adjustment -= 1
      if sell_in < 0
        adjustment -= 1
      end
    end
    self.quality += adjustment
  end

  def quality=(new_quality)
    new_quality = 0 if new_quality < 0
    new_quality = 50 if new_quality > 50
    super(new_quality)
  end

end

class GildedRose

  @items = []

  def initialize
    @items = []
    @items << Item.new("+5 Dexterity Vest", 10, 20)
    @items << Item.new("Aged Brie", 2, 0)
    @items << Item.new("Elixir of the Mongoose", 5, 7)
    @items << Item.new("Sulfuras, Hand of Ragnaros", 0, 80)
    @items << Item.new("Backstage passes to a TAFKAL80ETC concert", 15, 20)
    @items << Item.new("Conjured Mana Cake", 3, 6)
  end

  def update_quality
    @items.each do |item|
      ItemWrapper.new(item).update
    end
  end
end
