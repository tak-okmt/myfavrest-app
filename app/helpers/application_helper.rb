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

    # 年代計算
    def age_calc(birth_ym)
        age = (Date.today.strftime("%Y%m%d").to_i - birth_ym.strftime("%Y%m%d").to_i) / 10000
        if age < 10
            return "10代未満"
        elsif
            disp_ages = age / 10
            return "#{disp_ages}0代"
        end
    end

    # ユーザ情報に関するコードのIDから名称を表示する
    def user_code_name(id, code)
        name = Code.find_by(code_id: id,code: code).name
    end

end
