require 'socket'

module FlightControls::Xplane
  class Connection
    attr_reader :sock

    def initialize(addr, port)
      @addr, @port = addr, port
      @sock = UDPSocket.new
      @sock.connect(addr, port)
      puts "Ready to send data to X-Plane at #{addr}:#{port}"
    end

    def send(message)
      puts "Sending #{message}"
      @sock = UDPSocket.new
      @sock.connect(@addr, @port)
      @sock.send message, 0
    end
  end
end
