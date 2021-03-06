require 'rake'

namespace :coulda do
  desc "Print all features as plain text"
  task :print_features do

    $LOAD_PATH.unshift("test")

    require 'test/unit'

    # bug in test unit.  Set to true to stop from running.
    Test::Unit.run = true

    require 'coulda'

    test_files = Dir.glob(File.join('test', '**', '*_test.rb'))
    test_files.each do |file|
      load file
    end

    Coulda::World.features.each do |feature, name|
      puts "Feature: #{name}"
      puts "  In order to #{feature.in_order_to}" if feature.in_order_to
      puts "  As a #{feature.as_a}" if feature.as_a
      puts "  I want to #{feature.i_want_to}" if feature.i_want_to
      feature.scenarios.each do |scenario|
        puts
        print "  "
        print "(**PENDING**) " if scenario.pending?
        puts "Scenario: #{scenario.name}"
        scenario.statements.each do |stmt|
          print "    "
          print "(**PENDING**) " unless stmt[:block]
          puts "#{stmt[:type].to_s} #{stmt[:text]}"
        end
      end
      puts
    end
  end
end
