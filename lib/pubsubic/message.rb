module Pubsubic
  class Message
    include Utils

    def initialize(message)
      @message = message
    end

    def type
      @message.class
    end

    def open
      dpdup @message
    end
  end
end
