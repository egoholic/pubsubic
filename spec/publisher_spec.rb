RSpec.describe Pubsubic::Publisher do
  let(:subscription) { Pubsubic::Subscription.new(:subscription) }
  let(:subscription2) { Pubsubic::Subscription.new(:subscription2) }
  let(:message) { Pubsubic::Message.new("message") } 

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
    subject { described_class.new [subscription, subscription2] }

    describe "#publish" do
      context "when correct arguments" do
        it "publisize message to given subscriptions" do
          expect(subscription).to receive(:publish).with message
          expect(subscription2).to receive(:publish).with message

          subject.publish message
        end
      end

      context "when wrong arguments" do
        it "raises ArgumentError" do
          expect { subject.publish }.to raise_error(ArgumentError)
          expect { subject.publish nil }.to raise_error(ArgumentError)
          expect { subject.publish [] }.to raise_error(ArgumentError)
          expect { subject.publish "message" }.to raise_error(ArgumentError)
          expect { subject.publish :message }.to raise_error(ArgumentError)
        end
      end
    end
  end
end
