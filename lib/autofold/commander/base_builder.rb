module Autofold
  class Commander
    class BaseBuilder < Thor
      attr_accessor :project_name, :destination
      include Thor::Actions
      class << self
        def source_root
          File.expand_path("../../templates/base", __FILE__)
        end

        def from_project_name(project_name)
          lambda { start ["build", project_name] }
        end
      end

      desc "build [project_name]", "builds a project base"
      def build(project_name)
        self.project_name = project_name
        directory _base_root, File.join(Dir.pwd, project_name)
      end

      private
      def _base_root
        self.class.source_root
      end
    end
  end
end