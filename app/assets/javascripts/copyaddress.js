function copy() {
    let text = document.getElementById('address');
    text.select();
    document.execCommand('copy');
    if (text.value.trim()){
        alert('コピーしました');
    }else{
        alert('文字が入力されていません');
    }
}