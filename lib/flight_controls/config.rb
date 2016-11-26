require 'yaml'

module FlightControls
  class Config
    attr_reader :controls

    def initialize(config_file_path = './config.yml')
      config = YAML.load(File.open(config_file_path))
      @controls = config['controls'].map do |c|
        Control.from_yaml(c, config['default_mode'])
      end
    end
  end
end
