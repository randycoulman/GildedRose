require './item.rb'
require 'delegate'

class ItemWrapper < SimpleDelegator
  def self.wrap(item)
    case item.name
    when "Aged Brie"
      AgedBrie.new(item)
    when "Backstage passes to a TAFKAL80ETC concert"
      BackstagePass.new(item)
    when "Conjured Mana Cake"
      ConjuredItem.new(item)
    when "Sulfuras, Hand of Ragnaros"
      LegendaryItem.new(item)
    else
      new(item)
    end
  end

  def update
    age
    update_quality
  end

  def age
    self.sell_in -= 1
  end

  def update_quality
    self.quality += quality_adjustment
  end

  def quality_adjustment
    if sell_in < 0
      past_date_adjustment
    else
      normal_adjustment
    end
  end

  def normal_adjustment
    -1
  end

  def past_date_adjustment
    2 * normal_adjustment
  end

  def quality=(new_quality)
    new_quality = 0 if new_quality < 0
    new_quality = 50 if new_quality > 50
    super(new_quality)
  end
end

class AgedBrie < ItemWrapper
  def past_date_adjustment
    2
  end

  def normal_adjustment
    1
  end
end

class BackstagePass < ItemWrapper
  def quality_adjustment
    adjustment = 1
    if sell_in < 10
      adjustment = 2
    end
    if sell_in < 5
      adjustment = 3
    end
    if sell_in < 0
      adjustment = -quality
    end
    adjustment
  end
end

class ConjuredItem < ItemWrapper
  def quality_adjustment
    adjustment = -2
    if sell_in < 0
      adjustment = -4
    end
    adjustment
  end
end

class LegendaryItem < ItemWrapper
  def update
    # Nothing to do - Legendary items don't change
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
      ItemWrapper.wrap(item).update
    end
  end
end
