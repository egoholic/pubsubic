RSpec.describe Pubsubic::Message do
  message = {
    number: 1,
    string: "string",
    another_string: "1",
    "string 3" => "string"
  }

  subject { described_class.new message }

  describe "class" do
    subject { described_class }

    describe ".new" do
      context "when correct arguments" do
        it "returns its instance" do
          expect(subject.new message).to be_instance_of(described_class)
        end
      end

      context "when wrong arguments" do
        it "raises ArgumentError" do
          expect { subject.new }.to raise_error(ArgumentError)
        end
      end
    end
  end

  describe "instance" do
    describe "#type" do
      context "when message is a String" do
        subject { described_class.new "1" }

        it "returns String class" do
          expect(subject.type).to be String
        end
      end

      context "when message is an Array" do
        subject { described_class.new [1] }

        it "returns Array class" do
          expect(subject.type).to be Array
        end
      end

      context "when message is a Hash" do
        subject { described_class.new({number: 1, string: "1"}) }

        it "returns Hash class" do
          expect(subject.type).to be Hash
        end
      end

      context "when message is a Fixnum" do
        subject { described_class.new 1 }

        it "returns Fixnum class" do
          expect(subject.type).to be Fixnum
        end
      end
    end

    describe "#open" do
      it "returns a full copy of original message" do
        expect(subject.open).to eq(message)
        expect(subject.open.object_id).not_to eq(message.object_id)
        expect(subject.open[:string].object_id).not_to eq(message[:string].object_id)
      end
    end
  end
end
