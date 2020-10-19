// Prefectureセレクトボックスに連動してCityセレクトボックスを変更する
$(document).on('change', '#q_prefecture_code_eq_any', function() {
    return $.ajax({
        type: 'GET',
        url: '/communities/area_select',
        data: {
            prefecture_id: $(this).val()
        }
    }).done(function(data) {
        return $('#q_area_eq_any').html(data);
    });
});