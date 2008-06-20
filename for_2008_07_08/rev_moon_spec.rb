#!/usr/bin/env ruby
# rev_moon_spec.rb

if (__FILE__ == $0)
  require %q[rubygems]
  require %q[spec]
  require %q[rev_moon]

  describe RevMoon do
    
    before(:each) do
      @rev = RevMoon.new.clear!
    end

    describe %q[RevMoon#clear!] do
      it %q[should clear the matches] do
        @rev.unify( 1, 1 ).should == { 1 => 1 }
        @rev.clear!
        @rev.unify( 2, 2 ).should == { 2 => 2 }
      end
    end

    describe %q[RevMoon#unify] do
      it %q[should make a simple match] do
        sample = [ :name, :first, :last ]
        data   = [ :name, %q[Mark], %q[Josef] ]
        expected_match = { :first => %q[Mark], :last => %q[Josef] }
        @rev.unify(sample, data).should == expected_match
      end
      it %q[should make a compound match] do
        @rev.clear!
        sample = :shape
        data   = [ :circle, :radius ]
        expected_match = { :shape => data }
        @rev.unify(sample, data).should == expected_match
      end
      describe %q[it should fail to make an impossible match due to] do
        it %q[an atom needing to have two values] do
          sample = [ :x, :y, :y ]
          data   = [ 1, 2, 3 ]
          @rev.unify(sample, data).should be_nil
        end
        it %q[differing literal atoms] do
          sample = [ :x, :y, 4 ]
          data   = [ 1, 2, 3 ]
          @rev.unify(sample, data).should be_nil
        end
        it %q[differing literal atoms2] do
          sample = [ :x, :y, %q[z] ]
          data   = [ 1, 2, 3 ]
          @rev.unify(sample, data).should be_nil
        end
      end
      describe %q[should raise a ReassignmentError on an attempted reassignment] do
        it %q[simple] do
          sample = [ :name, :first, :last ]
          data   = [ :name, %q[Mark],  %q[Josef] ]
          data2  = [ :name, %q[Kevin], %q[Baird] ]
          @rev.unify(sample, data)
          lambda { @rev.unify(sample, data2) }.should raise_error(ReassignmentError)
        end
        it %q[compound] do
          sample = :shape
          data   = [ :circle, :radius ]
          data2  = [ :square, :length ]
          @rev.unify(sample, data)
          lambda { @rev.unify(sample, data2) }.should raise_error(ReassignmentError)
        end
      end
    end
  
  end

end
