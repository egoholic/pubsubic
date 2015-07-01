module Pubsubic
  module Utils
    private

    def dpdup(obj)
      case obj
      when Integer, Symbol, NilClass, TrueClass, FalseClass
        obj
      when Array, Set
        obj.map { |o| dpdup o }
      when Hash
        obj.each_with_object { |(k, v), hash| hash[dpdup(k)] = dpdup(v) }
      else
        obj.dup
      end
    end
  end
end
