module Pubsubic
  class Publisher
    include Utils

    def initialize(subscriptions)
      raise ArgumentError unless subscriptions?(subscriptions)

      @subscriptions = subscriptions
    end

    private

    def subscriptions?(subscriptions)
      return false unless subscriptions.instance_of?(Array)

      subscriptions.empty? || !subscriptions.all? { |s| s.instance_of?(Subscription) }
    end
  end
end
