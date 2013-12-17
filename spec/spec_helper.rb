require 'rack/test'

require File.expand_path '../../process.rb', __FILE__

module RSpecMixin
  include Rack::Test::Methods
  def app() Sinatra::Application end
end

# For RSpec 2.x
RSpec.configure { |c| c.include RSpecMixin }
# If you use RSpec 1.x you should use this instead:
Rspec.configure { |c| c.include RSpecMixin }