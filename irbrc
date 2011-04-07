#def Object.method_added(method)
#  return super(method) unless method == :helper
#  (class<<self;self;end).send(:remove_method, :method_added)
#
#  def helper(*helper_names)
#    returning $helper_proxy ||= Object.new do |helper|
#      helper_names.each { |h| helper.extend "#{h}_helper".classify.constantize }
#    end
#  end
#
#  helper.instance_variable_set("@controller", ActionController::Integration::Session.new)
#
#  def helper.method_missing(method, *args, &block)
#    @controller.send(method, *args, &block) if @controller && method.to_s =~ /_path$|_url$/
#  end
#
#  helper :application rescue nil
#end if ENV['RAILS_ENV']

#require 'rubygems'
##require 'wirble' # colorized irb repl
#Wirble.init
#Wirble.colorize

#require 'bond' # fancy autocopmletion
#Bond.start

#require 'interactive_editor'

#require 'logger'
#if ENV.include?('RAILS_ENV') && !Object.const_defined?('RAILS_DEFAULT_LOGGER')
#    Object.const_set('RAILS_DEFAULT_LOGGER', Logger.new(STDOUT))
#end

# def rails_routes # I always forget this
#   include ActionController::UrlWriter
#  default_url_options[:host] = 'whatever'
# end
