require 'bundler/setup'
require 'arduino_firmata'

module FlightControls
  class Module
    def initialize(name, port, controls)
      puts "Connecting to #{port}"
      @board = ArduinoFirmata.connect "/dev/#{port}"
      @controls = controls

      @controls.each do |control|
        @board.pin_mode control.pin, ArduinoFirmata.const_get(control.mode)
      end

      puts "#{name} connected at #{port}, firmata version is #{@board.version}"
    end


    def start_read(connection, rate = 0.1)
      loop do
        @controls.each do |control|
          val = @board.digital_read control.pin
          if control.set_value(val)
            puts "#{control.name} turned #{val ? 'off' : 'on' }"
            float_val = val ? 0.0 : control.on_value
            control.dref.each do |dref|
              msg = Xplane::DREFMessage.get_binary(float_val, dref)
              connection.send(msg)
            end
          end
        end
        sleep(rate)
      end
    end
  end

end