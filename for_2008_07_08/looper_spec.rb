#!/usr/bin/env ruby
# looper_spec.rb

if (__FILE__ == $0)
  require %q[rubygems]
  require %q[spec]
  require %q[looper]

  describe Looper do
    before(:each) do
      @looper = Looper.new(1,2,3)
    end
  
    it "should detect" do
      @looper.detect {|i| i > 1 }.should == 2
    end

    it "should select" do
      @looper.select {|i| i % 2 == 1 }.should == [1,3]
    end

    it "should reject" do
      @looper.reject {|i| i % 2 == 1 }.should == [2]
    end

    it "should collect" do
      @looper.collect {|i| i * 2 }.should == [2,4,6]
    end
  end

end
