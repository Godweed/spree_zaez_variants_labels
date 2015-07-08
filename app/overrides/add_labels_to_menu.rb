Deface::Override.new virtual_path: 'spree/admin/shared/sub_menu/_product',
                     name: 'add_labels_to_menu',
                     insert_bottom: '[data-hook="admin_product_sub_tabs"]',
                     text: '<%= tab :labels %>'