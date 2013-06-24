module Autofold
  class Commander
    class CoreBuilder < Thor
      attr_accessor :project_name, :class_project_name,
        :child_name, :class_child_name, :qualified_child_name, 
        :parent_name, :class_parent_name, :qualified_parent_name
      include Thor::Actions
      class << self
        def source_root
          File.expand_path("../../templates", __FILE__)
        end

        # Attempts to create a parent-child resource.
        # Parent has :only => :show, :update, :destroy
        def from_path(path)
          lambda { |parent, child| start ["build", path, parent, child] }
        end
      end

      desc "build [PATH] [PARENT] [CHILD]", "builds or appends to a project a parent-child resource"
      def build(path, parent, child)
        _initialize_variables(path, parent, child)
        _directory path
      end

      private

      def source_root
        self.class.source_root
      end

      # Recursively copies files, injects into if file exists, else creates it
      def _directory(path)
        smart_directory "./", path
      end

      def _initialize_variables(path, parent, child)
        self.project_name = path.split("/").last
        self.class_project_name = project_name.camelcase.capitalize
        self.child_name = child
        self.class_child_name = child_name.camelcase.capitalize
        self.parent_name = parent
        self.class_parent_name = parent_name.camelcase.capitalize
        self.qualified_parent_name = [project_name, parent].map(&:camelcase).map(&:capitalize).join("::")
        self.qualified_child_name = [parent_name, child].map(&:camelcase).map(&:capitalize).join("::")
      end

    end
  end
end