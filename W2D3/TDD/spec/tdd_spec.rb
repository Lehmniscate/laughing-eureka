require 'tdd.rb'

describe "Array" do
  context "#my_uniq" do
    subject(:my_array) { [1,2,1,3,3] }

    it "returns the unique elements in the order in which they appear" do
      expect(my_array.my_uniq).to eq( [1,2,3] )
    end

    it "does not modify the original array" do
      my_array.my_uniq
      expect(my_array).to eq( [1,2,1,3,3] )
    end

    it "returns an empty array when given an empty array" do
      expect([].my_uniq).to eq( [] )
    end

    it "does not call Array#uniq" do
      expect(my_array).to_not receive(:uniq)
      my_array.my_uniq
    end
  end

  context "#two_sum" do
    subject(:my_array) { [-1, 0, 2, -2, 1] }

    it "finds all pairs of positions where the elements at those positions sum to zero" do
      expect(my_array.two_sum).to eq ( [[0, 4], [2, 3]] )
    end

    it "returns empty array when no pairs sum to zero" do
      expect([1,2,3].two_sum).to eq([])
    end

    it "returns smaller first elements first" do
      expect([-1, 0, -1, 1].two_sum).to eq( [[0, 3], [2, 3]] )
    end

    it "returns smaller second elements first if first elements are the same" do
      expect([-1, 0, 1, 1].two_sum).to eq( [[0,2], [0, 3]] )
    end

    it "does not modify the original array" do
      my_array.two_sum
      expect(my_array).to eq( [-1, 0, 2, -2, 1] )
    end
  end
end
#
# describe "my_transpose" do
#   let(:square_matrix) { [[0, 1, 2],
#                          [3, 4, 5],
#                          [6, 7, 8]] }
#
#   let (:rectangular_matrix) { [[0, 1, 3], [5, 7, 9]] }
#
#   let(:not_matrix) { [[1, 2, 3], [4, 5]] }
#
#   it "transposes square matrix" do
#     expect(my_transpose(square_matrix)).to eq( [[0, 3, 6],
#                                                [1, 4, 7],
#                                                [2, 5, 8]])
#   end
#
#   it "transposes non-square rectangular matrix" do
#     expect(my_transpose(rectangular_matrix)).to eq( [[0, 5],
#                                                     [1, 7],
#                                                     [3, 9]])
#
#   end
#
#   it "does not modify original array" do
#     my_transpose(square_matrix)
#     expect(square_matrix).to eq( [[0, 1, 2],
#                                   [3, 4, 5],
#                                   [6, 7, 8]] )
#
#   end
#
#   it "raises error if not a matrix" do
#     expect { my_transpose(not_matrix) }.to raise_error(ArgumentError)
#   end
# end
#
# describe "stock_picker" do
#   let(:stock_prices) { [100, 110, 120, 132, 50]}
#   let(:stock_prices_repeat) { [100, 110, 132, 132, 50]}
#
#   it "raises an error if it is not an array of numbers" do
#     expect { stock_picker("stocks") }.to raise_error(ArgumentError)
#   end
#
#   it "raises an error unless it has at least two days of stock prices" do
#     expect { stock_picker([100]) }.to raise_error(ArgumentError)
#   end
#
#   it "returns the most profitable pair of days" do
#     expect(stock_picker(stock_prices)).to eq([0, 3])
#   end
#
#   it "does not modify the original array" do
#     stock_picker(stock_prices)
#     expect(stock_prices).to eq([100, 110, 120, 132, 50])
#   end
#
#   it "it returns a buy day that is earlier than the sell day" do
#     expect(stock_picker(stock_prices)).to_not eq([4, 3])
#   end
#
#   it "returns the earliest pair of days" do
#     expect(stock_picker(stock_prices_repeat)).to eq([0, 2])
#   end
# end
#
# describe "Towers of Hanoi" do
#   subject(:towers_game) {TowersOfHanoi.new}
#
#   context "#initialize" do
#     it "creates an array" do
#       expect(towers_game.towers).to be_an(Array)
#     end
#
#     it "creates an array that contains 3 towers" do
#       expect(towers_game.towers.count).to eq(3)
#     end
#
#     it "creates an array that contains 3 towers represented by arrays" do
#       expect(towers_game.towers).to all( be_an(Array) )
#     end
#
#     it "sets the first tower to hold all the discs in order" do
#       expect(towers_game.towers.first).to eq([3,2,1])
#     end
#   end
#
#   context "#move" do
#     before(:each) do
#       towers_game.move(0,1)
#     end
#
#     it "raises an error if starting tower is empty" do
#       expect { towers_game.move(2,1) }.to raise_error
#     end
#
#     it "raises an error if moving disc is bigger than destination disc" do
#       expect { towers_game.move(0,1) }.to raise_error
#     end
#
#     it "moves disc from starting tower to ending tower" do
#       towers_game.move(0,2)
#       expect(towers_game.towers[2]).to eq([2])
#     end
#
#     it "removes disc from starting tower" do
#       towers_game.move(0,2)
#       expect(towers_game.towers[0]).to_not include(2)
#     end
#   end
#
#   context "#won?" do
#
#     it "returns true if all discs are in either tower 2 or 3" do
#       towers_game.towers = [[],[],[3,2,1]]
#       expect(towers_game.won?).to be true
#     end
#
#     it "returns false if any discs are in tower 1" do
#       towers_game.towers = [[3],[2,1],[]]
#       expect(towers_game.won?).to be false
#     endß
#
#     it "returns false if more than one tower have discs" do
#       towers_game.towers = [[],[2,1],[3]]
#       expect(towers_game.won?).to be false
#     end
#   end
# end
