module FlightControls::Xplane
  class Logger
    def self.log_message(message)
      puts "Length: #{message.length}"
      message.each_char do |char|
        puts "#{char.bytes[0]}\t#{char}"
      end
    end
  end
end