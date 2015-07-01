RSpec.describe Pubsubic::Subscriber do
  describe "class" do
    subject { described_class }

    describe ".new" do
      context "when correct arguments" do
        it "returns it's instance" do
          expect(subject.new(:echo) { |sn, m| m }).to be_instance_of(described_class)
        end
      end

      context "when wrong arguments" do
        it "raises ArgumentError" do
          expect { subject.new }.to raise_error(ArgumentError)
          expect { subject.new nil }.to raise_error(ArgumentError)
          expect { subject.new true }.to raise_error(ArgumentError)
          expect { subject.new :name }.to raise_error(ArgumentError)
          expect { subject.new { |sn, m| m } }.to raise_error(ArgumentError)
          expect { subject.new(nil) { |sn, m| m } }.to raise_error(ArgumentError)
          expect { subject.new(true) { |sn, m| m } }.to raise_error(ArgumentError)
          expect { subject.new("name") { |sn, m| m } }.to raise_error(ArgumentError)
        end
      end
    end
  end

  describe "instance" do
    let(:subscriber)  { described_class.new(:stupid_subscriber) { |sn, m| "I'm stupid!" } }
    let(:subscriber2) { described_class.new(:echo) { |sn, m| m } }
    let(:message)     { Pubsubic::Message.new("super message") }

    subject { described_class.new(:echo) { |sn, m| {subscription: sn, message: m.open}} }

    describe "#name" do
      it "returns name" do
        expect(subject.name).to eq(:echo)
      end
    end
    
    describe "#==" do
      context "when correct arguments" do
        context "when has the same name" do
          it "returns true" do
            expect(subject == subscriber2).to eq(true)
          end
        end

        context "when has different name" do
          it "returns false" do
            expect(subject == subscriber).to eq(false)
          end
        end
      end

      context "when wrong arguments" do
        it "raises ArgumentError" do
          expect { subject.==() }.to    raise_error(ArgumentError)
          expect { subject == nil }.to  raise_error(ArgumentError)
          expect { subject == true }.to raise_error(ArgumentError)
        end
      end
    end

    describe "#notify" do
      context "when correct arguments" do
        it "executes block with `subscription_name` and `message`" do
          expect(subject.notify :super_subscription, message).to eq({subscription: :super_subscription, message: "super message"})
        end
      end

      context "when wrong arguments" do
        it "raises ArgumentError" do
          expect { subject.notify }.to raise_error(ArgumentError)
          expect { subject.notify nil }.to raise_error(ArgumentError)
          expect { subject.notify true }.to raise_error(ArgumentError)
          expect { subject.notify "string" }.to raise_error(ArgumentError)
          expect { subject.notify nil, "string" }.to raise_error(ArgumentError)
          expect { subject.notify "string", "string" }.to raise_error(ArgumentError)
          expect { subject.notify :string, "string" }.to raise_error(ArgumentError)
          expect { subject.notify "string", Pubsubic::Message.new("string") }.to raise_error(ArgumentError)
        end
      end
    end

  end
end
