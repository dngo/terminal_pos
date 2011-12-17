class Terminal
  attr_accessor :item_list, :cart

  def initialize
    @item_list, @cart = {}, []
  end

  def set_pricing(item)
    item_list[item.name] = item
  end

  def scan(item_name)
    raise ArgumentError, "Item could not be found" unless item_list[item_name]
    cart << item_list[item_name] 
  end

  def total
    total_price = 0
    cart.uniq.each do |item|
      total_price += item.total(cart.count(item))
    end
    total_price
  end
end

class Item
  attr_accessor :name, :price, :bulk_quantity, :bulk_price

  def initialize(args)
    @name, @price, @bulk_quantity, @bulk_price = args[:name], args[:price], args[:bulk_quantity], args[:bulk_price]
  end

  def total(quantity)
    return price * quantity if bulk_price.nil? || quantity < bulk_quantity
    item_total = 0
    item_total += quantity/bulk_quantity * bulk_price
    item_total += quantity.remainder(bulk_quantity) * price
  end

end
