require 'the_tracker/version'
require 'the_tracker/tracker'
require 'the_tracker/view_helpers'
require 'the_tracker/trackers/base'
require 'the_tracker/railtie' if defined? Rails
Dir.glob("#{File.dirname(__FILE__)}/the_tracker/trackers/*.rb").each do |f|
  require f
end
