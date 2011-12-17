require 'rubygems'
require 'ruby-debug'

class Terminal
  attr_accessor :item_list, :cart

  def initialize
    @item_list = {}
    @cart = []
  end

  def set_pricing(item)
    @item_list[item.name] = item
  end

  def scan(item_name)
    @cart << @item_list[item_name]
  end

  def total
  end
end

class Item
  attr_accessor :name, :price, :bulk_quantity, :bulk_price

  def initialize(args)
    @name = args[:name]
    @price = args[:price]
    @bulk_quantity = args[:bulk_quantity]
    @bulk_price = args[:bulk_price]
  end

end
