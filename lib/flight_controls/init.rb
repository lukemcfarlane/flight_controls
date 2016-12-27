require 'bundler/setup'
require 'arduino_firmata'

module FlightControls

  def self.start
    @port = self.scan
    self.init(@port)
    # FlightControls::Xplane.test
  end

  def self.init(port)
    @connection = Xplane::Connection.new('127.0.0.1', 49000)
    FlightControls::config do |config|
      @electrical_panel = Module.new('Electrical panel', port, config.controls)
      @electrical_panel.start_read(@connection, 0.1)
    end
  end

  private

  def self.scan
    Dir.chdir('/dev') do
      ports = Dir.glob('tty\.*usb*')

      if ports.length === 1
        ports[0]
      else
        raise 'Is arduino connected?'
      end
    end
  end
end
