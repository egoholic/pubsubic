RSpec.describe Pubsubic::Subscription do
  name = :some_subscription

  let(:subscription) { described_class.new name }

  describe "class" do
    subject { described_class }

    describe ".new" do
      context "when correct arguments" do
        it "returns it's instance" do
          expect(subject.new name).to be_instance_of(described_class)
        end
      end

      context "when wrong arguments" do
        it "raises ArgumentError" do
          expect { subject.new nil }.to raise_error(ArgumentError)
          expect { subject.new }.to raise_error(ArgumentError)
          expect { subject.new "string_name" }.to raise_error(ArgumentError)
        end
      end
    end
  end

  describe "instance" do
    let(:subscriber)  { Pubsubic::Subscriber.new { |m| "I've got message: #{m}" } }
    let(:subscriber2) { Pubsubic::Subscriber.new { |m| m.to_s } }
    let(:message)     { Pubsubic::Message.new("my message") }

    subject { subscription }

    describe "#name" do
      it "returns name" do
        expect(subject.name).to eq name
      end
    end

    describe "#has_subscribers?" do
      context "when has subscribers" do
        before { subject.subscribe subscriber }

        it "returns an array with names" do
          expect(subject.has_subscribers?).to eq(true)
        end
      end

      context "when has no subscribers" do
        it "returns an empty array" do
          expect(subject.has_subscribers?).to eq(false)
        end
      end
    end

    describe "#subscribe" do
      context "when correct arguments" do
        it "subscribes the subscriber" do
          expect { subject.subscribe(subscriber) }
            .to change { subject.has_subscribers? }.from(false).to(true)
        end
      end

      context "when wrong arguments" do
        it "raises ArgumentError" do
          expect { subject.subscribe }.to raise_error(ArgumentError)
          expect { subject.subscribe nil }.to raise_error(ArgumentError)
          expect { subject.subscribe true }.to raise_error(ArgumentError)
        end
      end
    end

    describe "#publish" do
      context "when correct arguments" do
        it "sends it to subscribers" do
          expect(subscriber).to receive(:notify).with(message)
          expect(subscriber).to receive(:notify).with(message)

          subject.publish(message)
        end
      end

      context "when wrong arguments" do
        it "raises ArgumentError" do
          expect { subject.publish }.to raise_error(ArgumentError)
          expect { subject.publish nil }.to raise_error(ArgumentError)
          expect { subject.publish "string" }.to raise_error(ArgumentError)
        end
      end
    end

  end
end
