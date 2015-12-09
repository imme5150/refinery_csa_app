module Refinery
  module Pages
    MenuPresenter.class_eval do
      def to_html
        render_menu_items(roots) if roots.present?
      end
      private
      def render_menu_item_link(menu_item)
        link_to(context.refinery.url_for(menu_item.url), :class => link_tag_css) do
          buffer = ActiveSupport::SafeBuffer.new
          buffer << content_tag(:i, '', class:"fa fa-#{menu_item.title.parameterize}")
          buffer << menu_item.title
          buffer
        end
      end

      def find_url_for(item)
        if item.url.respond_to?(:keys) && item.url[:path].present?
          url = [item.url]
          url << ['', item.url[:path]].compact.flatten.join('/')
          url.last.match(%r{^/#{::I18n.locale.to_s}(/.*)}) ? $1 : url.detect{ |u| u.is_a?(String) }
        else
          "/pages/#{item.url[:id]}"
        end
      end
    end
  end
end
