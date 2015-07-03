module Pubsubic
  class Publisher
    include Utils

    def initialize(subscriptions)
      raise ArgumentError unless subscriptions?(subscriptions)

      @subscriptions = subscriptions
    end

    def publish(message)
      raise ArgumentError unless message.instance_of?(Message)

      @subscriptions.each { |s| s.publish message }
    end

    private

    def subscriptions?(subscriptions)
      return false unless subscriptions.instance_of?(Array)

      !subscriptions.empty? && subscriptions.all? { |s| s.instance_of?(Subscription) }
    end
  end
end
