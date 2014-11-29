require 'tilt'

class CustomTemplate < Tilt::Template
  VERSION = 1

  self.default_mime_type = 'application/javascript'

  def prepare; end

  def evaluate(context, locals, &block)
    %{
        alert("Generated " + ((Date.now() - #{Time.now.to_i * 1000}) / 1000) + " seconds ago");
        alert("VERSION is #{VERSION}");
        alert("Config value is <#{Rails.configuration.custom}>");
        #{data}
    }
  end
end

Rails.application.assets.register_engine '.custom', CustomTemplate


