module FlightControls
  class Control
    attr_accessor :pin,
      :mode,
      :name,
      :dref,
      :value,
      :on_value,
      :prev_value

    def initialize(pin:, mode:, name:, dref:, on_value:)
      @pin, @mode, @name, @dref, @on_value = pin, mode, name, dref, on_value
    end

    def set_value(value)
      @prev_value = @value
      @value = value
      # !@prev_value.nil? && @value != @prev_value
      @value != @prev_value
    end

    def self.from_yaml(yaml, default_mode)
      dref_array = yaml['dref'].is_a?(Array) ? yaml['dref'] : [ yaml['dref'] ]
      Control.new(
        pin: yaml['pin'],
        mode: yaml['mode'] || default_mode,
        name: yaml['name'],
        dref: dref_array,
        on_value: yaml['on_value'] || 1.0
      )
    end
  end
end
