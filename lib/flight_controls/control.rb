module FlightControls
  class Control
    attr_accessor :pin, :mode, :name, :channel, :index, :value, :prev_value

    def initialize(pin:, mode:, name:, channel:, index:)
      @pin, @mode, @name, @channel, @index = pin, mode, name, channel, index
    end

    def set_value(value)
      @prev_value = @value
      @value = value
      # !@prev_value.nil? && @value != @prev_value
      @value != @prev_value
    end

    def self.from_yaml(yaml, default_mode)
      Control.new(
        pin: yaml['pin'],
        mode: yaml['mode'] || default_mode,
        name: yaml['name'],
        channel: yaml['channel'],
        index: yaml['index']
      )
    end
  end
end
