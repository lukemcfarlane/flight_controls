require 'socket'

module FlightControls::Xplane

  TOTAL_LENGTH = 509
  TEMPL = "CCCCCf" + ("C" * 500)
  HEADER = "DREF0".bytes
  NULL = 0
  SPACE = 32

  # def self.test
  #   value, path = ARGV
    # e.g.
    # value = 0.0
    # sim/electrical/battery_1_on[0]
  #   msg = build_binary_data(value.to_f, path)
  #   log(msg)
  #   send_message msg
  # end

  def self.binary_message (value, path)
    message = [ *HEADER ]
    message.push(value)
    message.push(*path.bytes)
    message.push(NULL)

    until message.length == TOTAL_LENGTH do
      message.push(SPACE)
    end

    message.pack TEMPL
  end

  # def self.log (msg)
  #   puts "Length: #{msg.length}"
  #   msg.each_char do |char|
  #     puts "#{char.bytes[0]}\t#{char}"
  #   end
  # end

  # def self.send_message (msg)
  #   s = UDPSocket.new
  #   s.connect('127.0.0.1', 49000)
  #   s.send msg, 0
  # end
end
