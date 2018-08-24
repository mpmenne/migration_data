require 'rails'

def require_migration(migration_name)
  path = MigrationData::ActiveRecord::Migration.migration_dir
  all_migrations = ActiveRecord::MigrationContext.new(path).migrations

  migration_name += '.rb' unless migration_name.end_with?('.rb')
  file = all_migrations.detect do |m|
    m.filename.end_with?(migration_name)
  end

  raise LoadError, "cannot load such file -- #{migration_name}" unless file

  require Rails.root.join(file.filename)
end
