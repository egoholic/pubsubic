RSpec.describe Pubsubic::Publisher do
  let(:subscription) { Pubsubic::Subscription.new(:subscription) }

  describe "class" do
    subject { described_class }

    describe ".new" do
      context "when correct arguments" do
        it "returns it's instance" do
          expect(subject.new [subscription]).to be_instance_of(described_class)
        end
      end

      context "when wrong arguments" do
        it "raises ArgumentError" do
          expect { subject.new }.to raise_error(ArgumentError)
          expect { subject.new nil }.to raise_error(ArgumentError)
          expect { subject.new true }.to raise_error(ArgumentError)
          expect { subject.new "subscription" }.to raise_error(ArgumentError)
          expect { subject.new :subscription }.to raise_error(ArgumentError)
          expect { subject.new [] }.to raise_error(ArgumentError)
          expect { subject.new [nil] }.to raise_error(ArgumentError)
          expect { subject.new ["subscription"] }.to raise_error(ArgumentError)
          expect { subject.new [:subscription] }.to raise_error(ArgumentError)
        end
      end
    end
  end

  describe "instance" do
    subject { described_class.new [subscription] }

    describe "#publish" do

    end
  end
end
