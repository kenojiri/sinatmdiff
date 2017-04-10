require 'active_record'

configure :test, :development do
  ActiveRecord::Base.establish_connection(
    :adapter => 'sqlite3',
    :database => 'mds.db'
  )
end

configure :production do
  ActiveRecord::Base.establish_connection(ENV['DATABASE_URL'])
end

class Md < ActiveRecord::Base
#  def createdate
#    self.select('created_at').in_time_zone('Asia/Tokyo').strftime("%Y-%m-%d %H:%M:%S")
#  end
#  def updatedate
#    self.select('updated_at').in_time_zone('Asia/Tokyo').strftime("%Y-%m-%d %H:%M:%S")
#  end
end

class MdMigration < ActiveRecord::Migration
  def self.up
    create_table :mds do |t|
      t.text :markdown
      t.timestamps
    end
  end
end

MdMigration.new.up unless ActiveRecord::Base.connection.data_source_exists? 'mds'
