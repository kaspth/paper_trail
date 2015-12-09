require 'singleton'
require 'paper_trail/serializers/yaml'

module PaperTrail
  class Config
    include Singleton
    attr_accessor :timestamp_field, :serializer, :version_limit
    attr_reader :serialized_attributes # Kept around for backwardscompatibility
    attr_writer :track_associations

    def initialize
      @timestamp_field = :created_at
      @serializer      = PaperTrail::Serializers::YAML
    end

    def track_associations
      @track_associations.nil? ?
        PaperTrail::VersionAssociation.table_exists? :
        @track_associations
    end
    alias_method :track_associations?, :track_associations

    # Indicates whether PaperTrail is on or off.
    def enabled
      PaperTrail.paper_trail_store[:paper_trail_enabled].nil? || PaperTrail.paper_trail_store[:paper_trail_enabled]
    end

    def enabled= enable
      PaperTrail.paper_trail_store[:paper_trail_enabled] = enable
    end
  end
end
