require "active_record/fixtures"

class CreatePayTypes < ActiveRecord::Migration
  def self.up
    create_table :pay_types do |t|
      t.string :value
      t.string :description

      t.timestamps
    end
    
    
    directory = File.dirname(__FILE__) + "/origin_data/"
     data = Dir.entries(directory).map {|file| file.end_with?(".yml") ? file[0...-4] : nil }.compact
     Fixtures.create_fixtures(directory, data)

  end

  def self.down
    drop_table :pay_types
  end
end
