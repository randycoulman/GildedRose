require './item.rb'
require 'delegate'

class ItemWrapper < SimpleDelegator
  def update
    if name != "Aged Brie" && name != "Backstage passes to a TAFKAL80ETC concert"
      if quality > 0
        if name != "Sulfuras, Hand of Ragnaros"
          self.quality -= 1
        end
      end
    else
      if quality < 50
        self.quality += 1
      end
      if name == "Backstage passes to a TAFKAL80ETC concert"
        if sell_in < 11
          increase_quality
        end
        if sell_in < 6
          increase_quality
        end
      end
    end
    if name != "Sulfuras, Hand of Ragnaros"
      self.sell_in -= 1
    end
    if sell_in < 0
      if name != "Aged Brie"
        if name != "Backstage passes to a TAFKAL80ETC concert"
          if quality > 0
            if name != "Sulfuras, Hand of Ragnaros"
              self.quality -= 1
            end
          end
        else
          self.quality -= quality
        end
      else
        increase_quality
      end
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
