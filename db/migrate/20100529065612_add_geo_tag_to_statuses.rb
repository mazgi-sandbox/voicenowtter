class AddGeoTagToStatuses < ActiveRecord::Migration
  def self.up
    add_column :statuses, :geo_tag, :text
  end

  def self.down
    remove_column :statuses, :geo_tag
  end
end
