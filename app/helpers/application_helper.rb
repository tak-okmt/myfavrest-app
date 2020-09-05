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

    # コードのIDからコード名称を表示する
    def user_code_name(id, code)
        name = Code.find_by(code_id: id,code: code).name
    end

    # ユーザのグループにおける権限を取得
    def user_admin_flg(user, community)
        flg = Belonging.find_by(user_id:user.id,community_id:community.id) if user
        flg.admin_flg  if flg
    end

    # 各グループの所属人数を算出
    def community_member_calc(community)
        num = Belonging.where(community_id:community.id).count
    end

    # 各グループ内の口コミ総件数を算出
    def community_comment_calc(community)
        num = 0
        community.posts.each do |post|
            num = num + post.comments.count
        end
        return num
    end

    # グループの作成者ユーザオブジェクト取得
    def get_create_user(community)
        User.find(community.create_user_id)
    end

end
