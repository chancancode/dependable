require 'tilt'

Dir.mkdir(File.join(Rails.root, 'tmp')) rescue nil

class CustomTemplate < Tilt::Template
  VERSION = 1

  CONFIG_FILE_PATH = File.join(Rails.root, 'tmp', 'custom.txt')

  self.default_mime_type = 'application/javascript'

  def prepare; end

  def evaluate(context, locals, &block)
    context.depend_on(__FILE__)
    context.depend_on(CONFIG_FILE_PATH)

    %{
        alert("Generated " + ((Date.now() - #{Time.now.to_i * 1000}) / 1000) + " seconds ago");
        alert("VERSION is #{VERSION}");
        alert("Config value is <#{Rails.configuration.custom}>");
        #{data}
    }
  end
end

File.open( CustomTemplate::CONFIG_FILE_PATH, 'w' ) { |f| f.puts Rails.configuration.custom.inspect }

Rails.application.assets.register_engine '.custom', CustomTemplate
