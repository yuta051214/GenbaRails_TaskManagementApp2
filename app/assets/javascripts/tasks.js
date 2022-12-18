document.addEventListener("turbolinks:load", function(){
  // カーソルを乗せると色が変わる
  document.querySelectorAll('td').forEach(function(td){
    td.addEventListener('mouseover', function(e){
      e.currentTarget.style.backgroundColor = '#eff';
    });

    td.addEventListener('mouseout', function(e){
      e.currentTarget.style.backgroundColor = '';
    });
  });

  // // 削除した際にページ遷移しない
  // document.querySelectorAll('.delete').forEach(function(a){
  //   a.addEventListener('ajax:success', function(){
  //     var td = a.parentNode;
  //     var tr = td.parentNode;
  //     tr.style.display = 'none';
  //   });
  // });
});
