module Spree
  module Admin
    class LabelsController < ResourceController
      def index
        session[:return_to] = request.url
        respond_with @collection
      end

      def collection
        return @collection if @collection.present?
        params[:q] ||= {}
        @collection = super
        # @search needs to be defined as this is passed to search_form_for
        Ransack.options[:ignore_unknown_conditions] = false
        @search = @collection.ransack(params[:q])
        @collection = @search.result.
            page(params[:page]).
            per(params[:per_page] || Spree::Config[:admin_products_per_page])
        @collection
      end
    end
  end
end