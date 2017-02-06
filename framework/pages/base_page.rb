require 'selenium-webdriver'
require 'selenium-webdriver.wait'
require 'json'

class BasePage
  def initialize(driverType)
    @driver
    @wait
    @options

    load_config_json()

    case driverType
      when 'Chrome'
        @options = webdriver.ChromeOptions()
        @options.add_argument("--start-maximized")
        @driver = webdriver.Chrome(executable_path=self.config['chromeDriverPath'], chrome_options=options)
      else
        raise 'driver not supported'
    end

    # navigate to base page
    @driver.get(@config['appPath'])
    @wait = Wait(@driver, @config['defaultTimeout'])
  end

  def load_config_json
    # Loads json based settings file and parses it as json into property _config
    path_to_config = '../settings.JSON'
    file = File.read(path_to_config)
    @config = JSON.parse(file)
  end

  def take_screenshot(name)
    @driver.get_screenshot_as_file('./{}.png'.format(name))
  end
end