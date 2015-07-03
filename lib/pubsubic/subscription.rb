module Pubsubic
  class Subscription
    require "set"

    attr_reader :name

    def initialize(name)
      raise ArgumentError unless name.instance_of?(Symbol)

      @name = name
      @subscribers = Set.new
    end

    def has_subscribers?
      !@subscribers.empty?
    end

    def subscribe(subscriber)
      raise ArgumentError unless subscriber.instance_of?(Subscriber)

      @subscribers << subscriber
    end

    def publish(message)
      raise ArgumentError unless message.instance_of?(Message)

      @subscribers.each { |s| s.notify @name, message }
    end
  end
end
