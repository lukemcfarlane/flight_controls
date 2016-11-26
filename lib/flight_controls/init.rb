require 'bundler/setup'
require 'arduino_firmata'

module FlightControls

  def self.start
    @port = self.scan
    self.init(@port)
  end

  def self.init(port)
    puts "Initializing with port: #{port}"
    @board = ArduinoFirmata.connect "/dev/#{port}"
    puts 'Connected'
    puts "Firmata version: #{@board.version}"

    FlightControls::config do |config|
      config.controls.each do |control|
        @board.pin_mode control.pin, ArduinoFirmata.const_get(control.mode)
      end

      loop do
        control = config.controls[2]
        config.controls.each do |control|
          val = @board.digital_read control.pin
          if control.set_value(val)
            puts "#{control.name} (#{control.channel}) turned #{val ? 'off' : 'on' }"
            values = Array.new(8, FlightControls::Xplane::NOOP)
            values[control.index] = val ? 0.0 : 1.0
            msg = FlightControls::Xplane::build_binary_data(
              control.channel,
              values
            )
            FlightControls::Xplane::send_message(msg)
          end
        end
        sleep 0.1
      end
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
