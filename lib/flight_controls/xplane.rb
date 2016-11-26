require 'socket'

module FlightControls::Xplane

  HEADER_FORMAT = "CCCCC"
  DATA_FORMAT = "iffffffff"
  NOOP = -999
  HEADER = "DATA\0".each_byte.to_a

  def self.test
    id, *values = ARGV
    msg = build_binary_data id.to_i, values.map { |v| v.to_f }
    send_message msg
  end

  def self.build_binary_data (id, values)
    element = [
      *HEADER,
      id,
      *values,
      *Array.new(8 - values.length, NOOP) # pad with no ops
    ]
    templ = HEADER_FORMAT + DATA_FORMAT
    element.pack templ
  end

  def self.send_message (msg)
    s = UDPSocket.new
    s.connect('127.0.0.1', 49000)
    s.send msg, 0
  end
end
