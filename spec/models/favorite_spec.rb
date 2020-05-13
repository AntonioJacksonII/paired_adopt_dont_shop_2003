require 'rails_helper'

describe Favorite do
  describe "#total_count" do
    it "can calculate the total number of favorites it holds" do
      favorite = Favorite.new({1 => 1, 2 => 1})

      expect(favorite.total_count).to eq(2)
    end
  end
end
