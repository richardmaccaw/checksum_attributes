module ChecksumAttributes
  module Generators
    class InstallGenerator < Rails::Generators::Base
      source_root File.expand_path("../../templates", __FILE__)

      def create_migration
        migration_template "create_checksum_attributes.rb", "db/migrate/#{timestamp}_create_checksum_attributes.rb"
      end

      private

      def timestamp
        Time.now.strftime("%Y%m%d%H%M%S")
      end
    end
  end
end 