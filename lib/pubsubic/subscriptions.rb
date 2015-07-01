module Pubsubic
  class Subscriptions
    def initialize
      @subscriptions = {}
    end

    def [](name)
      validate_name! name
      raise ArgumentError unless has?(name)

      _find(name)
    end

    def create(name)
      validate_name! name
      raise ArgumentError if has?(name)

      _create(name)
    end

    def find_or_create(name)
      validate_name! name 

      _find(name) || _create(name)
    end

    private

    def validate_name!(name)
      raise ArgumentError unless name.instance_of?(Symbol)
    end

    def _find(name)
      @subscriptions[name]
    end

    def _create(name)
      @subscriptions[name] = Subscription.new(name)
    end

    def has?(name)
      @subscriptions.has_key?(name)
    end
  end
end
