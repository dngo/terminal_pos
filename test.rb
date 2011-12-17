require 'terminal'

describe Item do
  before(:all) do
    @item = Item.new(:name => "A", :price => 2, :bulk_quantity => 4, :bulk_price => 7)
  end

  describe "#name" do
    it "should correctly return the name" do
      @item.name.should eql("A")
    end
  end

  describe "#price" do
    it "should correctly return the price" do
      @item.price.should eql(2)
    end
  end

  describe "#bulk_quantity" do
    it "should correctly return the bulk_quantity" do
      @item.bulk_quantity.should eql(4)
      @item = Item.new(:name => "A", :price => 2)
      @item.bulk_quantity.should be_nil
    end
  end

  describe "#bulk_price" do
    it "should correctly return the bulk_price" do
      @item.bulk_price.should eql(7)
      @item = Item.new(:name => "A", :price => 2)
      @item.bulk_price.should be_nil
    end
  end

  describe "#total" do
    it "should correctly return the total_price" do
      @item.total(10).should eql(18)
    end
  end

end

describe Terminal do
   before(:each) do
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

    it "should not scan items that are not on the item list" do
      @terminal.cart.empty?.should eql(true)
      lambda { @terminal.scan("Q")}.should raise_error(ArgumentError, "Item could not be found")
      @terminal.cart.empty?.should eql(true)
    end
  end

  describe "#total" do
    it "should Scan these items in this order: ABCDABAA; Verify the total price is $32.40" do
      @terminal.scan("A")
      @terminal.scan("B")
      @terminal.scan("C")
      @terminal.scan("D")
      @terminal.scan("A")
      @terminal.scan("B")
      @terminal.scan("A")
      @terminal.scan("A")
      @terminal.cart.size.should eql(8)
      @terminal.total.should eql(32.40)
    end

    it "should Scan these items in this order: CCCCCCC; Verify the total price is $7.25" do
      @terminal.scan("C")
      @terminal.scan("C")
      @terminal.scan("C")
      @terminal.scan("C")
      @terminal.scan("C")
      @terminal.scan("C")
      @terminal.scan("C")
      @terminal.total.should eql(7.25)
    end

    it "should Scan these items in this order: ABCD; Verify the total price is $15.40" do
      @terminal.scan("A")
      @terminal.scan("B")
      @terminal.scan("C")
      @terminal.scan("D")
      @terminal.total.should eql(15.40)
    end
  end
end
