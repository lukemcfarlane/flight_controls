module FlightControls
  class << self
    def config(&block)
      @config ||= Config.new
      yield @config if block_given?
      @config
    end
  end
end
