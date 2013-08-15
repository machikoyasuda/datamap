require "spec_helper"

describe Line do
  let(:line) { Line.new }

  describe "attributes" do
    it "has a name" do
      line.name = "Red"

      expect(line.name).to eql "Red"
    end

    it "has a number" do
      line.number = "801"

      expect(line.number).to eql "801"
    end
  end
end
