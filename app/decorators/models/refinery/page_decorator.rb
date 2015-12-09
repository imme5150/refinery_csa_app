module Refinery
  Page.class_eval do
    after_update :alphabetize_after_update

    protected

    def move_to_new_parent
      if @move_to_new_parent_id.nil?
        move_to_root
      elsif @move_to_new_parent_id
        parent_page = Refinery::Page.find_by_id(@move_to_new_parent_id)
        if parent_page.try(:alphabetize_child_pages)
          move_to_ordered_child_of(parent_page, :title)
        else
          move_to_child_of(@move_to_new_parent_id)
        end
      end
    end

    private

    def alphabetize_children!
      self.children.includes(:translations).sort_by(&:title).each do |page|
        page.move_to_child_of(self)
      end
    end

    def alphabetize_after_update
      alphabetize_children! if alphabetize_child_pages && alphabetize_child_pages_changed?
      @move_to_new_parent_id = parent_id if parent.try(:alphabetize_child_pages)
    end
  end
end