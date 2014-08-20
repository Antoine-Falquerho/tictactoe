require "spec_helper"

describe Player do

	describe "initialize" do
		it "should set all the attributes of the user" do
			p = Player.new "Antoine", "X", true
			p.name.should == "Antoine"
			p.tag.should == "X"
			p.is_human.should be_true
		end
	end

end