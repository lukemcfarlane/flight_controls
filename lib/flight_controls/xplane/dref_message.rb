require 'socket'

module FlightControls::Xplane
  class DREFMessage
    LENGTH = 509
    TEMPL = "CCCCCf" + ("C" * 500)
    HEADER = "DREF0".bytes
    NULL = 0
    SPACE = 32

    def self.get_binary (value, path)
      message = [ *HEADER ]
      message.push(value)
      message.push(*path.bytes)
      message.push(NULL)

      until message.length == LENGTH do
        message.push(SPACE)
      end

      message.pack TEMPL
    end
  end
end
