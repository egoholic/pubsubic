RSpec.describe Pubsubic::Subscriptions do
  describe "class" do
    subject { described_class }

    describe ".new" do
      it "returns it's instance" do
        expect(subject.new).to be_instance_of(described_class)
      end
    end
  end

  describe "instance" do
    subject { described_class.new }

    describe "#find_or_create" do
      context "when correct arguments" do
        context "when subscription exists" do
          let!(:existing_subscription) { subject.create :subscription }

          it "returns subscription" do
            subscription = subject.find_or_create :subscription

            expect(subscription).to be_instance_of(Pubsubic::Subscription)
            expect(subscription).to eq(existing_subscription)
            expect(subscription.name).to eq(:subscription)
          end
        end

        context "when subscription didn't exist" do
          it "raises ArgumentError" do
            subscription = subject.find_or_create :subscription

            expect(subscription).to be_instance_of(Pubsubic::Subscription)
            expect(subscription.name).to eq(:subscription)
          end
        end
      end

      context "when wrong arguments" do
        context "when subscription exists" do
          before { subject.create :subscription }

          it "raises ArgumentError" do
            expect { subject.find_or_create }.to raise_error(ArgumentError)
            expect { subject.find_or_create nil }.to raise_error(ArgumentError)
            expect { subject.find_or_create true }.to raise_error(ArgumentError)
            expect { subject.find_or_create "subscription" }.to raise_error(ArgumentError)
          end
        end

        context "when subscription doesn't exist" do
          it "raises ArgumentError" do
            expect { subject.find_or_create }.to raise_error(ArgumentError)
            expect { subject.find_or_create nil }.to raise_error(ArgumentError)
            expect { subject.find_or_create true }.to raise_error(ArgumentError)
            expect { subject.find_or_create "subscription" }.to raise_error(ArgumentError)
          end
        end
      end
    end

    describe "#[]" do
      context "when correct arguments" do
        context "when subscription exists" do
          let!(:existing_subscription) { subject.create :subscription }

          it "returns subscription" do
            subscription = subject[:subscription]

            expect(subscription).to be_instance_of(Pubsubic::Subscription)
            expect(subscription).to eq(existing_subscription)
            expect(subscription.name).to eq(:subscription)
          end
        end

        context "when subscription didn't exist" do
          it "raises ArgumentError" do
            expect { subject[:unexistent] }.to raise_error(ArgumentError)
          end
        end
      end

      context "when wrong arguments" do
        context "when subscription exists" do
          before { subject.create :subscription }

          it "raises ArgumentError" do
            expect { subject[] }.to raise_error(ArgumentError)
            expect { subject[nil] }.to raise_error(ArgumentError)
            expect { subject[true] }.to raise_error(ArgumentError)
            expect { subject["subscription"] }.to raise_error(ArgumentError)
          end
        end

        context "when subscription doesn't exist" do
          it "raises ArgumentError" do
            expect { subject[] }.to raise_error(ArgumentError)
            expect { subject[nil] }.to raise_error(ArgumentError)
            expect { subject[true] }.to raise_error(ArgumentError)
            expect { subject["subscription"] }.to raise_error(ArgumentError)
          end
        end
      end
    end

    describe "#create" do
      context "when correct arguments" do
        context "when subscription exists" do
          before { subject.create :subscription }

          it "raises ArgumentError" do
            expect { subject.create :subscription }.to raise_error(ArgumentError)
          end
        end

        context "when subscription didn't exist" do
          it "creates and returns it" do
            subscription = subject.create :subscription

            expect(subscription).to be_instance_of(Pubsubic::Subscription)
            expect(subject[:subscription]).to eq subscription
          end
        end
      end

      context "when wrong arguments" do
        it "raises ArgumentError" do
          expect { subject.create }.to raise_error(ArgumentError)
          expect { subject.create nil }.to raise_error(ArgumentError)
          expect { subject.create true }.to raise_error(ArgumentError)
          expect { subject.create "subscription" }.to raise_error(ArgumentError)
        end
      end
    end
  end
end
