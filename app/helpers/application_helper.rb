module ApplicationHelper
  # ページごとの完全なタイトルを返す
  def full_title(page_title = '')
    base_title = "グルコミュ"
    if page_title.empty?
      base_title
    else
      page_title + " | " + base_title
    end
  end

  # リンクの動的制御
  def order_link_active(name, path, order)
    class_name =  if params[:comment_order].nil? && order == 'updated_at'
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
    age = (Time.zone.today.strftime("%Y%m%d").to_i - birth_ym.strftime("%Y%m%d").to_i) / 10_000
    if age < 10
      "10代未満"
    else
      "#{age / 10}0代"
    end
  end

  # コードのIDからコード名称を表示する
  def user_code_name(id, code)
    Code.find_by(code_id: id, code: code)&.name
  end

  # ユーザのグループにおける権限を取得
  def user_admin_flg(user, community)
    flg = Belonging.find_by(user_id: user.id, community_id: community.id) if user
    flg&.admin_flg
  end

  # 各グループの所属人数を算出
  def community_member_calc(community)
    Belonging.where(community_id: community.id).count
  end

  # 各グループ内の口コミ総件数を算出
  def community_comment_calc(community)
    num = 0
    community.posts.each do |post|
      num += post.comments.count
    end
    num
  end

  # グループの作成者ユーザオブジェクト取得
  def get_create_user(community)
    User.find(community.create_user_id)
  end

  # グループ内の店における一番多いタイプを取得
  def post_type_most(community, type)
    num = []
    community.posts.each do |p|
      num << p.prefecture_code if (type == '1') && p.prefecture_code.present? # エリア
      num << p.rest_type if (type == '2') && p.rest_type.present? # 店タイプ
    end
    unless num.empty?
      most = num.max_by { |v| num.count(v) }
      most_name = JpPrefecture::Prefecture.find(code: most).try(:name) if type == '1' # 都道府県コードから名称を取得
      most_name = user_code_name(type, most) if type == '2' # 店タイプコードから名称を取得
    end
    most_name
  end

  # 店舗ジャンルのclassを返す
  def rest_type_class(id)
    case id
    when "1"
      "rest-type-1"
    when "2"
      "rest-type-2"
    when "3"
      "rest-type-3"
    else
      "rest-type-null"
    end
  end
end
