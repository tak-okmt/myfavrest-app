module ApplicationHelper

    # リンクの動的制御
    def order_link_active(name, path, order)
        class_name = if params[:comment_order].nil? && order == 'updated_at'
                        'mini-orange-link-btn'
                        elsif order == params[:comment_order]
                        'mini-orange-link-btn'
                        else
                        'mini-green-link-btn'
                        end
        link_to name, path + '?comment_order=' + order, class: class_name
    end

end
