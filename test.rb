require 'terminal'

describe Item do
  before(:all) do
    @item = Item.new(:name => "A", :price => 2, :bulk_quantity => 4, :bulk_price => 7)
  end

  describe "#name" do
    it "should correctly return the name" do
    end
  end

  describe "#price" do
    it "should correctly return the price" do
    end
  end

  describe "#bulk_quantity" do
    it "should correctly return the bulk_quantity" do
    end
  end

  describe "#bulk_price" do
    it "should correctly return the bulk_price" do
    end
  end

end

describe Terminal do
   before(:all) do
    @terminal = Terminal.new
    @terminal.set_pricing Item.new(:name => "A", :price => 2, :bulk_quantity => 4, :bulk_price => 7)
    @terminal.set_pricing Item.new(:name => "B", :price => 12)
    @terminal.set_pricing Item.new(:name => "C", :price => 1.25, :bulk_quantity => 6, :bulk_price => 6)
    @terminal.set_pricing Item.new(:name => "D", :price => 0.15)
   end

  describe "#set_pricing" do
    it "should correctly place an item in the item list" do
      @terminal.item_list.size.should eql(4)
      @terminal.item_list["Z"].should be_nil
      item = Item.new(:name => "Z", :price => 2.15)
      @terminal.set_pricing(item) 
      @terminal.item_list.size.should eql(5)
      @terminal.item_list["Z"].should eql(item)
    end
  end

  describe "#scan" do
    it "should correctly scan an item into the cart" do
      @terminal.cart.empty?.should eql(true)
      @terminal.scan("A")
      @terminal.cart.size.should eql(1)
      @terminal.cart.first.should eql(@terminal.item_list["A"])
    end
  end

  describe "#total" do
    it "should correctly determine the total" do
      @terminal.scan("A")
      @terminal.cart.size.should eql(1)
      @terminal.cart.first.should eql(@terminal.item_list["A"])
    end
  end
end

