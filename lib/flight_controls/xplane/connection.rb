require 'socket'

module FlightControls::Xplane
  class Connection
    attr_reader :socket

    def initialize(addr, port)
      @socket = UDPSocket.new
      @socket.connect(addr, port)
    end

    def send(message)
      puts "Sending"
      puts @socket
      puts message

      @socket.send message, 0
    end
  end
end
