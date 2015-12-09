module Refinery
  module Admin
    PagesController.class_eval do
      def new
        @page = Page.new(new_page_params)
        Pages.default_parts_for(@page).each_with_index do |page_part, index|
          @page.parts << PagePart.new(:title => page_part, :slug => page_part, :position => index)
        end
        if params[:template].present?
          template_pages = Refinery::Page.where(slug:params[:template].to_s).order(:lft).to_a
          template_target, template_source = template_pages.first, template_pages.last
          if template_source
            @page.parts.first.body = template_source.parts.first.body
            if template_target
              @page.parent_id = template_target.id
              @possible_parents = template_target.self_and_descendants.where('"refinery_pages"."rgt" - "refinery_pages"."lft" > 1')
            end
          end
        end
      end

      protected
      def permitted_page_params
        [
          :browser_title, :draft, :link_url, :menu_title, :meta_description,
          :parent_id, :skip_to_first_child, :show_in_menu, :title, :view_template,
          :layout_template, :custom_slug, :alphabetize_child_pages,
          parts_attributes: [:id, :title, :slug, :body, :position]
        ]
      end

    end
  end
end
