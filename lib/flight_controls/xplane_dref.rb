require 'socket'

module FlightControls::XplaneDREF

  TOTAL_LENGTH = 509

  NULL = "\0"
  SPACE = 32
  # To try – should C be L?
  HEADER_FORMAT = "CCCCC"
  TYPE_FORMAT = "CCCC"
  # DATA_FORMAT = "ffff" + TYPE_FORMAT + ("C" * 495)
  HEADER = "DREF\0".bytes
  # path = "sim/cockpit2/electrical/battery_1_on"

  def self.test
    value, path = ARGV
    # value = 0.0
    # sim/electrical/battery_1_off
    msg = build_binary_data(value.to_f, path)
    log(msg)
    send_message msg
  end

  def self.pad (message, pad_value, number)
    message += Array.new(number - message.length, pad_value)
  end

  def self.build_binary_data (value, path)
    padded_path = path + (" " * (500 - path.length - 1)) + NULL
    message = [
      *HEADER, # 5 bytes
      value, # + 4 bytes
      # *path.bytes, # + 34 bytes = 43
      *padded_path.bytes
    ]
    puts "Message length: #{message.length}"
    # message = pad(message, SPACE, TOTAL_LENGTH - 1)
    # message.push NULL
    # templ = HEADER_FORMAT + DATA_FORMAT
    templ = HEADER_FORMAT + "f" + ("C" * (500))
    puts templ
    puts "templ length: #{templ.length}"
    message.pack templ
  end

  def self.log (msg)
    puts "Length: #{msg.length}"
    # puts "#{msg}\n============"
    msg.each_char do |char|
      puts "#{char.bytes[0]}\t#{char}"
    end
  end

  def self.send_message (msg)
    s = UDPSocket.new
    s.connect('127.0.0.1', 49000)
    s.send msg, 0
  end
end
