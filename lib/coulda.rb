module Coulda
  SyntaxError = Class.new(StandardError)
end

require 'pending'
require 'coulda/feature'
require 'coulda/scenario'

module Kernel
  def Feature(name, &block)
    f = Feature.for_name(name)
    f.class_eval(&block)
    f.assert_description
    f
  end
end
