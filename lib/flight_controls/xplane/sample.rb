module FlightControls::Xplane
  def self.test
    value, dref = ARGV
    # e.g.
    # value = 0.0
    # sim/electrical/battery_1_on[0]
    msg = DREFMessage.get_binary(value.to_f, dref)
    Logger.log_message(msg)
    c = Connection.new('127.0.0.1', 49000)
    c.send(msg)
  end
end