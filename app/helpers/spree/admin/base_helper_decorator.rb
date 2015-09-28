module Spree
  module Admin
    BaseHelper.class_eval do

      def render_label_color color
        content_tag :div, {class: 'variant-label', style: "background-color: #{color};" } do
          ''
        end
      end
    end
  end
end