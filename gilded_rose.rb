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
    if name == "Aged Brie"
      increase_quality
    elsif name == "Backstage passes to a TAFKAL80ETC concert"
      increase_quality
      if sell_in < 10
        increase_quality
      end
      if sell_in < 5
        increase_quality
      end
    else
      decrease_quality
      if sell_in < 0
        decrease_quality
      end
    end

    if sell_in < 0
      if name == "Aged Brie"
        increase_quality
      elsif name == "Backstage passes to a TAFKAL80ETC concert"
        self.quality -= quality
      end
    end
  end

  def decrease_quality
    if quality > 0
      self.quality -= 1
    end
  end

  def increase_quality
    if quality < 50
      self.quality += 1
    end
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
