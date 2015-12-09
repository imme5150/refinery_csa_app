module Refinery
  module Search
    SearchEngine.class_eval do

      # Perform search over the specified models
      def self.search(query)
        results = []

        if query.present?
          queries = [query, query.pluralize, query.singularize].uniq
          Refinery::Search.config.enable_for.each do |model|
            model = model.safe_constantize

            if model.respond_to?(:refinery_search_scope)
              queries.each do |query|
                results << model.refinery_search_scope.with_query(query)
              end
            else
              queries.each do |query|
                results << model.with_query(query)
              end
            end
          end
        end

        results.flatten.uniq
      end

    end
  end
end
