module Pubsubic
  class Subscriber
    attr_reader :name

    def initialize(name, &block)
      raise ArgumentError unless name.instance_of?(Symbol)
      raise ArgumentError unless block_given?
      
      @name = name
      @lambda = block
    end

    def notify(subscription_name, message)
      raise ArgumentError unless subscription_name.instance_of?(Symbol)
      raise ArgumentError unless message.instance_of?(Message)
  
      @lambda.call(subscription_name, message)
    end

    def ==(subscriber)
      raise ArgumentError unless subscriber.instance_of?(Subscriber)

      @name === subscriber.name
    end
  end
end
