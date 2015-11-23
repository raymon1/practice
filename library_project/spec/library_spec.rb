require 'spec_helper'

describe "Library object" do

	before :all do
		lib_arr = [
			Book.new("JavaScript: The Good Parts", "Douglas Crockfor", :development),
			Book.new("JavaScript Patterns", "Stoyan Stefanov", :design)
		]
		File.open "books.yml", "w" do |f|
			f.write YAML::dump lib_arr
		end
	end	

	before :each do
		@lib = Library.new "books.yml"
	end

	describe "#new" do
		context "with no parameters" do
			it "has no books" do
				lib = Library.new
				expect(lib.books.size).to eq(0)
			end
		end

		context "with a yaml file name parameter" do
			it "has 2 books" do
				expect(@lib.books.size).to eq(2)
			end
		end
	end

	it "returns all the books in a given category" do
			expect(@lib.get_books_in_category(:development).length).to eq(1)
	end

	it "accepts new books" do
		@lib.add_book( Book.new("b1","a1", :cat1))
		expect(@lib.get_book("b1")).to be_an_instance_of Book
	end
end